package com.surelution.utop

import com.surelution.whistle.core.Attribute

/**
 * 支持用户用微信扫描客人客人手机发货<br/>
 * @author johnny
 *
 */
class QrUserLogin extends TempQrCode {

    static constraints = {
		dateScanned nullable:true
		dateConfirmed nullable:true
		dateLogout nullable:true
		subscriber nullable:true
    }

	User user
	Date dateScanned
	Date dateConfirmed
	Date dateLogout
	Subscriber subscriber
	String validationCode
	Boolean actived = true
	Boolean loggedIn = false
	
	public Attribute scanedBy(Subscriber subscriber) {
		def msg
		if(dateScanned) {
			msg = "已有其他人扫描了该二维码，请勿重复扫描，如果确定登录，请刷新登录页的二维码，再次扫描。注意不要让其他人扫描"
		} else {
			def login = QrUserLogin.findBySubscriberAndLoggedIn(subscriber, true)
			if(login) {
				msg = "你已经在${login.user.username}登录"
			} else {
				this.dateScanned = new Date()
				this.subscriber = subscriber
				save(flush:true)
				msg = "您正在登录系统，确认后将作为${user.username}的发货员，可以执行发货操作，您的验证码是：${validationCode}"
			}
		}
		new Attribute(Attribute.KEY_Content, msg)
	}
}
