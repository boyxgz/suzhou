package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class ShakearoundChannelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [shakearoundChannelInstanceList: ShakearoundChannel.list(params), shakearoundChannelInstanceTotal: ShakearoundChannel.count()]
    }

    def create() {
        [shakearoundChannelInstance: new ShakearoundChannel(params)]
    }

    def save() {
        def shakearoundChannelInstance = new ShakearoundChannel(params)
        if (!shakearoundChannelInstance.save(flush: true)) {
            render(view: "create", model: [shakearoundChannelInstance: shakearoundChannelInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel'), shakearoundChannelInstance.id])
        redirect(action: "show", id: shakearoundChannelInstance.id)
    }

    def show(Long id) {
        def shakearoundChannelInstance = ShakearoundChannel.get(id)
        if (!shakearoundChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel'), id])
            redirect(action: "list")
            return
        }

        [shakearoundChannelInstance: shakearoundChannelInstance]
    }

    def edit(Long id) {
        def shakearoundChannelInstance = ShakearoundChannel.get(id)
        if (!shakearoundChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel'), id])
            redirect(action: "list")
            return
        }

        [shakearoundChannelInstance: shakearoundChannelInstance]
    }

    def update(Long id, Long version) {
        def shakearoundChannelInstance = ShakearoundChannel.get(id)
        if (!shakearoundChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (shakearoundChannelInstance.version > version) {
                shakearoundChannelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel')] as Object[],
                          "Another user has updated this ShakearoundChannel while you were editing")
                render(view: "edit", model: [shakearoundChannelInstance: shakearoundChannelInstance])
                return
            }
        }

        shakearoundChannelInstance.properties = params

        if (!shakearoundChannelInstance.save(flush: true)) {
            render(view: "edit", model: [shakearoundChannelInstance: shakearoundChannelInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel'), shakearoundChannelInstance.id])
        redirect(action: "show", id: shakearoundChannelInstance.id)
    }

    def delete(Long id) {
        def shakearoundChannelInstance = ShakearoundChannel.get(id)
        if (!shakearoundChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel'), id])
            redirect(action: "list")
            return
        }

        try {
            shakearoundChannelInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel'), id])
            redirect(action: "show", id: id)
        }
    }
}
