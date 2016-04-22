package com.surelution.utop

class AppConfig {

    static constraints = {
		key unique:true
    }
	
	static mapping = {
		configInfo(type:'text')
		key(column:'_key')
	}
	
	String key
	String configInfo
}
