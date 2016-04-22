package com.surelution.utop

class UserMessage {

	
	UserGasStation fromUser
	SubscriberMessage toMsg
	String content
	Date date
	
    static constraints = {
		fromUser nullable:true
    }
}
