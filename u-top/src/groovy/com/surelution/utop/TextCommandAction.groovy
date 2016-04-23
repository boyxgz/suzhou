package com.surelution.utop

import com.surelution.whistle.core.Attribute

class TextCommandAction extends BaseSuzhouAction {

	@Override
	public boolean accept() {
		 getParam(Attribute.KEY_MsgType) == Attribute.Msg_Type_TEXT
	}

	@Override
	public void execute() {
		def cmd = KeyedMessage.findByKey('TEXT-COMMAND')
		
		put(new Attribute(Attribute.KEY_Content, cmd.message))
		
		addMsg();
	}
	
	private void addMsg() {
		SubscriberMessage subMsg = new SubscriberMessage()
		def msg = getParam(Attribute.KEY_Content)
		subMsg.content  = msg;
		subMsg.date = new Date();
		subMsg.fromSubscriber = subscriber
//		subMsg.fromSubscriberName = getfromSubscriberNameByOpenId(subscriber.openId)
		subMsg.toStation = subscriber.preferedStation
		
		subMsg.save(flush:true)
		println subMsg.errors
	}
	
	
	def getfromSubscriberNameByOpenId(openId) {
		return AdvancedUtil.getSubscriberName(openId)
	}
	
	
	

}
