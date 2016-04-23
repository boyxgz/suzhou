package com.surelution.utop



import org.junit.*
import grails.test.mixin.*

@TestFor(GroupBuyPriceRuleController)
@Mock(GroupBuyPriceRule)
class GroupBuyPriceRuleControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/groupBuyPriceRule/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.groupBuyPriceRuleInstanceList.size() == 0
        assert model.groupBuyPriceRuleInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.groupBuyPriceRuleInstance != null
    }

    void testSave() {
        controller.save()

        assert model.groupBuyPriceRuleInstance != null
        assert view == '/groupBuyPriceRule/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/groupBuyPriceRule/show/1'
        assert controller.flash.message != null
        assert GroupBuyPriceRule.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/groupBuyPriceRule/list'

        populateValidParams(params)
        def groupBuyPriceRule = new GroupBuyPriceRule(params)

        assert groupBuyPriceRule.save() != null

        params.id = groupBuyPriceRule.id

        def model = controller.show()

        assert model.groupBuyPriceRuleInstance == groupBuyPriceRule
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/groupBuyPriceRule/list'

        populateValidParams(params)
        def groupBuyPriceRule = new GroupBuyPriceRule(params)

        assert groupBuyPriceRule.save() != null

        params.id = groupBuyPriceRule.id

        def model = controller.edit()

        assert model.groupBuyPriceRuleInstance == groupBuyPriceRule
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/groupBuyPriceRule/list'

        response.reset()

        populateValidParams(params)
        def groupBuyPriceRule = new GroupBuyPriceRule(params)

        assert groupBuyPriceRule.save() != null

        // test invalid parameters in update
        params.id = groupBuyPriceRule.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/groupBuyPriceRule/edit"
        assert model.groupBuyPriceRuleInstance != null

        groupBuyPriceRule.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/groupBuyPriceRule/show/$groupBuyPriceRule.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        groupBuyPriceRule.clearErrors()

        populateValidParams(params)
        params.id = groupBuyPriceRule.id
        params.version = -1
        controller.update()

        assert view == "/groupBuyPriceRule/edit"
        assert model.groupBuyPriceRuleInstance != null
        assert model.groupBuyPriceRuleInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/groupBuyPriceRule/list'

        response.reset()

        populateValidParams(params)
        def groupBuyPriceRule = new GroupBuyPriceRule(params)

        assert groupBuyPriceRule.save() != null
        assert GroupBuyPriceRule.count() == 1

        params.id = groupBuyPriceRule.id

        controller.delete()

        assert GroupBuyPriceRule.count() == 0
        assert GroupBuyPriceRule.get(groupBuyPriceRule.id) == null
        assert response.redirectedUrl == '/groupBuyPriceRule/list'
    }
}
