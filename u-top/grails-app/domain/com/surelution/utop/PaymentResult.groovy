package com.surelution.utop

import com.surelution.whistle.core.pay.PaymentNotify

class PaymentResult {

    static constraints = {
    }
	
	String appId
	String bankType
	String cashFee
	String feeType
	String isSubscribe
	String mchId
	String nonceStr
	String openId
	String outTradeNo
	String resultCode
	String returnCode
	String sign
	String timeEnd
	String totalFee
	String tradeType
	String transactionId
	
	public static PaymentResult build(PaymentNotify n) {
		PaymentResult pr = new PaymentResult()
		pr.appId = n.appId
		pr.bankType = n.bankType
		pr.cashFee = n.cashFee
		pr.feeType = n.feeType
		pr.isSubscribe = n.isSubscribe
		pr.mchId = n.mchId
		pr.nonceStr = n.nonceStr
		pr.openId = n.openId
		pr.outTradeNo = n.outTradeNo
		pr.resultCode = n.resultCode
		pr.returnCode = n.returnCode
		pr.sign = n.sign
		pr.timeEnd = n.timeEnd
		pr.totalFee = n.totalFee
		pr.tradeType = n.tradeType
		pr.transactionId = n.transactionId
		return pr
	}
}
