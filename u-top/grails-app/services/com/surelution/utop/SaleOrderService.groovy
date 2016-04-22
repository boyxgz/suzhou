package com.surelution.utop

import com.surelution.utop.Payment.PaymentStatus;
import com.surelution.utop.SaleOrder.SaleOrderStatus;

class SaleOrderService {

    def addProduct(Subscriber subscriber, ProductPricePlan plan, Integer itemCount) {
		def newOrders = SaleOrder.findAllBySubscriberAndStatus(subscriber, SaleOrderStatus.NEW)
		def order
		if(!newOrders || newOrders.size() <= 0) {
			order = new SaleOrder()
			order.status = SaleOrderStatus.NEW
			order.subscriber = subscriber
			order.save(flush:true)
		} else {
			//获取最近的新建订单
			order = newOrders.max {it.dateCreated}
		}
		
		def item
		def items = SaleOrderItem.findAllByOrderAndPlan(order, plan)
		if(!items || items.size() <= 0) {
			item = new SaleOrderItem()
			item.order = order
			item.plan = plan
			item.itemCount = 0
			item.deleted = false
		} else {
			item = items[0]
		}
		item.itemCount = item.itemCount + itemCount
		item.save(flush:true)

		return order
    }
	
	def findNewOrder(Subscriber subscriber) {
		def newOrders = SaleOrder.findAllBySubscriberAndStatus(subscriber, SaleOrderStatus.NEW)
		if(newOrders) {
			return newOrders[0]
		}
		return null
	}

	def updateCart(Subscriber subscriber, SaleOrderItem item, Integer newCount, Boolean deleteZeroItem = false) {
		boolean valid = false
		if(subscriber && item) {
			def order = item.order
			if(order.status == SaleOrderStatus.NEW && order.subscriber.id == subscriber.id) {
				valid = true
				if(deleteZeroItem) {
					item.delete(flush:true)
				} else {
					item.itemCount = newCount
					item.save(flush:true)
				}
			}
		}
		return valid
	}
	
	def preparePayment(Subscriber subscriber, SaleOrder order) {
		if(order.status == SaleOrderStatus.NEW) {
			def payment = new Payment()
			payment.order = order
			payment.amount = order.amount
			payment.subscriber = subscriber
			payment.status = PaymentStatus.NEW
			payment.save()
			order.status = SaleOrderStatus.QUERYED_TO_PAY
			order.save(flush:true)
		}
		
	}
}
