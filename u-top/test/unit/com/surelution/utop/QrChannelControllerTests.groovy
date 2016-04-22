package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(QrChannelController)
@Mock(QrChannel)
class QrChannelControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/qrChannel/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.qrChannelInstanceList.size() == 0
        assert model.qrChannelInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.qrChannelInstance != null
    }

    void testSave() {
        controller.save()

        assert model.qrChannelInstance != null
        assert view == '/qrChannel/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/qrChannel/show/1'
        assert controller.flash.message != null
        assert QrChannel.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/qrChannel/list'

        populateValidParams(params)
        def qrChannel = new QrChannel(params)

        assert qrChannel.save() != null

        params.id = qrChannel.id

        def model = controller.show()

        assert model.qrChannelInstance == qrChannel
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/qrChannel/list'

        populateValidParams(params)
        def qrChannel = new QrChannel(params)

        assert qrChannel.save() != null

        params.id = qrChannel.id

        def model = controller.edit()

        assert model.qrChannelInstance == qrChannel
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/qrChannel/list'

        response.reset()

        populateValidParams(params)
        def qrChannel = new QrChannel(params)

        assert qrChannel.save() != null

        // test invalid parameters in update
        params.id = qrChannel.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/qrChannel/edit"
        assert model.qrChannelInstance != null

        qrChannel.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/qrChannel/show/$qrChannel.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        qrChannel.clearErrors()

        populateValidParams(params)
        params.id = qrChannel.id
        params.version = -1
        controller.update()

        assert view == "/qrChannel/edit"
        assert model.qrChannelInstance != null
        assert model.qrChannelInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/qrChannel/list'

        response.reset()

        populateValidParams(params)
        def qrChannel = new QrChannel(params)

        assert qrChannel.save() != null
        assert QrChannel.count() == 1

        params.id = qrChannel.id

        controller.delete()

        assert QrChannel.count() == 0
        assert QrChannel.get(qrChannel.id) == null
        assert response.redirectedUrl == '/qrChannel/list'
    }
}
