package com.surelution.utop

class ProductPricePlan {

    static constraints = {
		confirmedAt nullable:true
		confirmedBy nullable:true
		productPicId nullable:true
    }
	
	static mapping = {
		index column:'_index'
	}
	
	/**
	 * 产品信息
	 */
	Product product
	BigDecimal price
	
	/**
	 * 价格执行开始时间（包含）
	 */
	Date activedStartAt
	
	/**
	 * 价格执行结束时间（不包含）
	 */
	Date activedEndAt
	
	/**
	 * 温州公司叫货价（当期）
	 */
	BigDecimal costPrice
	
	/**
	 * 便利店货柜价
	 */
	BigDecimal retailPrice
	
	/**
	 * 申请价格时间
	 */
	Date dateCreated
	
	/**
	 * 零售管理岗确认时间
	 */
	Date confirmedAt
	
	/**
	 * 零售管理岗确认者
	 */
	User confirmedBy
	
	/**
	 * 是否被零售管理岗确认
	 */
	Boolean confirmed = false
	
	/**
	 * 确认后，也可以将该产品下架
	 */
	Boolean onSale = false

	Integer index = 0

	Long productPicId

	Boolean validBy(Date date) {
		activedStartAt <= date && activedEndAt > date
	}
}
