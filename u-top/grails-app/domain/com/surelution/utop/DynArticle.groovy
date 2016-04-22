package com.surelution.utop

class DynArticle {

    static constraints = {
		code unique:true
    }
	
	static mapping = {
		content length:1024*1024
	}

	String code
	String content
}
