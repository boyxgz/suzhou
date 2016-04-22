package com.surelution.utop

import java.util.Date;

class SurveyGroup {

	static constraints = {
		description nullable:false
		remark nullable:true
	}
	
	static mapping = {
		description type:'text'
		remark type:'text'
	}

	String title
	String description
	String remark
	Date dateCreated
}
