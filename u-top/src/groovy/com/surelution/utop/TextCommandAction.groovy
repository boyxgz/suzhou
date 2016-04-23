package com.surelution.utop

import menu.ConfigMenu

import com.surelution.whistle.core.Attribute
import com.surelution.whistle.core.Configure

class TextCommandAction extends BaseSuzhouAction {

	@Override
	public boolean accept() {
		 getParam(Attribute.KEY_MsgType) == Attribute.Msg_Type_TEXT
	}

	@Override
	public void execute() {
		def cmd = KeyedMessage.findByKey('TEXT-COMMAND')
		put(new Attribute(Attribute.KEY_Content, cmd.message))
	}
	
}
