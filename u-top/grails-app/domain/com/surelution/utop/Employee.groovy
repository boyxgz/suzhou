package com.surelution.utop

class Employee {

    static constraints = {
        subscriber nullable:true
    }

    String name
    Subscriber subscriber
    boolean certified
    String code
    Date codeExpiredAt
}
