package com.surelution.utop

import com.surelution.utop.SaleOrder.SaleOrderStatus;

class SaleOrderItem {

    static constraints = {
		settlementPrice nullable:true
		product nullable:true
    }

	static mapping = {
		order column:"_order"
		deleted defaultValue:false
	}

	SaleOrder order
	Product product
	Integer itemCount
	BigDecimal settlementPrice
	Boolean deleted
	ProductPricePlan plan
	
	/**
	 * 把已经过期的order item 移除
	 * @param order
	 */
	public static void checkItems(SaleOrder so) {
		if(so && so.status == SaleOrderStatus.NEW) {
			def now = new Date()
			def items = SaleOrderItem.executeQuery("""
				from SaleOrderItem soi where soi.order = ? and (soi.plan.activedStartAt> ? or soi.plan.activedEndAt <= ?)
			""", [so, now, now])
			items.each {
				it.delete(flush:true)
			}
		}
	}
}
