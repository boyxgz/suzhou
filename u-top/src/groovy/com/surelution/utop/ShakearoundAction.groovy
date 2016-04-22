/**
 * 
 */
package com.surelution.utop

import com.surelution.whistle.core.Attribute;

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class ShakearoundAction extends UtopBaseAction {

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#accept()
	 */
	@Override
	public boolean accept() {
		getParam(Attribute.KEY_MsgType) == "event" && getParam("Event") == "ShakearoundUserShake"
	}

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#execute()
	 */
	@Override
	public void execute() {
		if(!SubscriberChannel.countBySubscriber(subscriber)) {
			def major = getParam("Major")
			def minor = getParam("Minor")
			def uuid = getParam("Uuid")
			def channel = ShakearoundChannel.findByUuidAndMajorAndMinor(uuid, major, minor)
			def sc = new SubscriberChannel()
			sc.channel = channel
			sc.subscriber = subscriber
			sc.save(flush:true)
		}
		put(new Attribute(Attribute.KEY_Content, ""))
	}

}
