package com.surelution.utop

class Station {

    static constraints = {
    }
	
	static mapping = {
		enabled column:"_enabled"
	}
	
	String name
	String address
	String tel
	Float longitude
	Float latitude
	Boolean enabled
	
	Date dateCreated
}
