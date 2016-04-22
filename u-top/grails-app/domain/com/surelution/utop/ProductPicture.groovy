package com.surelution.utop

class ProductPicture {

    static constraints = {
    }
	
	static mapping = {
		index column:'_index'
		enabled column:'_enabled'
	}
	
	Product product
	Integer index
	Boolean enabled
	VirtualFile file
	
}
