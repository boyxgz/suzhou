package com.surelution.utop

class VoucherType {

    static constraints = {
		description nullable:true
		key unique:true
    }

	static mapping = {
		key column:'_key'
	}

	String key
	String name
	String description
}
