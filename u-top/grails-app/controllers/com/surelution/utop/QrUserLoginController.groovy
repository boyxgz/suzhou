package com.surelution.utop

import grails.converters.JSON;

import org.apache.commons.lang3.RandomUtils
import org.springframework.dao.DataIntegrityViolationException

import com.surelution.whistle.push.qrcode.GenerateCode;
import com.surelution.whistle.push.qrcode.QrCode;

class QrUserLoginController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService

//    def index() {
//        redirect(action: "list", params: params)
//    }
//
//    def list(Integer max) {
//        params.max = Math.min(max ?: 10, 100)
//        [qrUserLoginInstanceList: QrUserLogin.list(params), qrUserLoginInstanceTotal: QrUserLogin.count()]
//    }
//
//    def create() {
//        [qrUserLoginInstance: new QrUserLogin(params)]
//    }
//
//    def save() {
//        def qrUserLoginInstance = new QrUserLogin(params)
//        if (!qrUserLoginInstance.save(flush: true)) {
//            render(view: "create", model: [qrUserLoginInstance: qrUserLoginInstance])
//            return
//        }
//
//        flash.message = message(code: 'default.created.message', args: [message(code: 'qrUserLogin.label', default: 'QrUserLogin'), qrUserLoginInstance.id])
//        redirect(action: "show", id: qrUserLoginInstance.id)
//    }
//
//    def show(Long id) {
//        def qrUserLoginInstance = QrUserLogin.get(id)
//        if (!qrUserLoginInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qrUserLogin.label', default: 'QrUserLogin'), id])
//            redirect(action: "list")
//            return
//        }
//
//        [qrUserLoginInstance: qrUserLoginInstance]
//    }
//
//    def edit(Long id) {
//        def qrUserLoginInstance = QrUserLogin.get(id)
//        if (!qrUserLoginInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qrUserLogin.label', default: 'QrUserLogin'), id])
//            redirect(action: "list")
//            return
//        }
//
//        [qrUserLoginInstance: qrUserLoginInstance]
//    }
//
//    def update(Long id, Long version) {
//        def qrUserLoginInstance = QrUserLogin.get(id)
//        if (!qrUserLoginInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qrUserLogin.label', default: 'QrUserLogin'), id])
//            redirect(action: "list")
//            return
//        }
//
//        if (version != null) {
//            if (qrUserLoginInstance.version > version) {
//                qrUserLoginInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
//                          [message(code: 'qrUserLogin.label', default: 'QrUserLogin')] as Object[],
//                          "Another user has updated this QrUserLogin while you were editing")
//                render(view: "edit", model: [qrUserLoginInstance: qrUserLoginInstance])
//                return
//            }
//        }
//
//        qrUserLoginInstance.properties = params
//
//        if (!qrUserLoginInstance.save(flush: true)) {
//            render(view: "edit", model: [qrUserLoginInstance: qrUserLoginInstance])
//            return
//        }
//
//        flash.message = message(code: 'default.updated.message', args: [message(code: 'qrUserLogin.label', default: 'QrUserLogin'), qrUserLoginInstance.id])
//        redirect(action: "show", id: qrUserLoginInstance.id)
//    }
//
//    def delete(Long id) {
//        def qrUserLoginInstance = QrUserLogin.get(id)
//        if (!qrUserLoginInstance) {
//            flash.message = message(code: 'default.not.found.message', args: [message(code: 'qrUserLogin.label', default: 'QrUserLogin'), id])
//            redirect(action: "list")
//            return
//        }
//
//        try {
//            qrUserLoginInstance.delete(flush: true)
//            flash.message = message(code: 'default.deleted.message', args: [message(code: 'qrUserLogin.label', default: 'QrUserLogin'), id])
//            redirect(action: "list")
//        }
//        catch (DataIntegrityViolationException e) {
//            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'qrUserLogin.label', default: 'QrUserLogin'), id])
//            redirect(action: "show", id: id)
//        }
//    }

	def dashboard() {
		def currLogin = QrUserLogin.findByUserAndActivedAndDateConfirmedIsNotNull(springSecurityService.currentUser, true)
		[currLogin:currLogin]
	}
	
	def fetchQr() {
		def currLogin = QrUserLogin.findByUserAndActivedAndDateConfirmedIsNotNull(springSecurityService.currentUser, true)
		if(!currLogin) {
			QrUserLogin.findAllByUserAndActived(springSecurityService.currentUser, true).each {
				it.actived = false
				it.save()
			}
			currLogin = new QrUserLogin()
			currLogin.user = springSecurityService.currentUser
			currLogin.validationCode = "${RandomUtils.nextInt(100, 1000)}"
			currLogin.save(flush:true)
			render([returnCode:1, qrKey:currLogin.qrKey, id:currLogin.id] as JSON)
		} else {
			render([returnCode:0] as JSON)
		}
	}
	
	def qr(String id) {
		def os = response.outputStream
		def content = QrCode.getTempQr(id, 30 * 60 * 1000)
		os << content
	}

	def confirmLogin() {
		def loginId = params.loginId
		def validateCode = params.validateCode
		if(loginId && validateCode) {
			def login = QrUserLogin.get(loginId)
			if(login && login.validationCode == validateCode && login.user == springSecurityService.currentUser) {
				login.dateConfirmed = new Date()
				login.loggedIn = true
				login.save(flush:true)
				flash.message = "登录成功"
			}
		}
		redirect(action:'dashboard')
	}
	
	def confirmLogout(Long id) {
		def login = QrUserLogin.get(id)
		if(login 
			&& login.dateConfirmed 
			&& login.user == springSecurityService.currentUser
			&& login.actived 
			&& login.dateLogout == null) {
			login.dateLogout = new Date()
			login.actived = false
			login.loggedIn = false
			login.save(flush:true)
			flash.message = "退出成功"
		}
		
		redirect(action:'dashboard')
	}
}
