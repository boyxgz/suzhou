package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(ShelfProductPricePlanController)
@Mock(ShelfProductPricePlan)
class ShelfProductPricePlanControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/shelfProductPricePlan/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.shelfProductPricePlanInstanceList.size() == 0
        assert model.shelfProductPricePlanInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.shelfProductPricePlanInstance != null
    }

    void testSave() {
        controller.save()

        assert model.shelfProductPricePlanInstance != null
        assert view == '/shelfProductPricePlan/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/shelfProductPricePlan/show/1'
        assert controller.flash.message != null
        assert ShelfProductPricePlan.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/shelfProductPricePlan/list'

        populateValidParams(params)
        def shelfProductPricePlan = new ShelfProductPricePlan(params)

        assert shelfProductPricePlan.save() != null

        params.id = shelfProductPricePlan.id

        def model = controller.show()

        assert model.shelfProductPricePlanInstance == shelfProductPricePlan
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/shelfProductPricePlan/list'

        populateValidParams(params)
        def shelfProductPricePlan = new ShelfProductPricePlan(params)

        assert shelfProductPricePlan.save() != null

        params.id = shelfProductPricePlan.id

        def model = controller.edit()

        assert model.shelfProductPricePlanInstance == shelfProductPricePlan
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/shelfProductPricePlan/list'

        response.reset()

        populateValidParams(params)
        def shelfProductPricePlan = new ShelfProductPricePlan(params)

        assert shelfProductPricePlan.save() != null

        // test invalid parameters in update
        params.id = shelfProductPricePlan.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/shelfProductPricePlan/edit"
        assert model.shelfProductPricePlanInstance != null

        shelfProductPricePlan.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/shelfProductPricePlan/show/$shelfProductPricePlan.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        shelfProductPricePlan.clearErrors()

        populateValidParams(params)
        params.id = shelfProductPricePlan.id
        params.version = -1
        controller.update()

        assert view == "/shelfProductPricePlan/edit"
        assert model.shelfProductPricePlanInstance != null
        assert model.shelfProductPricePlanInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/shelfProductPricePlan/list'

        response.reset()

        populateValidParams(params)
        def shelfProductPricePlan = new ShelfProductPricePlan(params)

        assert shelfProductPricePlan.save() != null
        assert ShelfProductPricePlan.count() == 1

        params.id = shelfProductPricePlan.id

        controller.delete()

        assert ShelfProductPricePlan.count() == 0
        assert ShelfProductPricePlan.get(shelfProductPricePlan.id) == null
        assert response.redirectedUrl == '/shelfProductPricePlan/list'
    }
}
