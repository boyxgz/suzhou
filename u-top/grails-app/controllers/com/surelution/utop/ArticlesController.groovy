package com.surelution.utop

class ArticlesController {

    def index() { }
	
	def network() {
		def lng = params.longitude
		def lat = params.latitude
		if(lng && lat) {
			double longitude = Double.parseDouble(lng)
			double latitude = Double.parseDouble(lat)
			return [longitude:longitude, latitude:latitude]
		}
	}
	
	def test() {}
	
	def uploadIt() {
		def myeditor = params.myeditor
		println myeditor
	}
}
