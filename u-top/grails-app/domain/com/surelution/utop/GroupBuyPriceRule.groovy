package com.surelution.utop

/**
 * 团购可能有一组价格规则，到达了某一数量执行某一价格
 * @author johnny
 *
 */
class GroupBuyPriceRule {

    static constraints = {
    }
	
	GroupProductPricePlan plan
	
	/**
	 * 最少客户数（包含）
	 */
	Integer amountFrom

	/**
	 * 最多客户数（不包含），如果是无上限，那就用一个超级大数表示就可以啦
	 */
	Integer amountTo

	/**
	 * 售价
	 */
	BigDecimal price
	
	/**
	 * 最终成交的价格
	 */
	Boolean settled = false
}
