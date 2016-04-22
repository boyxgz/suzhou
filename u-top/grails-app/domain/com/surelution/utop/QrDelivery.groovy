package com.surelution.utop

import grails.util.Holders

import com.surelution.utop.DeliveryTicket.DeliveryStatus;
import com.surelution.whistle.core.Attribute
import com.surelution.whistle.core.NewsAttribute

class QrDelivery extends TempQrCode {

    static constraints = {
		dateScanned nullable:true
		userLogin nullable:true
		dateConfirmed nullable:true
    }
	
	DeliveryTicket ticket
	
	Date dateScanned

	/**
	 * 被谁扫描的
	 */
	QrUserLogin userLogin
	Date dateConfirmed
	Boolean actived = true
	
	public Attribute scanedBy(Subscriber subscriber) {
		def login = QrUserLogin.findBySubscriberAndLoggedIn(subscriber, true)
		if(login) {
			if(ticket.status == DeliveryStatus.READY) {
				dateScanned = new Date()
				userLogin = login
				userLogin.save(flush:true)
				def so = ticket.saleOrder
				if(so) {
					def items = SaleOrderItem.findAllByOrder(so)
					
					def msg = new StringBuffer()
					if(items) {
						items.each {
							msg.append("\n[${it.plan.product.nameWithCount}，货号：${it.plan.product.code}]， X ${it.itemCount}")
						}
						msg.append("\n请触摸此处发货")
						def na = new NewsAttribute()
						na.add("成功扫描客户订单，提货单编号：${ticket.wellLookSn}",
							msg.toString(),
							"${Holders.config.grails.serverURL}/images/delivery.jpg",
							"${Holders.config.grails.serverURL}/mobilePos/showOrder/${id}")
						
						return na
					}
				}
			} else {
				return new Attribute(Attribute.KEY_Content, "提货券已经发货，请确认。如有问题，请联系系统管理员")
			}
		} else {
			return new Attribute(Attribute.KEY_Content, "您没有登录为发货员，请前往登录或联系系统管理员")
		}
		return new Attribute(Attribute.KEY_Content, "订单错误，请联系统管理员")
	}
}
