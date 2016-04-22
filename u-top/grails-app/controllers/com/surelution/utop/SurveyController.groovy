package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class SurveyController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [surveyInstanceList: Survey.list(params), surveyInstanceTotal: Survey.count()]
    }

    def create(Long id) {
		def group = SurveyGroup.get(id)
		def survey =  new Survey(params)
		survey.group = group
		def surveys = Survey.findAllByGroup(group)
        [surveyInstance:survey, surveys:surveys]
    }

    def save() {
        def surveyInstance = new Survey(params)
        if (!surveyInstance.save(flush: true)) {
            render(view: "create", model: [surveyInstance: surveyInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'survey.label', default: 'Survey'), surveyInstance.id])
        redirect(action: "show", id: surveyInstance.id)
    }

    def show(Long id) {
        def surveyInstance = Survey.get(id)
        if (!surveyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'survey.label', default: 'Survey'), id])
            redirect(action: "list")
            return
        }
		
		def surveyItems = SurveyItem.findAllBySurvey(surveyInstance)

        [surveyInstance: surveyInstance, surveyItems:surveyItems]
    }

    def edit(Long id) {
        def surveyInstance = Survey.get(id)
        if (!surveyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'survey.label', default: 'Survey'), id])
            redirect(action: "list")
            return
        }

        [surveyInstance: surveyInstance]
    }

    def update(Long id, Long version) {
        def surveyInstance = Survey.get(id)
        if (!surveyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'survey.label', default: 'Survey'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (surveyInstance.version > version) {
                surveyInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'survey.label', default: 'Survey')] as Object[],
                          "Another user has updated this Survey while you were editing")
                render(view: "edit", model: [surveyInstance: surveyInstance])
                return
            }
        }

        surveyInstance.properties = params

        if (!surveyInstance.save(flush: true)) {
            render(view: "edit", model: [surveyInstance: surveyInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'survey.label', default: 'Survey'), surveyInstance.id])
        redirect(action: "show", id: surveyInstance.id)
    }

    def delete(Long id) {
        def surveyInstance = Survey.get(id)
        if (!surveyInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'survey.label', default: 'Survey'), id])
            redirect(action: "list")
            return
        }

        try {
            surveyInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'survey.label', default: 'Survey'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'survey.label', default: 'Survey'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def addItem(Long id) {
		def surveyInstance = Survey.get(id)
		def item = new SurveyItem()
		item.survey = surveyInstance
		item.content = params.content
		item.save()
		redirect(action:'show', id:id)
	}
	
	def deleteItem(Long id) {
		def item = SurveyItem.get(id)
		def survey = item.survey
		def count = SurveyResponseItem.countByChosen(item)
		if(count > 0) {
			flash.message = "本选项已经有人选择，不能删除"
		} else {
			try{
				item.delete()
			}catch(Exception e) {
				println e
			}
		}
		redirect(action:'show', id:survey.id)
	}
}
