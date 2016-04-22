package com.surelution.utop

import java.util.Date;


class Subscriber {
	
	static constraints = {
		openId unique:true
	}
	
	Boolean subscribed = false

	String openId
	Date dateCreated
	Date lastUpdated
}
