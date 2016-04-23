/**
 * 
 */
package com.surelution.utop

import com.surelution.whistle.core.Attribute;

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class CommentTipAction extends BaseSuzhouAction {

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#accept()
	 */
	@Override
	public boolean accept() {
		return isMenu("key_comments")
	}

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#execute()
	 */
	@Override
	public void execute() {
		def cmd = KeyedMessage.findByKey('COMMENT-TIPS')
		put(new Attribute(Attribute.KEY_Content, cmd.message))
	}

}
