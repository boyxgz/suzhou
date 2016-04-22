package com.surelution.utop

class SurveyResponse {

    static constraints = {
		subscriber(unique:'group')
		remark nullable:true
    }

	static mapping = {
		remark type:'text'
	}

	Subscriber subscriber
	SurveyGroup group
	Date dateCreated

	/**
	 * 当该调查允许“其他”选项时，用户输入的自定义内容
	 */
	String remark
}
