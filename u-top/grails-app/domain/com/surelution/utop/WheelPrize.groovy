package com.surelution.utop

class WheelPrize {

    static constraints = {
        seq unique:true
        prize nullable:true
    }
    int seq
    Prize prize
}
