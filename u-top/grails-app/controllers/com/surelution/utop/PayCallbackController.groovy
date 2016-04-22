package com.surelution.utop

import grails.util.Holders

import javax.servlet.ServletInputStream

import com.surelution.utop.DeliveryTicket.DeliveryStatus
import com.surelution.utop.Payment.PaymentStatus
import com.surelution.utop.SaleOrder.SaleOrderStatus
import com.surelution.utop.Voucher.VoucherStatus
import com.surelution.whistle.core.TemplateMessage
import com.surelution.whistle.core.pay.PaymentNotify

class PayCallbackController {

	def notifyPay() {
		ServletInputStream is = request.inputStream
		PaymentNotify pn = new PaymentNotify()
		pn.notify(is)
		
		PaymentResult result = PaymentResult.build(pn)
		result.save(flush:true)

		if("SUCCESS" == pn.returnCode && "SUCCESS" == pn.resultCode) {
			boolean needNotify = false
			def payment = Payment.findByTradeNo(pn.outTradeNo)
			if(payment) {
				payment.status = PaymentStatus.PAID
				payment.confirmedFromWx = true
				payment.paymentResult = result
				payment.save(flush:true)

				//修改订单状态
				SaleOrder order = payment.order
				if(order.status != SaleOrderStatus.DELIVERED) {
					order.status = SaleOrderStatus.PAID
					order.save(flush:true)
				}

				//如果有抵用券，修改抵用券状态
				Voucher voucher = Voucher.findByOrder(order)
				if(voucher) {
					voucher.status = VoucherStatus.USED
					voucher.save(flush:true)
				}

				//生成提货单
				DeliveryTicket dt = DeliveryTicket.findBySaleOrder(order)
				if(!dt) {
					dt = new DeliveryTicket()
					dt.subscriber = order.subscriber
					dt.saleOrder = order
					needNotify = true
				}
				dt.status = DeliveryStatus.READY
				dt.save(flush:true)

				if(needNotify) {
					def tm = new TemplateMessage()
					tm.url = "${Holders.config.grails.serverURL}/redirection/path/deliveryInfo"
					tm.templateId = "jC0FO0-KkTK7u9i1Mpk0R_Csc2F0g2d6nTstyxH6GRc"
					tm.toUser = order.subscriber.openId
					def items = SaleOrderItem.findAllByOrder(order)
					def sb = new StringBuffer("您已成功购买：")
					if(items) {
						items.each {item->
							sb.append(item.plan.product.name)
							sb.append(",")
						}
					}
					tm.addEntry("name", sb.toString())
					tm.addEntry("remark","提货券号码是：${dt.wellLookSn}")
					tm.send()
				}
			}
		}

		def msg = '''
<xml>
   <return_code><![CDATA[SUCCESS]]></return_code>
   <return_msg><![CDATA[OK]]></return_msg>
</xml> 
'''
		render msg
	}
}
