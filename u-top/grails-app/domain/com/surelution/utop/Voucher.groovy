package com.surelution.utop

import com.surelution.id.IDUtil

class Voucher {

    static constraints = {
		order nullable:true
		sn nullable:true
		writeOff nullable:true
    }

	static mapping = {
		type column:"_type"
		order column:'_order'
		status column:'_status'
	}
	
	static transients = ['couldPay']

	def afterInsert() {
		sn = IDUtil.getRefusedId(id.intValue(), 6)
		save()
	}

	Subscriber subscriber
	String sn
	BigDecimal amount
	BigDecimal writeOff
	Date expiredAt
	Boolean enabled
	SaleOrder order
	VoucherType type
	VoucherStatus status = VoucherStatus.NEW

	Boolean getCouldPay() {
		enabled && status == VoucherStatus.NEW && expiredAt >= new Date()
	}

	enum VoucherStatus {
		NEW, // 新建
		QUERIED_TO_USE, //声明要使用，但是尚未确定使用
		USED //已使用

		public String toString() {
			KeyedMessage.populate("VoucherStatus-${name()}")
		}
	}
}
