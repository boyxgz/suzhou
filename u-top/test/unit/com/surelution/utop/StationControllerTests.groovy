package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(StationController)
@Mock(Station)
class StationControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/station/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.stationInstanceList.size() == 0
        assert model.stationInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.stationInstance != null
    }

    void testSave() {
        controller.save()

        assert model.stationInstance != null
        assert view == '/station/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/station/show/1'
        assert controller.flash.message != null
        assert Station.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/station/list'

        populateValidParams(params)
        def station = new Station(params)

        assert station.save() != null

        params.id = station.id

        def model = controller.show()

        assert model.stationInstance == station
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/station/list'

        populateValidParams(params)
        def station = new Station(params)

        assert station.save() != null

        params.id = station.id

        def model = controller.edit()

        assert model.stationInstance == station
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/station/list'

        response.reset()

        populateValidParams(params)
        def station = new Station(params)

        assert station.save() != null

        // test invalid parameters in update
        params.id = station.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/station/edit"
        assert model.stationInstance != null

        station.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/station/show/$station.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        station.clearErrors()

        populateValidParams(params)
        params.id = station.id
        params.version = -1
        controller.update()

        assert view == "/station/edit"
        assert model.stationInstance != null
        assert model.stationInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/station/list'

        response.reset()

        populateValidParams(params)
        def station = new Station(params)

        assert station.save() != null
        assert Station.count() == 1

        params.id = station.id

        controller.delete()

        assert Station.count() == 0
        assert Station.get(station.id) == null
        assert response.redirectedUrl == '/station/list'
    }
}
