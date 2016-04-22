package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(VoucherTypeController)
@Mock(VoucherType)
class VoucherTypeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/voucherType/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.voucherTypeInstanceList.size() == 0
        assert model.voucherTypeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.voucherTypeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.voucherTypeInstance != null
        assert view == '/voucherType/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/voucherType/show/1'
        assert controller.flash.message != null
        assert VoucherType.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/voucherType/list'

        populateValidParams(params)
        def voucherType = new VoucherType(params)

        assert voucherType.save() != null

        params.id = voucherType.id

        def model = controller.show()

        assert model.voucherTypeInstance == voucherType
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/voucherType/list'

        populateValidParams(params)
        def voucherType = new VoucherType(params)

        assert voucherType.save() != null

        params.id = voucherType.id

        def model = controller.edit()

        assert model.voucherTypeInstance == voucherType
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/voucherType/list'

        response.reset()

        populateValidParams(params)
        def voucherType = new VoucherType(params)

        assert voucherType.save() != null

        // test invalid parameters in update
        params.id = voucherType.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/voucherType/edit"
        assert model.voucherTypeInstance != null

        voucherType.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/voucherType/show/$voucherType.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        voucherType.clearErrors()

        populateValidParams(params)
        params.id = voucherType.id
        params.version = -1
        controller.update()

        assert view == "/voucherType/edit"
        assert model.voucherTypeInstance != null
        assert model.voucherTypeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/voucherType/list'

        response.reset()

        populateValidParams(params)
        def voucherType = new VoucherType(params)

        assert voucherType.save() != null
        assert VoucherType.count() == 1

        params.id = voucherType.id

        controller.delete()

        assert VoucherType.count() == 0
        assert VoucherType.get(voucherType.id) == null
        assert response.redirectedUrl == '/voucherType/list'
    }
}
