package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(ProductPricePlanController)
@Mock(ProductPricePlan)
class ProductPricePlanControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/productPricePlan/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.productPricePlanInstanceList.size() == 0
        assert model.productPricePlanInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.productPricePlanInstance != null
    }

    void testSave() {
        controller.save()

        assert model.productPricePlanInstance != null
        assert view == '/productPricePlan/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/productPricePlan/show/1'
        assert controller.flash.message != null
        assert ProductPricePlan.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/productPricePlan/list'

        populateValidParams(params)
        def productPricePlan = new ProductPricePlan(params)

        assert productPricePlan.save() != null

        params.id = productPricePlan.id

        def model = controller.show()

        assert model.productPricePlanInstance == productPricePlan
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/productPricePlan/list'

        populateValidParams(params)
        def productPricePlan = new ProductPricePlan(params)

        assert productPricePlan.save() != null

        params.id = productPricePlan.id

        def model = controller.edit()

        assert model.productPricePlanInstance == productPricePlan
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/productPricePlan/list'

        response.reset()

        populateValidParams(params)
        def productPricePlan = new ProductPricePlan(params)

        assert productPricePlan.save() != null

        // test invalid parameters in update
        params.id = productPricePlan.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/productPricePlan/edit"
        assert model.productPricePlanInstance != null

        productPricePlan.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/productPricePlan/show/$productPricePlan.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        productPricePlan.clearErrors()

        populateValidParams(params)
        params.id = productPricePlan.id
        params.version = -1
        controller.update()

        assert view == "/productPricePlan/edit"
        assert model.productPricePlanInstance != null
        assert model.productPricePlanInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/productPricePlan/list'

        response.reset()

        populateValidParams(params)
        def productPricePlan = new ProductPricePlan(params)

        assert productPricePlan.save() != null
        assert ProductPricePlan.count() == 1

        params.id = productPricePlan.id

        controller.delete()

        assert ProductPricePlan.count() == 0
        assert ProductPricePlan.get(productPricePlan.id) == null
        assert response.redirectedUrl == '/productPricePlan/list'
    }
}
