package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(ShakearoundChannelController)
@Mock(ShakearoundChannel)
class ShakearoundChannelControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/shakearoundChannel/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.shakearoundChannelInstanceList.size() == 0
        assert model.shakearoundChannelInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.shakearoundChannelInstance != null
    }

    void testSave() {
        controller.save()

        assert model.shakearoundChannelInstance != null
        assert view == '/shakearoundChannel/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/shakearoundChannel/show/1'
        assert controller.flash.message != null
        assert ShakearoundChannel.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/shakearoundChannel/list'

        populateValidParams(params)
        def shakearoundChannel = new ShakearoundChannel(params)

        assert shakearoundChannel.save() != null

        params.id = shakearoundChannel.id

        def model = controller.show()

        assert model.shakearoundChannelInstance == shakearoundChannel
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/shakearoundChannel/list'

        populateValidParams(params)
        def shakearoundChannel = new ShakearoundChannel(params)

        assert shakearoundChannel.save() != null

        params.id = shakearoundChannel.id

        def model = controller.edit()

        assert model.shakearoundChannelInstance == shakearoundChannel
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/shakearoundChannel/list'

        response.reset()

        populateValidParams(params)
        def shakearoundChannel = new ShakearoundChannel(params)

        assert shakearoundChannel.save() != null

        // test invalid parameters in update
        params.id = shakearoundChannel.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/shakearoundChannel/edit"
        assert model.shakearoundChannelInstance != null

        shakearoundChannel.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/shakearoundChannel/show/$shakearoundChannel.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        shakearoundChannel.clearErrors()

        populateValidParams(params)
        params.id = shakearoundChannel.id
        params.version = -1
        controller.update()

        assert view == "/shakearoundChannel/edit"
        assert model.shakearoundChannelInstance != null
        assert model.shakearoundChannelInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/shakearoundChannel/list'

        response.reset()

        populateValidParams(params)
        def shakearoundChannel = new ShakearoundChannel(params)

        assert shakearoundChannel.save() != null
        assert ShakearoundChannel.count() == 1

        params.id = shakearoundChannel.id

        controller.delete()

        assert ShakearoundChannel.count() == 0
        assert ShakearoundChannel.get(shakearoundChannel.id) == null
        assert response.redirectedUrl == '/shakearoundChannel/list'
    }
}
