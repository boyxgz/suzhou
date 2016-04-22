package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(SubscriberChannelController)
@Mock(SubscriberChannel)
class SubscriberChannelControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/subscriberChannel/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.subscriberChannelInstanceList.size() == 0
        assert model.subscriberChannelInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.subscriberChannelInstance != null
    }

    void testSave() {
        controller.save()

        assert model.subscriberChannelInstance != null
        assert view == '/subscriberChannel/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/subscriberChannel/show/1'
        assert controller.flash.message != null
        assert SubscriberChannel.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/subscriberChannel/list'

        populateValidParams(params)
        def subscriberChannel = new SubscriberChannel(params)

        assert subscriberChannel.save() != null

        params.id = subscriberChannel.id

        def model = controller.show()

        assert model.subscriberChannelInstance == subscriberChannel
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/subscriberChannel/list'

        populateValidParams(params)
        def subscriberChannel = new SubscriberChannel(params)

        assert subscriberChannel.save() != null

        params.id = subscriberChannel.id

        def model = controller.edit()

        assert model.subscriberChannelInstance == subscriberChannel
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/subscriberChannel/list'

        response.reset()

        populateValidParams(params)
        def subscriberChannel = new SubscriberChannel(params)

        assert subscriberChannel.save() != null

        // test invalid parameters in update
        params.id = subscriberChannel.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/subscriberChannel/edit"
        assert model.subscriberChannelInstance != null

        subscriberChannel.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/subscriberChannel/show/$subscriberChannel.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        subscriberChannel.clearErrors()

        populateValidParams(params)
        params.id = subscriberChannel.id
        params.version = -1
        controller.update()

        assert view == "/subscriberChannel/edit"
        assert model.subscriberChannelInstance != null
        assert model.subscriberChannelInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/subscriberChannel/list'

        response.reset()

        populateValidParams(params)
        def subscriberChannel = new SubscriberChannel(params)

        assert subscriberChannel.save() != null
        assert SubscriberChannel.count() == 1

        params.id = subscriberChannel.id

        controller.delete()

        assert SubscriberChannel.count() == 0
        assert SubscriberChannel.get(subscriberChannel.id) == null
        assert response.redirectedUrl == '/subscriberChannel/list'
    }
}
