package com.surelution.utop

class Category {

    static constraints = {
    }
	
	static mapping = {
		enabled column:'_enabled'
	}
	
	String name
	Boolean enabled
}
