package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class ProductPricePlanController {
	
	def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
//		def dateFrom = params.date('dateFrom', 'yyyy-MM-dd HH:mm')
//		def dateTo = params.date('dateTo', 'yyyy-MM-dd HH:mm')
//		def productPricePlanInstanceList = ProductPricePlan.createCriteria().list() {
//			or{
//				and{
//					le('activedStartAt', dateFrom)
//					ge('activedEndAt', dateFrom)
//				}
//				and{
//					le('activedStartAt', dateTo)
//					ge('activedEndAt', dateTo)
//				}
//			}
//		}
		def productPricePlanInstanceList = ProductPricePlan.findAllByConfirmed(false)
        [productPricePlanInstanceList: productPricePlanInstanceList]
    }

    def create() {
        [productPricePlanInstance: new ProductPricePlan(params)]
    }

    def save() {
		params.activedEndAt = params.date('activedEndAt','yyyy-MM-dd HH:mm')
		params.activedStartAt = params.date('activedStartAt','yyyy-MM-dd HH:mm')
        def productPricePlanInstance = new ProductPricePlan(params)
        if (!productPricePlanInstance.save(flush: true)) {
            render(view: "create", model: [productPricePlanInstance: productPricePlanInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'productPricePlan.label', default: 'ProductPricePlan'), productPricePlanInstance.id])
        redirect(action: "show", id: productPricePlanInstance.id)
    }

    def show(Long id) {
        def productPricePlanInstance = ProductPricePlan.get(id)
        if (!productPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productPricePlan.label', default: 'ProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        [productPricePlanInstance: productPricePlanInstance]
    }

    def edit(Long id) {
        def productPricePlanInstance = ProductPricePlan.get(id)
        if (!productPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productPricePlan.label', default: 'ProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        [productPricePlanInstance: productPricePlanInstance]
    }

    def update(Long id, Long version) {
        def productPricePlanInstance = ProductPricePlan.get(id)
        if (!productPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productPricePlan.label', default: 'ProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (productPricePlanInstance.version > version) {
                productPricePlanInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'productPricePlan.label', default: 'ProductPricePlan')] as Object[],
                          "Another user has updated this ProductPricePlan while you were editing")
                render(view: "edit", model: [productPricePlanInstance: productPricePlanInstance])
                return
            }
        }

		params.activedEndAt = params.date('activedEndAt', 'yyyy-MM-dd HH:mm')
		params.activedStartAt = params.date('activedStartAt', 'yyyy-MM-dd HH:mm')
        productPricePlanInstance.properties = params

        if (!productPricePlanInstance.save(flush: true)) {
            render(view: "edit", model: [productPricePlanInstance: productPricePlanInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'productPricePlan.label', default: 'ProductPricePlan'), productPricePlanInstance.id])
        redirect(action: "show", id: productPricePlanInstance.id)
    }

    def delete(Long id) {
        def productPricePlanInstance = ProductPricePlan.get(id)
        if (!productPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productPricePlan.label', default: 'ProductPricePlan'), id])
            redirect(action: "list")
            return
        }
		
		if(productPricePlanInstance.confirmed) {
            flash.message = "已确认的价格不可删除！"
            redirect(action: "show", id:productPricePlanInstance.id)
            return
		}

        try {
            productPricePlanInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'productPricePlan.label', default: 'ProductPricePlan'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productPricePlan.label', default: 'ProductPricePlan'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def confirm(){
		def ids = params.list('id')
		def prices
		if(ids) {
			prices = ProductPricePlan.findAllByIdInList(ids.collect(){it as Long})
			prices.each {
				it.confirmed = true
				it.confirmedBy = springSecurityService.currentUser
				it.confirmedAt = new Date()
				it.save()
			}
		}
		[productPricePlanInstanceList:prices, operator:springSecurityService.currentUser]
	}
	
	def productPosition() {
		def date = params.date('date', 'yyyy-MM-dd')
		def ppps
		if(date) {
			ppps = ProductPricePlan.executeQuery("""
				from ProductPricePlan p where p.activedStartAt <=? and activedEndAt > ? and onSale = ? order by p.index
			""", [date, date, true])
		}
		[productPricePlanInstanceList:ppps]
	}
	
	def updateProductPosition() {
		params.each {
			String key = it.key
			if(key.startsWith("plan-id-")) {
				def planId = key.substring("plan-id-".length())
				def position = it.value
				ProductPricePlan plan = ProductPricePlan.get(planId)
				if(plan) {
					plan.index = position as Integer
					plan.save()
				}
			}
		}
		
		redirect(action:'productPosition')
	}
	
	def availablePlan() {
		def operation = params.operation
		if(operation == "add") {
			def planId = params.planId
			def labelId = params.labelId
			if(planId && labelId) {
				def plan = ProductPricePlan.get(planId)
				def label = ProductLabel.get(labelId)
				if(plan && label) {
					def planLabel = new PricePlanLabel()
					planLabel.plan = plan
					planLabel.label = label
					planLabel.save()
				}
			}
			
		} else if(operation == "remove") {
			def planLabelId = params.planLabelId
			if(planLabelId) {
				def planLabel = PricePlanLabel.get(planLabelId)
				if(planLabel) {
					planLabel.delete()
				}
			}
		}
		
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		if(!from)
			from = new Date()
		def plans = ProductPricePlan.createCriteria().list() {
			le('activedStartAt', from)
			ge('activedEndAt', from)
		}
		[plans:plans]
	}
}
