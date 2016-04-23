package com.surelution.utop

import static com.surelution.whistle.core.Attribute.KEY_Content
import static com.surelution.whistle.core.Attribute.KEY_CreateTime
import static com.surelution.whistle.core.Attribute.KEY_FromUserName
import static com.surelution.whistle.core.Attribute.KEY_MsgType
import static com.surelution.whistle.core.Attribute.KEY_ToUserName
import grails.util.Holders;

import javax.servlet.ServletRequest

import com.surelution.whistle.core.Attribute;
import com.surelution.whistle.core.BaseAction


abstract class BaseSuzhouAction extends BaseAction {
	
	private Subscriber subscriber;
	
	final public String getRootPath() {
		return Holders.config.grails.serverURL
	}

	final public void preExecute() {
		String openId = getParam(KEY_FromUserName)
		subscriber = Subscriber.findByOpenId(openId)
		if(!subscriber) {
			subscriber = new Subscriber()
			subscriber.openId = openId
			subscriber.save(flush:true)
		}
		
		Set<String> paramNames = paramNames()
		IncomeMessage sub = new IncomeMessage()
		sub.setContent(getParam(KEY_Content))
		
		sub.setCreateTime(Long.parseLong(getParam(KEY_CreateTime)))
		sub.setFromUserName(getParam(KEY_FromUserName)) 
		sub.setMsgId(getParam("MsgId"))
		sub.setMsgType(getParam(KEY_MsgType))
		sub.setToUserName(getParam(KEY_ToUserName))
		sub.save(flush:true)

		paramNames.remove(KEY_Content)
		paramNames.remove(KEY_CreateTime)
		paramNames.remove(KEY_FromUserName)
		paramNames.remove("MsgId")
		paramNames.remove(KEY_MsgType)
		paramNames.remove(KEY_ToUserName)

		paramNames.each {name ->
			AdditionalIncomeMessage a = new AdditionalIncomeMessage()
			a.setMessage(sub)
			a.setName(name)
			a.setValue(getParam(name))
			a.save(flush:true)
		}
		
	}
	
	protected Subscriber getSubscriber() {
		subscriber
	}
    
    protected boolean isMenu(String key) {
        getParam(Attribute.KEY_MsgType) == "event" && getParam("Event") == "CLICK" && getParam("EventKey") == key
    }
}
