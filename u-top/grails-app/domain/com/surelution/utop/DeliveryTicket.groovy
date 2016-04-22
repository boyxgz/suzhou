package com.surelution.utop

import org.apache.commons.lang3.RandomUtils

import com.surelution.id.IDUtil

class DeliveryTicket {

    static constraints = {
		sn nullable:true
		saleOrder unique:true
		operator nullable:true
		deliveredAt nullable:true
		operatorSubscriber nullable:true
    }
	
	static transients = ['wellLookSn']
	
	def afterInsert() {
		long l = id * 100
		l += RandomUtils.nextInt(0, 100)
		StringBuilder sb = new StringBuilder()
		
		String sl = l.toString()
		(8 - sl.length()).times {
			sb.append("0")
		}
		sb.append(sl)
		sn = sb.toString()
	}

	String sn
	SaleOrder saleOrder

	Date dateCreated
	Subscriber subscriber

	DeliveryStatus status = DeliveryStatus.NEW
	
	User operator
	
	/**
	 * 有时，操作者可能是通过微信操作的
	 */
	Subscriber operatorSubscriber
	Date deliveredAt
	
	String getWellLookSn() {
		StringBuffer sb = new StringBuffer(sn)
		sb.insert(3, "-")
		sb.insert(7, "-")
		return sb.toString()
	}

	enum DeliveryStatus {
		NEW, //新创建
		READY, //支付完成，等待发货
		DELIVERIED //已发货
	}
}
