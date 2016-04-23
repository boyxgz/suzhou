package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class GroupProductPricePlanController {

	def springSecurityService
	
    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [groupProductPricePlanInstanceList: GroupProductPricePlan.list(params), groupProductPricePlanInstanceTotal: GroupProductPricePlan.count()]
    }

    def create() {
        [groupProductPricePlanInstance: new GroupProductPricePlan(params)]
    }

    def save() {
		params.activedEndAt = params.date('activedEndAt','yyyy-MM-dd HH:mm')
		params.activedStartAt = params.date('activedStartAt','yyyy-MM-dd HH:mm')
		
        def groupProductPricePlanInstance = new GroupProductPricePlan(params)
		println groupProductPricePlanInstance.save(flush: true)
        if (!groupProductPricePlanInstance.save(flush: true)) {
            render(view: "create", model: [groupProductPricePlanInstance: groupProductPricePlanInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan'), groupProductPricePlanInstance.id])
        redirect(action: "show", id: groupProductPricePlanInstance.id)
    }

    def show(Long id) {
        def groupProductPricePlanInstance = GroupProductPricePlan.get(id)
        if (!groupProductPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        [groupProductPricePlanInstance: groupProductPricePlanInstance]
    }

    def edit(Long id) {
        def groupProductPricePlanInstance = GroupProductPricePlan.get(id)
        if (!groupProductPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        [groupProductPricePlanInstance: groupProductPricePlanInstance]
    }

    def update(Long id, Long version) {
		params.activedEndAt = params.date('activedEndAt','yyyy-MM-dd HH:mm')
		params.activedStartAt = params.date('activedStartAt','yyyy-MM-dd HH:mm')
		
        def groupProductPricePlanInstance = GroupProductPricePlan.get(id)
        if (!groupProductPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (groupProductPricePlanInstance.version > version) {
                groupProductPricePlanInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan')] as Object[],
                          "Another user has updated this GroupProductPricePlan while you were editing")
                render(view: "edit", model: [groupProductPricePlanInstance: groupProductPricePlanInstance])
                return
            }
        }

        groupProductPricePlanInstance.properties = params

        if (!groupProductPricePlanInstance.save(flush: true)) {
            render(view: "edit", model: [groupProductPricePlanInstance: groupProductPricePlanInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan'), groupProductPricePlanInstance.id])
        redirect(action: "show", id: groupProductPricePlanInstance.id)
    }

    def delete(Long id) {
        def groupProductPricePlanInstance = GroupProductPricePlan.get(id)
        if (!groupProductPricePlanInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan'), id])
            redirect(action: "list")
            return
        }

        try {
            groupProductPricePlanInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan'), id])
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
		println GroupProductPricePlan.createCriteria().list(){
			eq("class",GroupProductPricePlan)
		}
		def date = params.date('date', 'yyyy-MM-dd')
		def ppps
		if(date) {
//			ppps = GroupProductPricePlan.executeQuery("""
//				from ProductPricePlan p where p.activedStartAt <=? and activedEndAt > ? and onSale = ? and class = ? order by p.index
//			""", [date, date, true, GroupProductPricePlan])
			ppps = ProductPricePlan.createCriteria().list {
				and{
					eq("class", GroupProductPricePlan)
					gt("activedEndAt",date)
					le("activedStartAt",date)
					eq("onSale",true)
				}
			}
		}
		[groupProductPricePlanInstanceList:ppps]
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
		def plans = GroupProductPricePlan.createCriteria().list() {
			le('activedStartAt', from)
			ge('activedEndAt', from)
			eq('class',GroupProductPricePlan)
		}
		[plans:plans]
	}
}
