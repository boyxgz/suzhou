package com.surelution.utop


class GasStation {

    static constraints = {
		linkManTel nullable:true
		cardBonus nullable:true
		cardBonus nullable:true
		subscribingUrl nullable:true
    }

	static transients = ["distance","duration"]

	static mapping = {
	}

	District district
	double longitude
	double latitude
	String name
	String address
	String tel
	String linkMan
	String linkManTel
	
	/**
	 * 是否可发卡
	 */
	boolean cardIssuing
	
	/**
	 * 积分兑换网点
	 */
	boolean cardBonus
	long distance
	long duration
	boolean active
	
	String subscribingUrl
}
