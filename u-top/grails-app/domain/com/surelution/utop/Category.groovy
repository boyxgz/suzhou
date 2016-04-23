package com.surelution.utop

/**
 * 商品分类目录的创建
 * @author xiaoming
 *
 */
class Category {

    static constraints = {
    }
	
	static mapping = {
		enabled column:'_enabled'
	}
	
	String name
	Boolean enabled
}
