package com.surelution.utop

/**
 * 调查的定义
 * 
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class Survey {

    static constraints = {
		description nullable:false 
		remark nullable:true
    }

	static mapping = {
		description type:'text'
		remark type:'text'
		group column:'_group'
		index column:'_index'
	}

	SurveyGroup group
	String title
	String description
	String remark
	Integer index
	
	/**
	 * 单选还是多选
	 */
	Boolean single
	
	/**
	 * 是否包含一个“其他”的选项，供用户输入一个文本
	 */
	Boolean acceptComment
}
