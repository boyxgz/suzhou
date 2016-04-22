package com.surelution.utop

class OptimizingController {

	def index() {
		
	}
	
    def cacheDefaultPicture() {
		ProductPricePlan.list().each {ProductPricePlan p->
			p.productPicId = p.product.defaultPictureId
			p.save()
		}

		render(view:'index')
	}
}
