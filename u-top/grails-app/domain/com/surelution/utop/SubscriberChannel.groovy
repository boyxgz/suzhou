package com.surelution.utop

/**
 * 用户第一次加入，是通过什么渠道
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class SubscriberChannel {

    static constraints = {
		subscriber unique:true
    }

	Subscriber subscriber
	SubscribingChannel channel
	Date dateCreated
}
