package com.surelution.utop

import com.surelution.whistle.core.Attribute;

class EmployeeCertifingAction extends BaseSuzhouAction {

    
    @Override
    public boolean accept() {
        def c = getParam(Attribute.KEY_Content)
        if(c) {
            c = c.trim()
            return c.startsWith("认证")
        }
        return false
    }

    @Override
    public void execute() {
        def code = getParam(Attribute.KEY_Content)
        code = code.trim()
        code = code.substring(2)
        def emp = Employee.findByCode(code)
        if(emp) {
            if(emp.codeExpiredAt > new Date()) {
                emp.certified = true
                emp.subscriber = subscriber
                emp.save(flush:true)
                put(new Attribute(Attribute.KEY_Content, "欢迎您，${emp.name}"))
                return
            }
        }
        put(new Attribute(Attribute.KEY_Content, "认证失败，请联系管理员!"))
    }

}
