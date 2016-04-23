package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class ShelfProductPricePlanController {
	
	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [shelfProductPricePlanInstanceList: ShelfProductPricePlan.findByConfirmed(false), shelfProductPricePlanInstanceTotal: ShelfProductPricePlan.count()]
    }

    def create() {
        [shelfProductPricePlanInstance: new ShelfProductPricePlan(params)]
    }

    def save() {
		params.activedEndAt = params.date('activedEndAt','yyyy-MM-dd HH:mm')
		params.activedStartAt = params.date('activedStartAt','yyyy-MM-dd HH:mm')
        def shelfProductPricePlanInstance = new ShelfProductPricePlan(params)
		
        if (!shelfProductPricePlanInstance.save(flush: true)) {
            render(view: "create", model: [shelfProductPricePlanInstance: shelfProductPricePlanInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan'), shelfProductPricePlanInstance.id])
        redirect(action: "show", id: shelfProductPricePlanInstance.id)
    }

    def show(Long id) {
        def shelfProductPricePlanInstance = ShelfProductPricePlan.get(id)
        if (!shelfProductPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        [shelfProductPricePlanInstance: shelfProductPricePlanInstance]
    }

    def edit(Long id) {
        def shelfProductPricePlanInstance = ShelfProductPricePlan.get(id)
        if (!shelfProductPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        [shelfProductPricePlanInstance: shelfProductPricePlanInstance]
    }

    def update(Long id, Long version) {
        def shelfProductPricePlanInstance = ShelfProductPricePlan.get(id)
        if (!shelfProductPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (shelfProductPricePlanInstance.version > version) {
                shelfProductPricePlanInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan')] as Object[],
                          "Another user has updated this ShelfProductPricePlan while you were editing")
                render(view: "edit", model: [shelfProductPricePlanInstance: shelfProductPricePlanInstance])
                return
            }
        }

        shelfProductPricePlanInstance.properties = params

        if (!shelfProductPricePlanInstance.save(flush: true)) {
            render(view: "edit", model: [shelfProductPricePlanInstance: shelfProductPricePlanInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan'), shelfProductPricePlanInstance.id])
        redirect(action: "show", id: shelfProductPricePlanInstance.id)
    }

    def delete(Long id) {
        def shelfProductPricePlanInstance = ShelfProductPricePlan.get(id)
        if (!shelfProductPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        try {
            shelfProductPricePlanInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan'), id])
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
		[shelfProductPricePlanInstanceList:prices, operator:springSecurityService.currentUser]
	}
	
	def productPosition() {
		def date = params.date('date', 'yyyy-MM-dd')
		def ppps
		if(date) {
//			ppps = ProductPricePlan.executeQuery("""
//				from ProductPricePlan p where p.activedStartAt <=? and activedEndAt > ? and onSale = ? order by p.index
//			""", [date, date, true])
			ppps = ProductPricePlan.createCriteria().list {
				and{
					eq("class",ShelfProductPricePlan)
					le('activedStartAt',date)
					gt('activedEndAt',date)
					eq('onSale',true)
				}
			}
		}
		[shelfProductPricePlanInstanceList:ppps]
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
			eq('class',ShelfProductPricePlan)
		}
		[plans:plans]
	}
}
