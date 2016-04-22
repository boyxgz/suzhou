/**
 * 
 */
package com.surelution.utop

import com.surelution.utop.DeliveryTicket.DeliveryStatus
import com.surelution.whistle.core.Attribute

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class MyDelieryAction extends UtopBaseAction {

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#accept()
	 */
	@Override
	public boolean accept() {
		isMenu("my-delivery")
	}

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#execute()
	 */
	@Override
	public void execute() {
		def tickets = DeliveryTicket.findAllBySubscriberAndStatus(subscriber, DeliveryStatus.READY)
		StringBuffer sb = new StringBuffer()
		if(tickets && tickets.size() > 0) {
			sb.append("您有${tickets.size()}张提货券，提货券号码是：")
			tickets.each {
				sb.append("\n")
				sb.append(it.wellLookSn)
			}
			sb.append("\n请在提货时向店内工作人员出示此号码")
		} else {
			sb.append("您目前没有可用的提货券，快来围观优米商城！")
		}
		put(new Attribute(Attribute.KEY_Content, sb.toString()))
	}

}
