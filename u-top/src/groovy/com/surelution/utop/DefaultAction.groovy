/**
 * 
 */
package com.surelution.utop

import com.surelution.whistle.core.Attribute

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class DefaultAction extends UtopBaseAction {

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#accept()
	 */
	@Override
	public boolean accept() {
		true
	}

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#execute()
	 */
	@Override
	public void execute() {
		put(new Attribute(Attribute.KEY_Content, "hello"))
	}

}
