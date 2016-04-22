package com.surelution.utop

import com.surelution.whistle.core.Attribute

class UnsubscribingAction extends UtopBaseAction {

	public boolean accept() {
		getParam(Attribute.KEY_MsgType) == "event" && getParam("Event") == "unsubscribe"
	}

	public void execute() {
		subscriber.subscribed = false
		subscriber.save(flush:true)
	}

}
