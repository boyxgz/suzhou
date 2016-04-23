package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(GroupProductPricePlanController)
@Mock(GroupProductPricePlan)
class GroupProductPricePlanControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/groupProductPricePlan/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.groupProductPricePlanInstanceList.size() == 0
        assert model.groupProductPricePlanInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.groupProductPricePlanInstance != null
    }

    void testSave() {
        controller.save()

        assert model.groupProductPricePlanInstance != null
        assert view == '/groupProductPricePlan/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/groupProductPricePlan/show/1'
        assert controller.flash.message != null
        assert GroupProductPricePlan.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/groupProductPricePlan/list'

        populateValidParams(params)
        def groupProductPricePlan = new GroupProductPricePlan(params)

        assert groupProductPricePlan.save() != null

        params.id = groupProductPricePlan.id

        def model = controller.show()

        assert model.groupProductPricePlanInstance == groupProductPricePlan
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/groupProductPricePlan/list'

        populateValidParams(params)
        def groupProductPricePlan = new GroupProductPricePlan(params)

        assert groupProductPricePlan.save() != null

        params.id = groupProductPricePlan.id

        def model = controller.edit()

        assert model.groupProductPricePlanInstance == groupProductPricePlan
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/groupProductPricePlan/list'

        response.reset()

        populateValidParams(params)
        def groupProductPricePlan = new GroupProductPricePlan(params)

        assert groupProductPricePlan.save() != null

        // test invalid parameters in update
        params.id = groupProductPricePlan.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/groupProductPricePlan/edit"
        assert model.groupProductPricePlanInstance != null

        groupProductPricePlan.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/groupProductPricePlan/show/$groupProductPricePlan.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        groupProductPricePlan.clearErrors()

        populateValidParams(params)
        params.id = groupProductPricePlan.id
        params.version = -1
        controller.update()

        assert view == "/groupProductPricePlan/edit"
        assert model.groupProductPricePlanInstance != null
        assert model.groupProductPricePlanInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/groupProductPricePlan/list'

        response.reset()

        populateValidParams(params)
        def groupProductPricePlan = new GroupProductPricePlan(params)

        assert groupProductPricePlan.save() != null
        assert GroupProductPricePlan.count() == 1

        params.id = groupProductPricePlan.id

        controller.delete()

        assert GroupProductPricePlan.count() == 0
        assert GroupProductPricePlan.get(groupProductPricePlan.id) == null
        assert response.redirectedUrl == '/groupProductPricePlan/list'
    }
}
