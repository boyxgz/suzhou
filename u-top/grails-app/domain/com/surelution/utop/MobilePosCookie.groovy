package com.surelution.utop

class MobilePosCookie {

    static constraints = {
		subscriber unique:true
		subscriberSn unique:true
    }

	Subscriber subscriber
	String subscriberSn
	Date dateCreated
	Date lastUpdated
	
	public static MobilePosCookie populate(Subscriber subscriber) {
		def sc = MobilePosCookie.findOrCreateBySubscriber(subscriber)
		sc.subscriberSn = UUID.randomUUID().toString()
		sc.save(flush:true)
		return sc
	}
}
