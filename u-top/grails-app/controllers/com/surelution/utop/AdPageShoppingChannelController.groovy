package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class AdPageShoppingChannelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [adPageShoppingChannelInstanceList: AdPageShoppingChannel.list(params), adPageShoppingChannelInstanceTotal: AdPageShoppingChannel.count()]
    }

    def create() {
        [adPageShoppingChannelInstance: new AdPageShoppingChannel(params)]
    }

    def save() {
        def adPageShoppingChannelInstance = new AdPageShoppingChannel(params)
        if (!adPageShoppingChannelInstance.save(flush: true)) {
            render(view: "create", model: [adPageShoppingChannelInstance: adPageShoppingChannelInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'adPageShoppingChannel.label', default: 'AdPageShoppingChannel'), adPageShoppingChannelInstance.id])
        redirect(action: "show", id: adPageShoppingChannelInstance.id)
    }

    def show(Long id) {
        def adPageShoppingChannelInstance = AdPageShoppingChannel.get(id)
        if (!adPageShoppingChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'adPageShoppingChannel.label', default: 'AdPageShoppingChannel'), id])
            redirect(action: "list")
            return
        }

        [adPageShoppingChannelInstance: adPageShoppingChannelInstance]
    }

    def edit(Long id) {
        def adPageShoppingChannelInstance = AdPageShoppingChannel.get(id)
        if (!adPageShoppingChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'adPageShoppingChannel.label', default: 'AdPageShoppingChannel'), id])
            redirect(action: "list")
            return
        }

        [adPageShoppingChannelInstance: adPageShoppingChannelInstance]
    }

    def update(Long id, Long version) {
        def adPageShoppingChannelInstance = AdPageShoppingChannel.get(id)
        if (!adPageShoppingChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'adPageShoppingChannel.label', default: 'AdPageShoppingChannel'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (adPageShoppingChannelInstance.version > version) {
                adPageShoppingChannelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'adPageShoppingChannel.label', default: 'AdPageShoppingChannel')] as Object[],
                          "Another user has updated this AdPageShoppingChannel while you were editing")
                render(view: "edit", model: [adPageShoppingChannelInstance: adPageShoppingChannelInstance])
                return
            }
        }

        adPageShoppingChannelInstance.properties = params

        if (!adPageShoppingChannelInstance.save(flush: true)) {
            render(view: "edit", model: [adPageShoppingChannelInstance: adPageShoppingChannelInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'adPageShoppingChannel.label', default: 'AdPageShoppingChannel'), adPageShoppingChannelInstance.id])
        redirect(action: "show", id: adPageShoppingChannelInstance.id)
    }

    def delete(Long id) {
        def adPageShoppingChannelInstance = AdPageShoppingChannel.get(id)
        if (!adPageShoppingChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'adPageShoppingChannel.label', default: 'AdPageShoppingChannel'), id])
            redirect(action: "list")
            return
        }

        try {
            adPageShoppingChannelInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'adPageShoppingChannel.label', default: 'AdPageShoppingChannel'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'adPageShoppingChannel.label', default: 'AdPageShoppingChannel'), id])
            redirect(action: "show", id: id)
        }
    }
}
