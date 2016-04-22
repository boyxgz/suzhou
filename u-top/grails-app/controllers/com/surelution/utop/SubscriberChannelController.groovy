package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class SubscriberChannelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [subscriberChannelInstanceList: SubscriberChannel.list(params), subscriberChannelInstanceTotal: SubscriberChannel.count()]
    }

    def create() {
        [subscriberChannelInstance: new SubscriberChannel(params)]
    }

    def save() {
        def subscriberChannelInstance = new SubscriberChannel(params)
        if (!subscriberChannelInstance.save(flush: true)) {
            render(view: "create", model: [subscriberChannelInstance: subscriberChannelInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'subscriberChannel.label', default: 'SubscriberChannel'), subscriberChannelInstance.id])
        redirect(action: "show", id: subscriberChannelInstance.id)
    }

    def show(Long id) {
        def subscriberChannelInstance = SubscriberChannel.get(id)
        if (!subscriberChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'subscriberChannel.label', default: 'SubscriberChannel'), id])
            redirect(action: "list")
            return
        }

        [subscriberChannelInstance: subscriberChannelInstance]
    }

    def edit(Long id) {
        def subscriberChannelInstance = SubscriberChannel.get(id)
        if (!subscriberChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'subscriberChannel.label', default: 'SubscriberChannel'), id])
            redirect(action: "list")
            return
        }

        [subscriberChannelInstance: subscriberChannelInstance]
    }

    def update(Long id, Long version) {
        def subscriberChannelInstance = SubscriberChannel.get(id)
        if (!subscriberChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'subscriberChannel.label', default: 'SubscriberChannel'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (subscriberChannelInstance.version > version) {
                subscriberChannelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'subscriberChannel.label', default: 'SubscriberChannel')] as Object[],
                          "Another user has updated this SubscriberChannel while you were editing")
                render(view: "edit", model: [subscriberChannelInstance: subscriberChannelInstance])
                return
            }
        }

        subscriberChannelInstance.properties = params

        if (!subscriberChannelInstance.save(flush: true)) {
            render(view: "edit", model: [subscriberChannelInstance: subscriberChannelInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'subscriberChannel.label', default: 'SubscriberChannel'), subscriberChannelInstance.id])
        redirect(action: "show", id: subscriberChannelInstance.id)
    }

    def delete(Long id) {
        def subscriberChannelInstance = SubscriberChannel.get(id)
        if (!subscriberChannelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'subscriberChannel.label', default: 'SubscriberChannel'), id])
            redirect(action: "list")
            return
        }

        try {
            subscriberChannelInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'subscriberChannel.label', default: 'SubscriberChannel'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'subscriberChannel.label', default: 'SubscriberChannel'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def report() {
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		def channels
		if(from && to) {
			channels = SubscriberChannel.executeQuery("""
				select cast(u.dateCreated as date), count(u), u.channel
				  from SubscriberChannel as u 
				  where u.dateCreated >= ? and u.dateCreated < ?
				  group by cast(u.dateCreated as date), u.channel
				""", [from, to])
		}
		[channels:channels]
	}
}
