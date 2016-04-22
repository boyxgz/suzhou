package com.surelution.utop

import org.springframework.dao.DataIntegrityViolationException

class ProductLabelController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [productLabelInstanceList: ProductLabel.list(params), productLabelInstanceTotal: ProductLabel.count()]
    }

    def create() {
        [productLabelInstance: new ProductLabel(params)]
    }

    def save() {
        def productLabelInstance = new ProductLabel(params)
        if (!productLabelInstance.save(flush: true)) {
            render(view: "create", model: [productLabelInstance: productLabelInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'productLabel.label', default: 'ProductLabel'), productLabelInstance.id])
        redirect(action: "show", id: productLabelInstance.id)
    }

    def show(Long id) {
        def productLabelInstance = ProductLabel.get(id)
        if (!productLabelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productLabel.label', default: 'ProductLabel'), id])
            redirect(action: "list")
            return
        }

        [productLabelInstance: productLabelInstance]
    }

    def edit(Long id) {
        def productLabelInstance = ProductLabel.get(id)
        if (!productLabelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productLabel.label', default: 'ProductLabel'), id])
            redirect(action: "list")
            return
        }

        [productLabelInstance: productLabelInstance]
    }

    def update(Long id, Long version) {
        def productLabelInstance = ProductLabel.get(id)
        if (!productLabelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productLabel.label', default: 'ProductLabel'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (productLabelInstance.version > version) {
                productLabelInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'productLabel.label', default: 'ProductLabel')] as Object[],
                          "Another user has updated this ProductLabel while you were editing")
                render(view: "edit", model: [productLabelInstance: productLabelInstance])
                return
            }
        }

        productLabelInstance.properties = params

        if (!productLabelInstance.save(flush: true)) {
            render(view: "edit", model: [productLabelInstance: productLabelInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'productLabel.label', default: 'ProductLabel'), productLabelInstance.id])
        redirect(action: "show", id: productLabelInstance.id)
    }

    def delete(Long id) {
        def productLabelInstance = ProductLabel.get(id)
        if (!productLabelInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'productLabel.label', default: 'ProductLabel'), id])
            redirect(action: "list")
            return
        }

        try {
            productLabelInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'productLabel.label', default: 'ProductLabel'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'productLabel.label', default: 'ProductLabel'), id])
            redirect(action: "show", id: id)
        }
    }
}
