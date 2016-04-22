/**
 * 
 */
package com.surelution.utop

import java.text.SimpleDateFormat

import com.surelution.whistle.core.Attribute

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
class SubscribingAction extends UtopBaseAction {
	
	private static SimpleDateFormat SDF = new SimpleDateFormat("yyyyMMddHHmmss") 

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#accept()
	 */
	@Override
	public boolean accept() {
		getParam(Attribute.KEY_MsgType) == "event" && 
			(getParam("Event") == "subscribe" || getParam("Event") == "SCAN")
	}

	/* (non-Javadoc)
	 * @see com.surelution.whistle.core.BaseAction#execute()
	 */
	@Override
	public void execute() {
		subscriber.subscribed = true
		subscriber.save(flush:true)
		if(getParam("Event") == "subscribe") {
			def eventKey = getParam("EventKey")
			if(eventKey && eventKey.startsWith("qrscene_")) {
				def qrId = eventKey.substring("qrscene_".length())
				saveChannel(qrId)
			}
		}
		if(getParam("Event") == "SCAN") {
			def qrId = getParam("EventKey")
			saveChannel(qrId)
		}
		def withGift = AppVar.findByKey("subscribing-with-gift")?.value
		if("1" == withGift) {
			def vt = VoucherType.findByKey("subscribing_voucher")
			def voucher = Voucher.findBySubscriberAndType(subscriber, vt)
			if(!voucher) {
				String giftAmount = AppVar.findByKey("subscribing-gift-amount")?.value
				String expiredAt = AppVar.findByKey("subscribing-gift-expired-at")?.value
				if(!giftAmount) {
					giftAmount = "4"
				}
				if(!expiredAt) {
					expiredAt = "20151001000000"
				}
				voucher = new Voucher()
				voucher.subscriber = subscriber
				voucher.type = vt
				voucher.amount = giftAmount as BigDecimal
				voucher.enabled = true
				voucher.expiredAt = SDF.parse(expiredAt)
				voucher.save(flush:true)
			}
		}
		def welcomeMsg = KeyedMessage.findByKey("welcome-message")?.message
		put(new Attribute(Attribute.KEY_Content, welcomeMsg))
	}

	private void saveChannel(String qrId) {
		if(!SubscriberChannel.countBySubscriber(subscriber)) {
			def channel = QrChannel.findByQrNo(qrId)
			if(channel) {
				def sc = new SubscriberChannel()
				sc.subscriber = subscriber
				sc.channel = channel
				sc.save(flush:true)
			}
		}
	}
}
