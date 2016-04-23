/**
 * 
 */
package com.surelution.utop

import com.surelution.whistle.core.Attribute

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class ScanAction extends BaseSuzhouAction {

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#accept()
	 */
	@Override
	public boolean accept() {
		return getParam("Event") == "SCAN"
	}

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#execute()
	 */
	@Override
	public void execute() {
		String eventKey = getParam("EventKey")
		def gasStation = GasStation.get(eventKey)
		if(gasStation) {
			def msg = "您已经成功关注了我们的账号，无需再次操作，非常感谢您的厚爱\n--${gasStation.name}"
			put(new Attribute(Attribute.KEY_Content, msg))
		} else {
			def msg = "系统错误，错误码：${eventKey}"
			put(new Attribute(Attribute.KEY_Content, msg))
		}
	}

}
