package com.surelution.utop

class Vehicle {

    static constraints = {
		vId nullable:true
		engineId nullable:true
		type nullable:true
    }
	
	/**
	 * 车辆识别号，车架号码
	 */
    String vId
	
	/**
	 * 发动机号
	 */
    String engineId
	
	/**
	 * 车牌号
	 */
    String vNo
	
	/**
	 * 车辆类型
	 */
    VehicleType type
    
	/**
	 * 车辆所有人
	 */
    Subscriber subscriber
}
