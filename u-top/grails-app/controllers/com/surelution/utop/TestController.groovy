package com.surelution.utop

class TestController {

    def index() {
		SaleOrderItem.list().each {item->
			ProductPricePlan plan = ProductPricePlan.findByProduct(item.product)
			item.plan = plan
			item.save(flush:true)
		}
	}
}
