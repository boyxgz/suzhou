package com.surelution.utop

class IllegalRecord {

    static constraints = {
    }
    
    static mapping = {
        status column:'c_status'
    }
    
    Date illegalAt
    String address
    String illegalAction
    String status
    String policeOffice
	String punish
    String score
}
