package com.surelution.utop

import grails.converters.JSON
import grails.util.Holders

import java.text.SimpleDateFormat

import org.apache.commons.lang3.RandomUtils

import com.surelution.utop.DeliveryTicket.DeliveryStatus
import com.surelution.utop.Payment.PaymentStatus
import com.surelution.utop.SaleOrder.SaleOrderStatus
import com.surelution.utop.Voucher.VoucherStatus
import com.surelution.whistle.core.Auth2Util
import com.surelution.whistle.core.Configure
import com.surelution.whistle.core.TemplateMessage
import com.surelution.whistle.core.Auth2Util.AuthScope
import com.surelution.whistle.core.pay.MchInfo
import com.surelution.whistle.core.pay.PaymentSignParams
import com.surelution.whistle.core.pay.UnifiedOrderResponse
import com.surelution.whistle.core.pay.Payment.TradeType
import com.surelution.whistle.push.qrcode.QrCode

class ShopController {
	
	def saleOrderService
	
	private Subscriber subscriber

	/**
	 * 自动登录
	 */
	def beforeInterceptor = {
		def userSn = request.getCookie('user-sn')
		subscriber = SubscriberCookie.findBySubscriberSn(userSn)?.subscriber
		
		if(!subscriber) {
			def requestUrl = request.forwardURI
			def baseUrl = Holders.config.grails.serverURL
			def url = Auth2Util.buildRedirectUrl("${baseUrl}/subscriberPortal/autoLogin", requestUrl, AuthScope.BASE)
			response.deleteCookie('user-sn')
			redirect(url:url)
			return false
		}
		return true
	}

	/**
	 * 商城首页，商品列表等
	 * @return
	 */
    def index() {
		def today = new Date().clearTime()
		def ppps = ProductPricePlan.createCriteria().list{
			eq('confirmed', true)
			eq('onSale', true)
			le('activedStartAt', today)
			gt('activedEndAt', today)
			gt('index', 0)
			cache(true)
			createAlias('product', 'p')
			order('index')
		}
//		def ppps = ProductPricePlan.executeQuery("""
//			select ppp, ppp.product, pp.picture.id from ProductPricePlan ppp, ProductPicture pp 
//			where pp.product=ppp.product and ppp.confirmed=? and ppp.onSale=? 
//			and ppp.activedStartAt <= ? and ppp.activedEndAt > ?
//			group by ppp
//			having pp.picture.index
//		""", [true, true, today, today])
		
		
//		println p
//		def products = Product.createCriteria().list() {
//			eq('onSale', true)
//			order('index')
//		}
		def newOrder = saleOrderService.findNewOrder(subscriber)
		SaleOrderItem.checkItems(newOrder)
		[ppps:ppps, newOrder:newOrder]
	}

	/**
	 * 商品详情页
	 * @param id
	 * @return
	 */
	def 'product'(Long id) {
		def pricePlan = ProductPricePlan.get(id)
		def product = pricePlan.product
		def pictures = ProductPicture.findAllByProduct(product)
		[pricePlan:pricePlan, product:product, pictures:pictures]
	}

	/**
	 * 显示购物车列表
	 * @return
	 */
	def cart() {
		def now = new Date()
		def voucherId = params.voucherId
		def inCart = params.inCart //判断链接来自购物车内还是外部跳入，为了当从外面条入时默认选中voucher
		def selectedVoucher
		if(inCart != "1") {
			def vs = Voucher.findAllBySubscriber(subscriber)?.collect(){sv->
				if(sv.enabled &&
					sv.status == VoucherStatus.NEW &&
					sv.expiredAt >= new Date()) {
					return sv
				}
			}
			if(vs && vs.size() > 0) {
				voucherId = vs.get(0)?.id
			}
		}
		if(voucherId) {
			Voucher sv = Voucher.get(voucherId)
			if(sv && sv.enabled && 
				sv.status == VoucherStatus.NEW && 
				sv.expiredAt >= new Date() &&
				sv.subscriber.id == subscriber.id) {
				selectedVoucher = sv
			}
		}
		def vouchers = Voucher.findAllBySubscriberAndEnabledAndStatusAndExpiredAtGreaterThan(subscriber, true, VoucherStatus.NEW, new Date())
		
		def newOrder = saleOrderService.findNewOrder(subscriber)
		def orderItems
		def shouldPay = 0
		if(newOrder) {
			SaleOrderItem.checkItems(newOrder)
			orderItems = SaleOrderItem.findAllByOrderAndDeleted(newOrder, false)
			shouldPay = orderItems?.sum{(it.plan?.price) * it.itemCount }
		}
		
		if(shouldPay && selectedVoucher) {
			shouldPay = shouldPay - selectedVoucher.amount
			if(shouldPay < 0) {
				shouldPay = 0
			}
		}
		
		[newOrder:newOrder, orderItems:orderItems, vouchers:vouchers, selectedVoucher:selectedVoucher, shouldPay:shouldPay]
	}

	/**
	 * ajax方式往购物车中添加商品
	 * @param id
	 * @return
	 */
	def addCart(Long id) {
		def pricePlan = ProductPricePlan.get(id)
		def product = pricePlan?.product
		def succeed = false
		def order
		if(subscriber && product) {
			order = saleOrderService.addProduct(subscriber, pricePlan, 1)
			succeed = true
		}
		render([succeed:succeed, itemCount:order?order.itemCount:0] as JSON)
	}

	/**
	 * 在购物车中删除一个条目
	 * @param id
	 * @return
	 */
	def deleteCart(Long id) {
		def orderItem = SaleOrderItem.get(id)
		saleOrderService.updateCart(subscriber, orderItem, 0, true)
		redirect(action:'cart')
	}

	/**
	 * 修改购物车中条目的数量
	 * @param id
	 * @return
	 */
	def updateCart(Long id) {
		def orderItem = SaleOrderItem.get(id)
		def newCount = params.int('newCount')
		if(!newCount) {
			newCount = 0
		}
		if(newCount < 0) {
			newCount = -newCount
		}
		saleOrderService.updateCart(subscriber, orderItem, newCount)
		redirect(action:'cart')
	}

	/**
	 * 
	 * @return
	 */
	def addProductToCart(Long id) {
		def plan = ProductPricePlan.get(id)
		def qty = params.int('qty')
		if(!qty) {
			qty = 0
		}
		if(qty < 0) {
			qty = -qty
		}
		saleOrderService.addProduct(subscriber, plan, qty)
		redirect(action:'cart')
	}

	def confirmOrder() {
		def stationId = params.long('station.id')
		def selectVouchers = params.list('selectVouchers')
		def selectVoucher
		selectVouchers?.each() {
			Voucher v = Voucher.get(it)
			if(v && v.couldPay) {
				selectVoucher = v
			}
		}
		def station = Station.get(stationId)
		def newOrder = saleOrderService.findNewOrder(subscriber)
		newOrder.station = station
		newOrder.amount = newOrder.supposedAmount
		newOrder.save(flush:true)
		def orderItems
		def shouldPay = 0
		if(newOrder) {
			SaleOrderItem.checkItems(newOrder)
			orderItems = SaleOrderItem.findAllByOrderAndDeleted(newOrder, false)
			orderItems.each {item->
				item.settlementPrice = item.plan.price
				item.save(flush:true)
			}
			shouldPay = orderItems?.sum{(it.plan.price) * it.itemCount }
		}
		
		if(selectVoucher) {
			shouldPay -= selectVoucher.amount
		}
		if(shouldPay < 0) {
			shouldPay = 0
		}
		[newOrder:newOrder, orderItems:orderItems, selectVoucher:selectVoucher, shouldPay:shouldPay]
	}

	def preOrder(Long id) {
		//TODO 应该挪到service中去做，加上transaction
		SaleOrder order = SaleOrder.get(id)
		
		//系统是否允许支付
		def payPermit = AppVar.findByKey("PAY-PERMIT")?.value == "1"
		if(order.status == SaleOrderStatus.NEW && payPermit) {
			Voucher selectVoucher
			if(params.useVoucher) {
				Voucher sv = Voucher.get(params.useVoucher)
				if(sv.subscriber.id == subscriber.id) {
					if(sv.couldPay) {
						selectVoucher = sv
					}
				}
			}

			def shouldPay = order.amount
			
			if(selectVoucher) {
				shouldPay -= selectVoucher.amount
				if(shouldPay < 0) {
					shouldPay = 0
				}
				if(shouldPay == 0) {
					selectVoucher.writeOff = order.amount
				} else {
					selectVoucher.writeOff = selectVoucher.amount
				}
				selectVoucher.status = VoucherStatus.QUERIED_TO_USE
				selectVoucher.order = order
				selectVoucher.save(flush:true)
			}
			
			def payment = Payment.findByOrder(order)
			if(!payment) {
				payment = new Payment()
				payment.order = order
				payment.subscriber = subscriber
				payment.amount = shouldPay * 100
				payment.save()
			}
	
			if(payment.status == PaymentStatus.NEW) {
				if(payment.amount > 0) {
					order.status = SaleOrderStatus.QUERYED_TO_PAY
					order.save(flush:true)
					com.surelution.whistle.core.pay.Payment p = new com.surelution.whistle.core.pay.Payment("优米订单", payment.tradeNo, payment.amount)
					p.openId = order.subscriber.openId
					p.productId = id
					p.tradeType = TradeType.JSAPI
					UnifiedOrderResponse resp = p.unifyOrder()

					def prepayId = resp.prepayId

					def appId = Configure.config().appid
					def timeStamp = String.valueOf((int)(System.currentTimeMillis() / 1000))
					def nonceStr = String.valueOf(RandomUtils.nextLong(10000000, 9999999999999999))
					def signType = "MD5"
	
					def mchInfo = MchInfo.config()
	
					PaymentSignParams pa = new PaymentSignParams()
					pa.add("appId", appId)
					pa.add("timeStamp", timeStamp)
					pa.add("nonceStr", nonceStr)
					pa.add("package", "prepay_id=${prepayId}")
					pa.add("signType", signType)
					pa.apiKey = mchInfo.apiKey
					def paySign = pa.sign
	
					render([valid:true,
						needPay:true,
						appId:appId,
						timeStamp:timeStamp,
						nonceStr:nonceStr,
						pkg:"prepay_id=${prepayId}",
						signType:signType,
						paySign:paySign] as JSON)
				} else {
					//TODO 如果不需要支付
					DeliveryTicket dt = new DeliveryTicket()
					dt.saleOrder = order
					dt.status = DeliveryStatus.READY
					dt.subscriber = subscriber
					dt.save(flush:true)
					order.status = SaleOrderStatus.PAID
					order.save(flush:true)
					
					selectVoucher.status = VoucherStatus.USED
					
					def tm = new TemplateMessage()
					tm.url = "${Holders.config.grails.serverURL}/redirection/path/deliveryInfo"
					tm.templateId = "jC0FO0-KkTK7u9i1Mpk0R_Csc2F0g2d6nTstyxH6GRc"
					tm.toUser = order.subscriber.openId
					def items = SaleOrderItem.findAllByOrder(order)
					def sb = new StringBuffer("您已成功购买：")
					if(items) {
						items.each {item->
							sb.append(item.product.name)
							sb.append(",")
						}
					}
					tm.addEntry("name", sb.toString())
					tm.addEntry("remark","提货券号码是：${dt.wellLookSn}")
					tm.send()
					
					render([valid:true,
						needPay:false] as JSON)
				}
			}
		} else {
			render([valid:false] as JSON)
		}
	}

	def mobileReportPay(Long id) {
		SaleOrder order = SaleOrder.get(id)
		if(order &&
			order.subscriber.id == subscriber.id &&
			order.status == SaleOrderStatus.NEW) {
			order.status = SaleOrderStatus.PAID
			order.save(flush:true)
		}
		render([notifyStatus:true] as JSON)
	}

	def myOrders() {
		println subscriber.openId
		def tickets = DeliveryTicket.findAllBySubscriberAndStatus(subscriber, DeliveryStatus.READY)
		if(tickets?.size() == 1) {
			redirect(action:'showOrder', id:tickets[0].id)
			return
		}
		[tickets:tickets]
	}

	def showOrder(Long id) {
		def ticket = DeliveryTicket.get(id)
		def delivery
		def saleOrder
		def orderItems
		if(ticket) {
			if(ticket.subscriber.id != subscriber.id) {
				ticket = null
			} else {
				saleOrder = ticket.saleOrder
				if(saleOrder) {
					orderItems = SaleOrderItem.findAllByOrder(saleOrder)
				}
				if(ticket.status == DeliveryStatus.READY) {
					def hist = QrDelivery.findAllByTicketAndActived(ticket, Boolean.TRUE)
					hist.each {
						it.actived = false
						it.save(flush:true)
					}
					delivery = new QrDelivery()
					delivery.ticket = ticket
					delivery.save(flush:true)
				}
			}
		}
		[ticket:ticket, delivery:delivery, saleOrder:saleOrder, orderItems:orderItems]
	}
	
	def deliveryQr(Long id) {
		def delivery = QrDelivery.get(id)
		if(delivery 
			&& delivery.ticket.subscriber.id == subscriber.id
			&& delivery.ticket.status == DeliveryStatus.READY) {
			def content = QrCode.getTempQr(delivery.qrKey, 30 * 60 * 1000)
			response.outputStream << content
		}
	}

	def directShop(Long id) {
		def withGift = AppVar.findByKey("subscribing-with-gift")?.value
		if("1" == withGift) {
			def vt = VoucherType.findByKey("subscribing_voucher")
			def voucher = Voucher.findBySubscriberAndType(subscriber, vt)
			if(!voucher) {
				String giftAmount = AppVar.findByKey("subscribing-gift-amount")?.value
				String expiredAt = AppVar.findByKey("subscribing-gift-expired-at")?.value
				if(!giftAmount) {
					giftAmount = "4"
				}
				if(!expiredAt) {
					expiredAt = "20151001000000"
				}
				voucher = new Voucher()
				voucher.subscriber = subscriber
				voucher.type = vt
				voucher.amount = giftAmount as BigDecimal
				voucher.enabled = true
				SimpleDateFormat SDF = new SimpleDateFormat("yyyyMMddHHmmss")
				voucher.expiredAt = SDF.parse(expiredAt)
				voucher.save(flush:true)
			}
		}

		def now = new Date()
		def channelId = params.cid
		AdPageShoppingChannel channel = AdPageShoppingChannel.get(channelId)
		ProductPricePlan plan = ProductPricePlan.get(id)
		if(plan && plan.validBy(now)) {
			saleOrderService.addProduct(subscriber, plan, 1)
			if(channel) {
				def scanning = new AdPageScanning()
				scanning.subscriber = subscriber
				scanning.plan = plan
				scanning.channel = channel
				scanning.save(flush:true)
			}
			redirect(action:'cart')
		} else {
			redirect(action:'index')
		}
	}
}
