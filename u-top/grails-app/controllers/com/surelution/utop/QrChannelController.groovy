package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class QrChannelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [qrChannelInstanceList: QrChannel.list(params), qrChannelInstanceTotal: QrChannel.count()]
    }

    def create() {
        [qrChannelInstance: new QrChannel(params)]
    }

    def save() {
        def qrChannelInstance = new QrChannel(params)
        if (!qrChannelInstance.save(flush: true)) {
            render(view: "create", model: [qrChannelInstance: qrChannelInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'qrChannel.label', default: 'QrChannel'), qrChannelInstance.id])
        redirect(action: "show", id: qrChannelInstance.id)
    }

    def show(Long id) {
        def qrChannelInstance = QrChannel.get(id)
        if (!qrChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qrChannel.label', default: 'QrChannel'), id])
            redirect(action: "list")
            return
        }

        [qrChannelInstance: qrChannelInstance]
    }

    def edit(Long id) {
        def qrChannelInstance = QrChannel.get(id)
        if (!qrChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qrChannel.label', default: 'QrChannel'), id])
            redirect(action: "list")
            return
        }

        [qrChannelInstance: qrChannelInstance]
    }

    def update(Long id, Long version) {
        def qrChannelInstance = QrChannel.get(id)
        if (!qrChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qrChannel.label', default: 'QrChannel'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (qrChannelInstance.version > version) {
                qrChannelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'qrChannel.label', default: 'QrChannel')] as Object[],
                          "Another user has updated this QrChannel while you were editing")
                render(view: "edit", model: [qrChannelInstance: qrChannelInstance])
                return
            }
        }

        qrChannelInstance.properties = params

        if (!qrChannelInstance.save(flush: true)) {
            render(view: "edit", model: [qrChannelInstance: qrChannelInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'qrChannel.label', default: 'QrChannel'), qrChannelInstance.id])
        redirect(action: "show", id: qrChannelInstance.id)
    }

    def delete(Long id) {
        def qrChannelInstance = QrChannel.get(id)
        if (!qrChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qrChannel.label', default: 'QrChannel'), id])
            redirect(action: "list")
            return
        }

        try {
            qrChannelInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'qrChannel.label', default: 'QrChannel'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'qrChannel.label', default: 'QrChannel'), id])
            redirect(action: "show", id: id)
        }
    }
}
