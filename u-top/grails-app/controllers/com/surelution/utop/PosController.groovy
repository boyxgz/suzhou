package com.surelution.utop

import grails.util.Holders

import org.apache.commons.lang3.RandomUtils

import com.surelution.utop.DeliveryTicket.DeliveryStatus
import com.surelution.utop.SaleOrder.SaleOrderStatus
import com.surelution.whistle.core.TemplateMessage

class PosController {
	
	def springSecurityService

    def index() {
		def sn = params.sn
		DeliveryTicket dt
		def order
		if(sn) {
			dt = DeliveryTicket.findBySnAndStatus(sn, DeliveryStatus.READY)
			order = dt?.saleOrder
			if(!order) {
				flash.message = "提货码错误或已经领取"
			}
		}
		[dt:dt, order:order]
	}

	def sendValidate() {
		def sn = params.sn
		DeliveryTicket dt
		def order
		def validation
		if(sn) {
			dt = DeliveryTicket.findBySnAndStatus(sn, DeliveryStatus.READY)
			if(dt) {
				order = dt.saleOrder
				validation = DeliveryValidation.findOrCreateByTicket(dt)
				validation.sender = springSecurityService.currentUser
				validation.validationCode = RandomUtils.nextInt(100, 999).toString()
				validation.save(flush:true)

				TemplateMessage tm = new TemplateMessage()
				tm.templateId = Holders.config.templateMessage.delivery_validation //温州
				tm.url = "${Holders.config.grails.serverURL}/shop2"
				tm.toUser = order.subscriber.openId
				tm.addEntry("first", "尊敬的顾客")
				tm.addEntry("number", validation.validationCode)
				tm.addEntry("remark","该验证码有效期30分钟")
				tm.send()
			}
		}
		render(view:'index', model:[dt:dt, order:order])
	}
	
	def showDeliveryProduct() {
		def sn = params.sn
		def validationCode = params.validationCode
		def dt = DeliveryTicket.findBySnAndStatus(sn, DeliveryStatus.READY)
		DeliveryValidation validation = DeliveryValidation.findByTicket(dt)
		if(validation.validationCode == validationCode) {
			def order = dt.saleOrder
			[dt:dt, order:order, validation:validation]
		} else {
			flash.message = "手机动态验证码错误"
			render(view:'index')
		}
	}
	
	def deliveryProduct() {
		def validationSn = params.validationSn
		DeliveryValidation validation = DeliveryValidation.findBySn(validationSn)

		if(validation) {
			def dt = validation.ticket
			def order = dt.saleOrder
			order.status = SaleOrderStatus.DELIVERED
			order.save(flush:true)

			dt.operator = springSecurityService.currentUser
			dt.status = DeliveryStatus.DELIVERIED
			dt.deliveredAt = new Date()
			dt.save(flush:true)
			
			def tm = new TemplateMessage()
			tm.url = "${Holders.config.grails.serverURL}/shop2"
			tm.templateId = Holders.config.templateMessage.delivery_finished
			tm.toUser = order.subscriber.openId
			tm.addEntry("first", "您好，您的订单已经成功提货")
			tm.addEntry("keyword1", "${dt.sn}")
			tm.addEntry("keyword2", "${dt.operator.username}")
			tm.addEntry("keyword3", new Date().format("yyyy-MM-dd HH:mm"))
			tm.addEntry("remark", "如有疑问，请联系我们")
			tm.send()
			
			flash.message = "发货完成"
		} else {
			flash.message = "系统错误"
		}
		redirect(action:'index')
	}
}
