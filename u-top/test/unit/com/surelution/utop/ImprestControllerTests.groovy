package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(ImprestController)
@Mock(Imprest)
class ImprestControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/imprest/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.imprestInstanceList.size() == 0
        assert model.imprestInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.imprestInstance != null
    }

    void testSave() {
        controller.save()

        assert model.imprestInstance != null
        assert view == '/imprest/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/imprest/show/1'
        assert controller.flash.message != null
        assert Imprest.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/imprest/list'

        populateValidParams(params)
        def imprest = new Imprest(params)

        assert imprest.save() != null

        params.id = imprest.id

        def model = controller.show()

        assert model.imprestInstance == imprest
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/imprest/list'

        populateValidParams(params)
        def imprest = new Imprest(params)

        assert imprest.save() != null

        params.id = imprest.id

        def model = controller.edit()

        assert model.imprestInstance == imprest
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/imprest/list'

        response.reset()

        populateValidParams(params)
        def imprest = new Imprest(params)

        assert imprest.save() != null

        // test invalid parameters in update
        params.id = imprest.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/imprest/edit"
        assert model.imprestInstance != null

        imprest.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/imprest/show/$imprest.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        imprest.clearErrors()

        populateValidParams(params)
        params.id = imprest.id
        params.version = -1
        controller.update()

        assert view == "/imprest/edit"
        assert model.imprestInstance != null
        assert model.imprestInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/imprest/list'

        response.reset()

        populateValidParams(params)
        def imprest = new Imprest(params)

        assert imprest.save() != null
        assert Imprest.count() == 1

        params.id = imprest.id

        controller.delete()

        assert Imprest.count() == 0
        assert Imprest.get(imprest.id) == null
        assert response.redirectedUrl == '/imprest/list'
    }
}
