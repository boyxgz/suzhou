package com.surelution.utop

import groovy.time.TimeCategory;

import com.surelution.utop.SaleOrder.SaleOrderStatus;
import com.surelution.utop.Voucher.VoucherStatus;

class OrderFormController {

    def index() {
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		if(!to) {
			to = new Date()
		}
		if(!from) {
			use(TimeCategory) {
				from = to - 3.day
			}
		}
		def vouchers = Voucher.executeQuery("""
			from Voucher v where v.order.dateCreated between ? and ? and v.order.status = ? and v.status = ? order by v.id
		""", [from, to, SaleOrderStatus.QUERYED_TO_PAY, VoucherStatus.QUERIED_TO_USE])
		[vouchers:vouchers]
	}
	
	def reActive() { 
		def voucherIds = params.list('voucherId')
		voucherIds.each {
			Voucher voucher = Voucher.get(it)
			if(voucher.status == VoucherStatus.QUERIED_TO_USE) {
				voucher.status = VoucherStatus.NEW
				voucher.order = null
				voucher.writeOff = null
				voucher.save(flush:true)
			}
		}
		redirect(action:'index')
	}

	/**
	 * 加油站只可以激活受限时间的锁定码
	 * @return
	 */
	def limitedList() {
		def now = new Date()
		def from
		def to
		use(TimeCategory) {
			from = now - 60.minutes
			to = now - 2.minutes
		}
		def vouchers = Voucher.executeQuery("""
			from Voucher v where v.order.dateCreated between ? and ? and v.order.status = ? and v.status = ? order by v.id
		""", [from, to, SaleOrderStatus.QUERYED_TO_PAY, VoucherStatus.QUERIED_TO_USE])
		[vouchers:vouchers]
	}

	def limitedActive() {
		def voucherId = params.voucherId
		if(voucherId) {
			Voucher voucher = Voucher.get(voucherId)
			if(voucher?.status == VoucherStatus.QUERIED_TO_USE) {
				voucher.status = VoucherStatus.NEW
				voucher.order = null
				voucher.writeOff = null
				voucher.save(flush:true)
			}
		}
		redirect(action:'limitedList')
	}
	
}
