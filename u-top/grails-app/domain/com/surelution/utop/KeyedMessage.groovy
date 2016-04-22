package com.surelution.utop

class KeyedMessage {

    static constraints = {
		key unique:true
    }
	
	static mapping = {
		message length:1024
		key column:"_key"
	}
	
	String key
	String message
	String description
	
	public String toString() {
		message ? message : key
	}
	
	public static String populate(String key) {
		def km = findByKey(key)
		km?km.message:key
	}
}
