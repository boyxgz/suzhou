package com.surelution.utop

import com.surelution.id.IDUtil
import com.surelution.whistle.core.Attribute

class SubscribeAction extends JxBaseAction {

	@Override
	public boolean accept() {
		getParam(Attribute.KEY_MsgType) == "event" && getParam("Event") == "subscribe"
	}

	@Override
	public void execute() {
		def now = new Date()
		def msg = KeyedMessage.findByKey("WELCOME").message
		def refedId = IDUtil.getRefusedId((int)(long)subscriber.id, 5)
		
		msg.replace("<duijiangma>", refedId)
		
		def prize = Prize.findByCode("REGISTERING")
		def rp = new RegisterPrize()
		rp.subscriber = subscriber
		rp.prize = prize
		rp.createAt = now
		rp.verifyCode = refedId
		rp.save(flush:true)
		
		def eventKey = getParam("EventKey")
		if(eventKey) {
			//qrscene_8
			if(eventKey.startsWith("qrscene_")) {
				def comeFrom = eventKey.substring("qrscene_".length())
				def subscribing = new Subscribing()
				subscribing.subscriber = subscriber
				subscribing.subscribingAt = now
				subscribing.comeFrom = comeFrom
				subscribing.save(flush:true)
				
				subscriber.preferedStation = GasStation.get(comeFrom)
				
				subscriber.save(flush:true);
			}
		}
		put(new Attribute(Attribute.KEY_Content, msg))
	}

}
