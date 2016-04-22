package com.surelution.utop

class Imprest {

    static constraints = {
		transactionNo uqnique:true
		confirmedAt nullable:true
		confirmedBy nullable:true
    }

	/**
	 * 转账流水号
	 */
	String transactionNo
	
	/**
	 * 转账金额
	 */
	BigDecimal amount
	
	/**
	 * 转账日期
	 */
	Date transferDate
	
	/**
	 * 上传日期
	 */
	Date dateCreated
	
	/**
	 * 财务管理岗确认时间
	 */
	Date confirmedAt
	
	/**
	 * 财务管理岗确认者
	 */
	User confirmedBy
	
	Boolean confirmed = false
}
