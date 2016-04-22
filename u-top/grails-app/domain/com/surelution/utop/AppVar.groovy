package com.surelution.utop

class AppVar {

    static constraints = {
		key unique:true
    }
	
	static mapping = {
		key column:'_key'
		value column:'_value'
	}
	
	String key
	String value
	String description
}
