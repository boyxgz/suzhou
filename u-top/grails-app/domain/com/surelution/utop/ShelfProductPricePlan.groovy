package com.surelution.utop

class ShelfProductPricePlan extends ProductPricePlan {

    static constraints = {
		price nullable:true
    }

	/**
	 * 售价
	 */
	BigDecimal price
}
