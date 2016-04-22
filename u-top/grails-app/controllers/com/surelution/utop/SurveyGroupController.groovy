package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class SurveyGroupController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [surveyGroupInstanceList: SurveyGroup.list(params), surveyGroupInstanceTotal: SurveyGroup.count()]
    }

    def create() {
        [surveyGroupInstance: new SurveyGroup(params)]
    }

    def save() {
        def surveyGroupInstance = new SurveyGroup(params)
        if (!surveyGroupInstance.save(flush: true)) {
            render(view: "create", model: [surveyGroupInstance: surveyGroupInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'surveyGroup.label', default: 'SurveyGroup'), surveyGroupInstance.id])
        redirect(action: "show", id: surveyGroupInstance.id)
    }

    def show(Long id) {
        def surveyGroupInstance = SurveyGroup.get(id)
        if (!surveyGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyGroup.label', default: 'SurveyGroup'), id])
            redirect(action: "list")
            return
        }

        [surveyGroupInstance: surveyGroupInstance]
    }

    def edit(Long id) {
        def surveyGroupInstance = SurveyGroup.get(id)
        if (!surveyGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyGroup.label', default: 'SurveyGroup'), id])
            redirect(action: "list")
            return
        }

        [surveyGroupInstance: surveyGroupInstance]
    }

    def update(Long id, Long version) {
        def surveyGroupInstance = SurveyGroup.get(id)
        if (!surveyGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyGroup.label', default: 'SurveyGroup'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (surveyGroupInstance.version > version) {
                surveyGroupInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'surveyGroup.label', default: 'SurveyGroup')] as Object[],
                          "Another user has updated this SurveyGroup while you were editing")
                render(view: "edit", model: [surveyGroupInstance: surveyGroupInstance])
                return
            }
        }

        surveyGroupInstance.properties = params

        if (!surveyGroupInstance.save(flush: true)) {
            render(view: "edit", model: [surveyGroupInstance: surveyGroupInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'surveyGroup.label', default: 'SurveyGroup'), surveyGroupInstance.id])
        redirect(action: "show", id: surveyGroupInstance.id)
    }

    def delete(Long id) {
        def surveyGroupInstance = SurveyGroup.get(id)
        if (!surveyGroupInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyGroup.label', default: 'SurveyGroup'), id])
            redirect(action: "list")
            return
        }

        try {
            surveyGroupInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'surveyGroup.label', default: 'SurveyGroup'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'surveyGroup.label', default: 'SurveyGroup'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def configCurrent(Long id) {
		def survey = Survey.get(id)
		if(survey) {
			def config = AppConfig.findByKey("CURRENT-SURVEY-GROUP")
			if(!config) {
				config = new AppConfig()
				config.key = "CURRENT-SURVEY-GROUP"
			}
			config.configInfo = id.toString()
			config.save()
		}
		redirect(action:'show', id:id)
	}
}
