/**
 * 
 */
package com.surelution.utop

import com.surelution.whistle.core.Attribute;

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class CommentAction extends UtopBaseAction {

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#accept()
	 */
	@Override
	public boolean accept() {
		getParam(Attribute.KEY_MsgType) == Attribute.Msg_Type_TEXT
	}

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#execute()
	 */
	@Override
	public void execute() {
		def msg = KeyedMessage.findByKey("unknown-text-message")?.message
		put(new Attribute(Attribute.KEY_Content, msg))
	}

}
