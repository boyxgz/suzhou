package com.surelution.utop

/**
 * 产品的分类与价格计划之间的关联
 * @author <a href="mailto:guangzong.syu@gmail.com">guagnzong</a>
 *
 */
class PricePlanLabel {

    static constraints = {
		plan unique:'label'
    }
	ProductPricePlan plan
	ProductLabel label
	Date dateCreated
	
	public static findAllByLabelKey(String key) {
		PricePlanLabel.createCriteria().list() {
			def today = new Date()
			createAlias('label', 'l')
			createAlias('plan', 'p')
			createAlias('p.product', 'prod')
			eq('l.key', key)
			eq('p.confirmed', true)
			eq('p.onSale', true)
			le('p.activedStartAt', today)
			gt('p.activedEndAt', today)
			gt('p.index', 0)
			cache(true)
			order('p.index')
		}.collect(){it.plan}
	}
}
