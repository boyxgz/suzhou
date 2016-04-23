/**
 * 
 */
package com.surelution.utop

import com.surelution.whistle.core.Attribute
import com.surelution.whistle.core.NewsAttribute

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class DynMatchAction extends BaseSuzhouAction {
	private MultiNewsMessage mnm;

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#accept()
	 */
	@Override
	public boolean accept() {
		if(getParam(Attribute.KEY_MsgType) == "event" && getParam("Event") == "CLICK") {
			String eventKey = getParam("EventKey")
			mnm = MultiNewsMessage.findByMenuKey(eventKey)
		}
		return mnm != null;
	}

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#execute()
	 */
	@Override
	public void execute() {
		NewsAttribute na = new NewsAttribute()
		def items = MultiNewsMessageItem.createCriteria().list {
			eq('message', mnm)
			order('firstNews', 'desc')
		}
		items.each {item->
			na.add(item.title, item.description, item.pictureUrl, item.url)
		}
		put(na)
	}

}
