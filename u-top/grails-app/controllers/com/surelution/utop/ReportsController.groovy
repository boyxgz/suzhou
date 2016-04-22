package com.surelution.utop

import groovy.time.TimeCategory;

import com.surelution.utop.DeliveryTicket.DeliveryStatus
import com.surelution.utop.SaleOrder.SaleOrderStatus

class ReportsController {

	def springSecurityService

    def deliveryDetails() {
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		def tickets
		if(from || to) {
			tickets = DeliveryTicket.createCriteria().list {
				eq('status', DeliveryStatus.DELIVERIED)
				if(from) {
					ge('deliveredAt', from)
				}
				if(to) {
					le('deliveredAt', to)
				}
				eq('operator', springSecurityService.currentUser)
				order('deliveredAt')
			}
		}
		[tickets:tickets]
	}

	def orderDetails() {
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		def status
		if(params.status) {
			status = SaleOrderStatus.valueOf(params.status)
		}
		def orders
		if(from && to) {
			orders = SaleOrder.createCriteria().list() {
				if(from) {
					ge('dateCreated', from)
				}
				if(to) {
					le('dateCreated',to)
				}
				if(status) {
					eq('status', status)
				}
			}
		}
		[orders:orders]
	}

    def allDeliveryDetails() {
		def operator = User.get(params.userId)
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		def tickets
		if(from || to) {
			tickets = DeliveryTicket.createCriteria().list {
				eq('status', DeliveryStatus.DELIVERIED)
				if(from) {
					ge('deliveredAt', from)
				}
				if(to) {
					lt('deliveredAt', to)
				}
				if(operator) {
					eq('operator', operator)
				}
				and{
					order('operator')
					order('deliveredAt')
				}
			}
		}
		[tickets:tickets]
	}

    def deliverySummary() {
		def operator = User.get(params.userId)
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		def items
		if(from && to && operator) {
			items = SaleOrderItem.executeQuery("""
				select soi.plan, sum(soi.itemCount) from SaleOrderItem soi, DeliveryTicket dt where soi.order = dt.saleOrder
				and dt.status = :status and dt.deliveredAt >= :from and dt.deliveredAt < :to 
				and dt.operator = :operator group by soi.plan
			""", [status:DeliveryStatus.DELIVERIED, from:from, to:to, operator:operator])
		}
		[items:items]
	}
	
	def dailySaleSummaryWithProduct() {
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		def items
		def users
		if(from && to) {
			def role = Role.findByAuthority("ROLE_STATION")
			users = UserRole.findAllByRole(role).collect() {
				it.user
			}
			def sb = new StringBuilder()
			sb.append("select soi.plan ")
			users.each {
				sb.append(", sum(case dt.operator.id when ")
				sb.append(it.id)
				sb.append(" then soi.itemCount else 0 end) ")
			}
			sb.append("""
				 from SaleOrderItem soi, DeliveryTicket dt where soi.order = dt.saleOrder
				and dt.status = :status and dt.deliveredAt >= :from and dt.deliveredAt < :to 
				group by soi.plan
			""")
			items = SaleOrderItem.executeQuery(sb.toString(), [status:DeliveryStatus.DELIVERIED, from:from, to:to])
		}
		[items:items, users:users]
	}
	
	def dailySaleSummaryWithProductOfStation() {
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		def items
		def user = springSecurityService.currentUser
		if(from && to) {
			def role = Role.findByAuthority("ROLE_STATION")
			def sb = new StringBuilder()
			sb.append("""
				select soi.plan, sum(soi.itemCount)
				from SaleOrderItem soi, DeliveryTicket dt where soi.order = dt.saleOrder
				and dt.status = :status and dt.deliveredAt >= :from and dt.deliveredAt < :to 
				and dt.operator = :operator
				group by soi.plan
			""")
			items = SaleOrderItem.executeQuery(sb.toString(), [status:DeliveryStatus.DELIVERIED, from:from, to:to, operator:user])
		}
		[items:items, user:user]
	}
	
	def dailySaleSummary() {
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		def items
		def users
		if(from && to) {
			def role = Role.findByAuthority("ROLE_STATION")
			users = UserRole.findAllByRole(role).collect() {
				it.user
			}
			def sb = new StringBuilder()
			sb.append("select cast(dt.deliveredAt as date) as d")
			users.each {
				sb.append(", sum(case dt.operator.id when ")
				sb.append(it.id)
				sb.append(" then (soi.itemCount * soi.plan.price) else 0 end) ")

				sb.append(", sum(case dt.operator.id when ")
				sb.append(it.id)
				sb.append(" then 1 else 0 end) ")
			}
			sb.append("""
				 from SaleOrderItem soi, DeliveryTicket dt where soi.order = dt.saleOrder
				and dt.status = :status and dt.deliveredAt >= :from and dt.deliveredAt < :to 
				group by cast(dt.deliveredAt as date) order by d desc
			""")
			items = SaleOrderItem.executeQuery(sb.toString(), [status:DeliveryStatus.DELIVERIED, from:from, to:to])
		}
		[items:items, users:users]
	}
	
	def adPageScanningSummary() {
		def from = params.date('dateFrom','yyyy-MM-dd HH:mm')
		def to = params.date('dateTo','yyyy-MM-dd HH:mm')
		if(!from) {
			use(TimeCategory) {
				from = new Date() - 7.days
			}
		}
		if(!to) {
			to = new Date()
		}
		def summary = AdPageScanning.executeQuery("select distinct count(a.subscriber.id), a.channel, cast(a.dateCreated as date) as d from AdPageScanning a where a.dateCreated between :from and :to group by a.channel, cast(a.dateCreated as date) order by a.channel,d",
			[from:from, to:to])
		[summary:summary]
	}
}
