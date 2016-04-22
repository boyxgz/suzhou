package com.surelution.utop

import java.text.SimpleDateFormat;

class Payment {
	
	private static SimpleDateFormat SDF = new SimpleDateFormat("yyyyMMddHHmmss")

    static constraints = {
		tradeNo nullable:true
		order unique:true
		paymentResult nullable:true
    }

	static mapping = {
		order column:'_order'
		status column:'_status'
	}

	SaleOrder order
	
	/**
	 * 单位分
	 */
	Integer amount
	Date dateCreated
	Subscriber subscriber

	String tradeNo
	
	/**
	 * 记录用户端是否确认支付成功，是否确实支付成功，取决于其他字段
	 */
	PaymentStatus status = PaymentStatus.NEW
	
	/**
	 * 记录微信端是否确认收款
	 */
	Boolean confirmedFromWx = false
	
	/**
	 * 微信支付端发回的支付响应消息
	 */
	PaymentResult paymentResult

	def afterInsert() {
		tradeNo = SDF.format(new Date()) + id
	}

	enum PaymentStatus {
		NEW,
		PAID
	}
}
