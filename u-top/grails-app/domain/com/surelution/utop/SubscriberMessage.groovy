package com.surelution.utop

class SubscriberMessage {
	
	static constraints = {
		toStation nullable:true
		fromSubscriberName nullable:true
	}
	
	Date date
	String content
	Subscriber fromSubscriber
	String fromSubscriberName
	GasStation toStation
	boolean isSolved
}
