package com.surelution.utop

class DeliveryValidation {

    static constraints = {
		ticket unique:true
		sn unique:true
    }
	
	def beforeValidate() {
		if(!sn) {
			sn = UUID.randomUUID().toString()
		}
	}

	DeliveryTicket ticket
	User sender
	String sn
	String validationCode
	Date dateCreated
	Date lastUpdated
}
