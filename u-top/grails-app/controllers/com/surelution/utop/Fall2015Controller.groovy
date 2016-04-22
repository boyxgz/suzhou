package com.surelution.utop

import grails.util.Holders

import com.surelution.whistle.core.Auth2Util
import com.surelution.whistle.core.Auth2Util.AuthScope

class Fall2015Controller {

	private Subscriber subscriber
	
	def saleOrderService

	/**
	 * 自动登录
	 */
	def beforeInterceptor = {
		def userSn = request.getCookie('user-sn')
		subscriber = SubscriberCookie.findBySubscriberSn(userSn)?.subscriber
		
		if(!subscriber) {
			def requestUrl = request.forwardURI
			def baseUrl = Holders.config.grails.serverURL
			def url = Auth2Util.buildRedirectUrl("${baseUrl}/subscriberPortal/autoLogin", requestUrl, AuthScope.BASE)
			response.deleteCookie('user-sn')
			redirect(url:url)
			return false
		}
		return true
	}

    def index() {
		def today = new Date().clearTime()
		def ids = AppVar.findByKey("fall2015-product-price-plan-ids").value
		def ppps = ids.split(",").collect() {
			ProductPricePlan.get(it)
		}
		def newOrder = saleOrderService.findNewOrder(subscriber)
		SaleOrderItem.checkItems(newOrder)
		[ppps:ppps, newOrder:newOrder]
	}
}
