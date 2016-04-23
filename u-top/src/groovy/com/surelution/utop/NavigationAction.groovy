package com.surelution.utop

import com.surelution.locator.BaiduLocator
import com.surelution.whistle.core.Attribute
import com.surelution.whistle.core.NewsAttribute

class NavigationAction extends BaseSuzhouAction {

	@Override
	public boolean accept() {
		"location" == getParam(Attribute.KEY_MsgType)
	}

	@Override
	public void execute() {
		def x = Float.parseFloat(getParam(Attribute.KEY_Location_X))
		def y = Float.parseFloat(getParam(Attribute.KEY_Location_Y))
		
		def pois = BaiduLocator.instance.near(5, y, x)
		
		NewsAttribute na = new NewsAttribute();
		boolean first = true;
		int count = 5;
		pois.each {poi->
			def stationId = poi.location.id
			def station = GasStation.get(stationId)
			def title = "${station.name}(${station.address}),距离约${(int)(poi.distance/1000)}公里,驾车约需${(int)(poi.duration/60)}分钟"
			
			String description = "祝您行车平安"
			def url = "${rootPath}/navigation/go?orig=${x},${y}&dest=${stationId}"
			def picUrl = "${rootPath}/app-images/${first?'map.png':'pc_logo.png'}"
			first = false
			na.add(title, description, picUrl, url)
		}
		def moreStation = KeyedMessage.findByKey("MORE-STATION").message
		na.add(moreStation, "", "${rootPath}/app-images/${first?'map.png':'pc_logo.png'}", "${rootPath}/articles/network?latitude=${x}&longitude=${y}")
		put(na);
	}

}
