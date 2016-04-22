package com.surelution.utop

class RegisterPrize {

    static constraints = {
		awardedBy nullable:true
		awardedAt nullable:true
		subscriber unique:true
    }

	Subscriber subscriber
	Prize prize
	String verifyCode
	Date createAt
	User awardedBy
	Date awardedAt
}
