package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class RegisterPrizeController {
	
	def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [registerPrizeInstanceList: RegisterPrize.list(params), registerPrizeInstanceTotal: RegisterPrize.count()]
    }

    def create() {
        [registerPrizeInstance: new RegisterPrize(params)]
    }

    def save() {
        def registerPrizeInstance = new RegisterPrize(params)
        if (!registerPrizeInstance.save(flush: true)) {
            render(view: "create", model: [registerPrizeInstance: registerPrizeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'registerPrize.label', default: 'RegisterPrize'), registerPrizeInstance.id])
        redirect(action: "show", id: registerPrizeInstance.id)
    }

    def show(Long id) {
        def registerPrizeInstance = RegisterPrize.get(id)
        if (!registerPrizeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registerPrize.label', default: 'RegisterPrize'), id])
            redirect(action: "list")
            return
        }

        [registerPrizeInstance: registerPrizeInstance]
    }

    def edit(Long id) {
        def registerPrizeInstance = RegisterPrize.get(id)
        if (!registerPrizeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registerPrize.label', default: 'RegisterPrize'), id])
            redirect(action: "list")
            return
        }

        [registerPrizeInstance: registerPrizeInstance]
    }

    def update(Long id, Long version) {
        def registerPrizeInstance = RegisterPrize.get(id)
        if (!registerPrizeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registerPrize.label', default: 'RegisterPrize'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (registerPrizeInstance.version > version) {
                registerPrizeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'registerPrize.label', default: 'RegisterPrize')] as Object[],
                          "Another user has updated this RegisterPrize while you were editing")
                render(view: "edit", model: [registerPrizeInstance: registerPrizeInstance])
                return
            }
        }

        registerPrizeInstance.properties = params

        if (!registerPrizeInstance.save(flush: true)) {
            render(view: "edit", model: [registerPrizeInstance: registerPrizeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'registerPrize.label', default: 'RegisterPrize'), registerPrizeInstance.id])
        redirect(action: "show", id: registerPrizeInstance.id)
    }

    def delete(Long id) {
        def registerPrizeInstance = RegisterPrize.get(id)
        if (!registerPrizeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'registerPrize.label', default: 'RegisterPrize'), id])
            redirect(action: "list")
            return
        }

        try {
            registerPrizeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'registerPrize.label', default: 'RegisterPrize'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'registerPrize.label', default: 'RegisterPrize'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def showAwarding() {
		def user = springSecurityService.currentUser
		def prizes = RegisterPrize.createCriteria().list {
			eq("awardedBy", user)
			order("awardedAt", "desc")
		}
		[prizes:prizes]
	}
	
	def verifyAwarding() {
		def rp = RegisterPrize.findByVerifyCode(params.verifyCode)
		[rp:rp]
	}
	
	def awarding() {
		def user = springSecurityService.currentUser
		def rp = RegisterPrize.findByVerifyCode(params.verifyCode)
		if(rp) {
			rp.awardedAt = new Date()
			rp.awardedBy = user
			rp.save(flush:true)
		}
		redirect(action:"showAwarding")
	}
}
