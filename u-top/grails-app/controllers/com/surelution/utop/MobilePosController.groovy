package com.surelution.utop

import grails.util.Holders

import com.surelution.utop.DeliveryTicket.DeliveryStatus
import com.surelution.utop.SaleOrder.SaleOrderStatus
import com.surelution.whistle.core.Auth2Util
import com.surelution.whistle.core.TemplateMessage
import com.surelution.whistle.core.Auth2Util.AuthScope

class MobilePosController {
	
	private Subscriber subscriber

	/**
	 * 自动登录
	 */
	def beforeInterceptor = {
		def userSn = request.getCookie('mobile-pos-sn')
		subscriber = MobilePosCookie.findBySubscriberSn(userSn)?.subscriber

		if(!subscriber) {
			def requestUrl = request.forwardURI
			def baseUrl = Holders.config.grails.serverURL
			def url = Auth2Util.buildRedirectUrl("${baseUrl}/subscriberPortal/mobilePosLogin", requestUrl, AuthScope.BASE)
			response.deleteCookie('mobile-pos-sn')
			redirect(url:url)
			return false
		}
		return true
	}

    def showOrder(Long id) {
		QrDelivery qrDelivery = QrDelivery.get(id)
		if(qrDelivery) {
			if(qrDelivery.userLogin.subscriber.id == subscriber.id) {
				DeliveryTicket ticket = qrDelivery.ticket
				if(ticket.status == DeliveryStatus.READY) {
					SaleOrder order = ticket.saleOrder
					def items = SaleOrderItem.findAllByOrder(order)
					return [saleOrder:order, orderItems:items, qrDelivery:qrDelivery]
				}
			}
		}
	}
	
	def delivery(Long id) {
		QrDelivery qrDelivery = QrDelivery.get(id)
		if(qrDelivery) {
			if(qrDelivery.userLogin.subscriber.id == subscriber.id) {
				def dt = qrDelivery.ticket
				if(dt.status == DeliveryStatus.READY) {
					def order = dt.saleOrder
					order.status = SaleOrderStatus.DELIVERED
					order.save(flush:true)
			
					dt.operator = qrDelivery.userLogin.user
					dt.operatorSubscriber =  subscriber
					dt.status = DeliveryStatus.DELIVERIED
					dt.deliveredAt = new Date()
					dt.save(flush:true)
					
					def tm = new TemplateMessage()
					tm.url = "${Holders.config.grails.serverURL}/shop2"
					tm.templateId = Holders.config.templateMessage.delivery_finished
					tm.toUser = order.subscriber.openId
					tm.addEntry("first", "您好，您的订单已经成功提货")
					tm.addEntry("keyword1", "${dt.sn}")
					tm.addEntry("keyword2", "${dt.operator.username}")
					tm.addEntry("keyword3", new Date().format("yyyy-MM-dd HH:mm"))
					tm.addEntry("remark", "如有疑问，请联系我们")
					tm.send()
					
					flash.message = "发货完成"
					def items = SaleOrderItem.findAllByOrder(order)
					return [saleOrder:order, orderItems:items]
				} else {
					flash.message = "发货失败，原因可能是有其他操作人员在同时进行发货"
				}
			}
			
		}
		return
	}
}
