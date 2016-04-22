package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class VoucherTypeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [voucherTypeInstanceList: VoucherType.list(params), voucherTypeInstanceTotal: VoucherType.count()]
    }

    def create() {
        [voucherTypeInstance: new VoucherType(params)]
    }

    def save() {
        def voucherTypeInstance = new VoucherType(params)
        if (!voucherTypeInstance.save(flush: true)) {
            render(view: "create", model: [voucherTypeInstance: voucherTypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'voucherType.label', default: 'VoucherType'), voucherTypeInstance.id])
        redirect(action: "show", id: voucherTypeInstance.id)
    }

    def show(Long id) {
        def voucherTypeInstance = VoucherType.get(id)
        if (!voucherTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'voucherType.label', default: 'VoucherType'), id])
            redirect(action: "list")
            return
        }

        [voucherTypeInstance: voucherTypeInstance]
    }

    def edit(Long id) {
        def voucherTypeInstance = VoucherType.get(id)
        if (!voucherTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'voucherType.label', default: 'VoucherType'), id])
            redirect(action: "list")
            return
        }

        [voucherTypeInstance: voucherTypeInstance]
    }

    def update(Long id, Long version) {
        def voucherTypeInstance = VoucherType.get(id)
        if (!voucherTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'voucherType.label', default: 'VoucherType'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (voucherTypeInstance.version > version) {
                voucherTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'voucherType.label', default: 'VoucherType')] as Object[],
                          "Another user has updated this VoucherType while you were editing")
                render(view: "edit", model: [voucherTypeInstance: voucherTypeInstance])
                return
            }
        }

        voucherTypeInstance.properties = params

        if (!voucherTypeInstance.save(flush: true)) {
            render(view: "edit", model: [voucherTypeInstance: voucherTypeInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'voucherType.label', default: 'VoucherType'), voucherTypeInstance.id])
        redirect(action: "show", id: voucherTypeInstance.id)
    }

    def delete(Long id) {
        def voucherTypeInstance = VoucherType.get(id)
        if (!voucherTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'voucherType.label', default: 'VoucherType'), id])
            redirect(action: "list")
            return
        }

        try {
            voucherTypeInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'voucherType.label', default: 'VoucherType'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'voucherType.label', default: 'VoucherType'), id])
            redirect(action: "show", id: id)
        }
    }
}
