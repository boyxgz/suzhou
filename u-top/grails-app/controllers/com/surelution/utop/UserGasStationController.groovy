package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class UserGasStationController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userGasStationInstanceList: UserGasStation.list(params), userGasStationInstanceTotal: UserGasStation.count()]
    }

    def create() {
        [userGasStationInstance: new UserGasStation(params)]
    }

    def save() {
        
		def userInstance = new User()
		
		userInstance.passwordExpired = false
		userInstance.accountExpired = false
		userInstance.accountLocked = false
		userInstance.enabled = true
		userInstance.username = params.username
		userInstance.password = params.password
		def userGasStationInstance = new UserGasStation(params)
		if(!userInstance.save(flush:true)){
			render(view: "create", model: [userGasStationInstance: userGasStationInstance])
			flash.message ="用户可能已经存在，请换个用户名";
			return
		}
		
		userGasStationInstance.user = userInstance
		
        if (!userGasStationInstance.save(flush: true)) {
            render(view: "create", model: [userGasStationInstance: userGasStationInstance])
            return
        }
		
        flash.message = message(code: 'default.created.message', args: [message(code: 'userGasStation.label', default: 'UserGasStation'), userGasStationInstance.id])
        redirect(action: "show", id: userGasStationInstance.id)
    }

    def show(Long id) {
        def userGasStationInstance = UserGasStation.get(id)
        if (!userGasStationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userGasStation.label', default: 'UserGasStation'), id])
            redirect(action: "list")
            return
        }

        [userGasStationInstance: userGasStationInstance]
    }

    def edit(Long id) {
        def userGasStationInstance = UserGasStation.get(id)
        if (!userGasStationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userGasStation.label', default: 'UserGasStation'), id])
            redirect(action: "list")
            return
        }

        [userGasStationInstance: userGasStationInstance]
    }

    def update(Long id, Long version) {
        def userGasStationInstance = UserGasStation.get(id)
        if (!userGasStationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userGasStation.label', default: 'UserGasStation'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userGasStationInstance.version > version) {
                userGasStationInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'userGasStation.label', default: 'UserGasStation')] as Object[],
                          "Another user has updated this UserGasStation while you were editing")
                render(view: "edit", model: [userGasStationInstance: userGasStationInstance])
                return
            }
        }

        userGasStationInstance.properties = params

        if (!userGasStationInstance.save(flush: true)) {
            render(view: "edit", model: [userGasStationInstance: userGasStationInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'userGasStation.label', default: 'UserGasStation'), userGasStationInstance.id])
        redirect(action: "show", id: userGasStationInstance.id)
    }

    def delete(Long id) {
        def userGasStationInstance = UserGasStation.get(id)
        if (!userGasStationInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'userGasStation.label', default: 'UserGasStation'), id])
            redirect(action: "list")
            return
        }

        try {
            userGasStationInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'userGasStation.label', default: 'UserGasStation'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'userGasStation.label', default: 'UserGasStation'), id])
            redirect(action: "show", id: id)
        }
    }
}
