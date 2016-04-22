package com.surelution.utop

import java.util.Date;

import org.springframework.dao.DataIntegrityViolationException

import com.surelution.whistle.core.TextCustomerServiceMessage;
import com.surelution.whistle.push.ReplyTimeoutException;

class SubscriberMessageController {

	static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	def springSecurityService
	def index() {
		redirect(action: "list", params: params)
	}

	def list(Integer max) {
		params.max = Math.min(max ?: 10, 100)
		def userStation = getUserGasStation()
		def gasStation = userStation?.gasStation
		def fromSubscriberName = params.fromSubscriber
		
		if(params.gasStationId) {
			gasStation = GasStation.get(Long.parseLong(params.gasStationId))
		}
		def result = SubscriberMessage.createCriteria().list(max:10, offset:params.offset) {
			if(gasStation) {
				eq("toStation",gasStation)
			}
			
			if(fromSubscriberName) {
				eq("fromSubscriberName",fromSubscriberName)
			}
		}
		
		
		
		[subscriberMessageInstanceList: result, subscriberMessageInstanceTotal: result.totalCount]
	}

	def create() {
		[subscriberMessageInstance: new SubscriberMessage(params)]
	}

	def save() {
		def subscriberMessageInstance = new SubscriberMessage(params)
		if (!subscriberMessageInstance.save(flush: true)) {
			render(view: "create", model: [subscriberMessageInstance: subscriberMessageInstance])
			return
		}

		flash.message = message(code: 'default.created.message', args: [
			message(code: 'subscriberMessage.label', default: 'SubscriberMessage'),
			subscriberMessageInstance.id
		])
		redirect(action: "show", id: subscriberMessageInstance.id)
	}

	def show(Long id) {
		def subscriberMessageInstance = SubscriberMessage.get(id)
		if (!subscriberMessageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'subscriberMessage.label', default: 'SubscriberMessage'),
				id
			])
			redirect(action: "list")
			return
		}

		def userMsg =  UserMessage.findAllByToMsg(subscriberMessageInstance);


		[subscriberMessageInstance: subscriberMessageInstance,userMsg:userMsg]
	}

	def edit(Long id) {
		def subscriberMessageInstance = SubscriberMessage.get(id)
		if (!subscriberMessageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'subscriberMessage.label', default: 'SubscriberMessage'),
				id
			])
			redirect(action: "list")
			return
		}

		[subscriberMessageInstance: subscriberMessageInstance]
	}

	def update(Long id, Long version) {
		def subscriberMessageInstance = SubscriberMessage.get(id)
		if (!subscriberMessageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'subscriberMessage.label', default: 'SubscriberMessage'),
				id
			])
			redirect(action: "list")
			return
		}

		if (version != null) {
			if (subscriberMessageInstance.version > version) {
				subscriberMessageInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
						[
							message(code: 'subscriberMessage.label', default: 'SubscriberMessage')] as Object[],
						"Another user has updated this SubscriberMessage while you were editing")
				render(view: "edit", model: [subscriberMessageInstance: subscriberMessageInstance])
				return
			}
		}

		subscriberMessageInstance.properties = params

		if (!subscriberMessageInstance.save(flush: true)) {
			render(view: "edit", model: [subscriberMessageInstance: subscriberMessageInstance])
			return
		}

		flash.message = message(code: 'default.updated.message', args: [
			message(code: 'subscriberMessage.label', default: 'SubscriberMessage'),
			subscriberMessageInstance.id
		])
		redirect(action: "show", id: subscriberMessageInstance.id)
	}

	def delete(Long id) {
		def subscriberMessageInstance = SubscriberMessage.get(id)
		if (!subscriberMessageInstance) {
			flash.message = message(code: 'default.not.found.message', args: [
				message(code: 'subscriberMessage.label', default: 'SubscriberMessage'),
				id
			])
			redirect(action: "list")
			return
		}

		try {
			subscriberMessageInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [
				message(code: 'subscriberMessage.label', default: 'SubscriberMessage'),
				id
			])
			redirect(action: "list")
		}
		catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [
				message(code: 'subscriberMessage.label', default: 'SubscriberMessage'),
				id
			])
			redirect(action: "show", id: id)
		}
	}


	def sendUserMsg(Long id) {
		def subscriberMessageInstance = SubscriberMessage.get(id)
		subscriberMessageInstance.fromSubscriber.openId
		def message = params.message

		println message
		println subscriberMessageInstance.fromSubscriber.openId
		TextCustomerServiceMessage msg = new TextCustomerServiceMessage()
		msg.touser = subscriberMessageInstance.fromSubscriber.openId
		msg.content = message
//		def result = AdvancedUtil.sendSubscriberMessage(msg);
		try{
			msg.send()
		}catch(ReplyTimeoutException e) {
			flash.message ="回复失败，可能是时间已经超过48小时";
		}
		redirect(action: "show", id: id)
//		if(!result) {
//			
//			redirect(action: "show", id: id)
//		}else {
//			addUserMessage(subscriberMessageInstance,message)
//			redirect(action: "show", id: id)
//		}

		 
	}


	def addUserMessage(subscriberMessageInstance,message) {
		UserMessage msg = new UserMessage();
		msg.fromUser =  getUserGasStation()
		msg.toMsg = subscriberMessageInstance
		msg.content =message
		msg.date = new Date()
		
		msg.save(flush:true)
		
		subscriberMessageInstance.isSolved = true
		subscriberMessageInstance.save(flush:true)
		
	}

	def getUserGasStation() {
		def user = springSecurityService.currentUser
		UserGasStation.findByUser(user)
	}
}
