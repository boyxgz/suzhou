package com.surelution.utop

import com.surelution.utop.Payment.PaymentStatus;
import com.surelution.utop.SaleOrder.SaleOrderStatus;
import com.surelution.utop.Voucher.VoucherStatus;

class BankrollDashboardController {

    def index() {
		def imprests = Imprest.findAllByConfirmed(true)
		def payments = Payment.findAllByStatus(PaymentStatus.PAID)
		def orders = SaleOrder.findAllByStatus(SaleOrderStatus.DELIVERED)
		def vouchers = Voucher.findAllByStatus(VoucherStatus.USED)
		
		def payPermit = AppVar.findByKey("PAY-PERMIT")?.value
		
		[imprests:imprests, payments:payments, orders:orders, vouchers:vouchers, payPermit:payPermit]
	}
	
	def turnOff() {
		def av = AppVar.findByKey("PAY-PERMIT")
		if(!av) {
			av = new AppVar()
			av.key = "PAY-PERMIT"
		}
		av.value = "0"
		av.save(flush:true)
		redirect(action:'index')
	}
	
	def turnOn() {
		def av = AppVar.findByKey("PAY-PERMIT")
		if(!av) {
			av = new AppVar()
			av.key = "PAY-PERMIT"
		}
		av.value = "1"
		av.save(flush:true)
		redirect(action:'index')
	}
}
