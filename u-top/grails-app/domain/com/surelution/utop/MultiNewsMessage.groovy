package com.surelution.utop

class MultiNewsMessage {

    static constraints = {
		menuKey unique:true
		description nullable:true
    }
	
	String menuKey
	String inputMessage
	String description
}
