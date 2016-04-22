package com.surelution.utop

/**
 * 其实是产品的分类
 * 
 * @author <a href="mailto:guangzong.syu@gmail.com">guagnzong</a>
 *
 */
class ProductLabel {

    static constraints = {
		key nullable:true
		name nullable:false, unique:true
    }
	
	static mapping = {
		key column:"_key"
	}
	
	String name
	String key
	Boolean available
	Boolean listInMenu
	Date dateCreated
}
