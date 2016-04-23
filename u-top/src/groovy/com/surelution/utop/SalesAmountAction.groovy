package com.surelution.utop

import com.surelution.whistle.core.Attribute;

class SalesAmountAction extends BaseSuzhouAction {
    
    Employee e

    @Override
    public boolean accept() {
        boolean b = getParam(Attribute.KEY_Content) == "销量"
        String openId = getParam(Attribute.KEY_FromUserName)
        Subscriber s = Subscriber.findByOpenId(openId)
        if(b && !s) {
            e = Employee.findBySubscriber(s)
            b = e && e.certified
            return b
        }
        b
    }

    @Override
    public void execute() {
        put(new Attribute(Attribute.KEY_Content, "请输入销量"))
    }

}
