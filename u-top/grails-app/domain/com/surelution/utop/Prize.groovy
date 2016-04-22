package com.surelution.utop

class Prize {

    static constraints = {
        description blank:true 
        description nullable:true 
		code unique:true
    }
    
    static mapping = {
        description length:1024
        empty column:'c_empty'
    }
    
	String code
    String name
    String description
    Float price
    int amount
    boolean empty
}
