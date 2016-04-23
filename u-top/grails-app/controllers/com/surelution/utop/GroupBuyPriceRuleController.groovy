package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class GroupBuyPriceRuleController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [groupBuyPriceRuleInstanceList: GroupBuyPriceRule.list(params), groupBuyPriceRuleInstanceTotal: GroupBuyPriceRule.count()]
    }

    def create() {
        [groupBuyPriceRuleInstance: new GroupBuyPriceRule(params)]
    }

    def save() {
        def groupBuyPriceRuleInstance = new GroupBuyPriceRule(params)
        if (!groupBuyPriceRuleInstance.save(flush: true)) {
            render(view: "create", model: [groupBuyPriceRuleInstance: groupBuyPriceRuleInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule'), groupBuyPriceRuleInstance.id])
        redirect(action: "show", id: groupBuyPriceRuleInstance.id)
    }

    def show(Long id) {
        def groupBuyPriceRuleInstance = GroupBuyPriceRule.get(id)
        if (!groupBuyPriceRuleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule'), id])
            redirect(action: "list")
            return
        }

        [groupBuyPriceRuleInstance: groupBuyPriceRuleInstance]
    }

    def edit(Long id) {
        def groupBuyPriceRuleInstance = GroupBuyPriceRule.get(id)
        if (!groupBuyPriceRuleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule'), id])
            redirect(action: "list")
            return
        }

        [groupBuyPriceRuleInstance: groupBuyPriceRuleInstance]
    }

    def update(Long id, Long version) {
        def groupBuyPriceRuleInstance = GroupBuyPriceRule.get(id)
        if (!groupBuyPriceRuleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (groupBuyPriceRuleInstance.version > version) {
                groupBuyPriceRuleInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule')] as Object[],
                          "Another user has updated this GroupBuyPriceRule while you were editing")
                render(view: "edit", model: [groupBuyPriceRuleInstance: groupBuyPriceRuleInstance])
                return
            }
        }

        groupBuyPriceRuleInstance.properties = params

        if (!groupBuyPriceRuleInstance.save(flush: true)) {
            render(view: "edit", model: [groupBuyPriceRuleInstance: groupBuyPriceRuleInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule'), groupBuyPriceRuleInstance.id])
        redirect(action: "show", id: groupBuyPriceRuleInstance.id)
    }

    def delete(Long id) {
        def groupBuyPriceRuleInstance = GroupBuyPriceRule.get(id)
        if (!groupBuyPriceRuleInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule'), id])
            redirect(action: "list")
            return
        }

        try {
            groupBuyPriceRuleInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule'), id])
            redirect(action: "show", id: id)
        }
    }
}
