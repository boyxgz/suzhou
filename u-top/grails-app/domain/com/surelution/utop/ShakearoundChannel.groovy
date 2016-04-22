package com.surelution.utop

class ShakearoundChannel extends SubscribingChannel {

    static constraints = {
    }
	
	String uuid
	String major
	String minor
	
	public String toString() {
		"${name}(摇一摇)"
	}
}
