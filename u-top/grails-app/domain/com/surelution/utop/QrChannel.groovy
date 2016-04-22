package com.surelution.utop

class QrChannel extends SubscribingChannel {

    static constraints = {
    }
	
	String qrNo
	
	public String toString() {
		"${name}(扫码)"
	}
}
