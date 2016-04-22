package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class ImprestController {
	
	def springSecurityService

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [imprestInstanceList: Imprest.list(params), imprestInstanceTotal: Imprest.count()]
    }

    def create() {
        [imprestInstance: new Imprest(params)]
    }

    def save() {
		if(params.transferDate)
			params.transferDate = params.date('transferDate', 'yyyy-MM-dd HH:mm')
        def imprestInstance = new Imprest(params)
        if (!imprestInstance.save(flush: true)) {
            render(view: "create", model: [imprestInstance: imprestInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'imprest.label', default: 'Imprest'), imprestInstance.id])
        redirect(action: "show", id: imprestInstance.id)
    }

    def show(Long id) {
        def imprestInstance = Imprest.get(id)
        if (!imprestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'imprest.label', default: 'Imprest'), id])
            redirect(action: "list")
            return
        }

        [imprestInstance: imprestInstance]
    }

    def edit(Long id) {
        def imprestInstance = Imprest.get(id)
        if (!imprestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'imprest.label', default: 'Imprest'), id])
            redirect(action: "list")
            return
        }

        [imprestInstance: imprestInstance]
    }

    def update(Long id, Long version) {
        def imprestInstance = Imprest.get(id)
        if (!imprestInstance || imprestInstance.confirmed) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'imprest.label', default: 'Imprest'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (imprestInstance.version > version) {
                imprestInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'imprest.label', default: 'Imprest')] as Object[],
                          "Another user has updated this Imprest while you were editing")
                render(view: "edit", model: [imprestInstance: imprestInstance])
                return
            }
        }

        imprestInstance.properties = params

        if (!imprestInstance.save(flush: true)) {
            render(view: "edit", model: [imprestInstance: imprestInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'imprest.label', default: 'Imprest'), imprestInstance.id])
        redirect(action: "show", id: imprestInstance.id)
    }

    def delete(Long id) {
        def imprestInstance = Imprest.get(id)
        if (!imprestInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'imprest.label', default: 'Imprest'), id])
            redirect(action: "list")
            return
        }

		if(imprestInstance.confirmed) {
			redirect(action: "show", id: id)
			return
		}
        try {
            imprestInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'imprest.label', default: 'Imprest'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'imprest.label', default: 'Imprest'), id])
            redirect(action: "show", id: id)
        }
    }

	def waitingForConfirm() {
		def imprestInstanceList = Imprest.createCriteria().list() {
			and {
				order('confirmed')
				order('confirmedBy')
			}
		}
		[imprestInstanceList:imprestInstanceList]
	}
	
	def confirm(Long id) {
		def imprest = Imprest.get(id)
		if(imprest) {
			if(imprest && !imprest.confirmed) {
				imprest.confirmedBy = springSecurityService.currentUser
				imprest.confirmedAt = new Date()
				imprest.confirmed = true
				imprest.save(flush:true)
			}
		}
		redirect(action:'waitingForConfirm')
	}
	
}
