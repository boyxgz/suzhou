package com.surelution.utop

class SaleOrder {

    static constraints = {
		amount nullable:true
		station nullable:true
    }
	static transients = ['itemCount', 'supposedAmount', 'realIncome']
	static mapping = {
		status column:"_status"
	}

	Subscriber subscriber
	SaleOrderStatus status
	BigDecimal amount
	Station station
	
	Date dateCreated

	/**
	 * 
	 * @return 商品件数
	 */
	public Integer getItemCount() {
		return SaleOrderItem.createCriteria().get {
			projections {
				sum('itemCount')
			}
			eq('order', this)
		}
	}

	public Integer getRealIncome() {
		def amount = Payment.findByOrderAndConfirmedFromWx(this, true)?.amount
		amount?amount:0
	}

	/**
	 * 
	 * @return 根据商品单价、数量，应该付款金额，不包括折扣、抵用等
	 */
	public Float getSupposedAmount() {
		return SaleOrderItem.findAllByOrder(this).sum{it.itemCount * it.plan.price}
	}
	
	enum SaleOrderStatus {
		NEW, //新建
		DELETED, //删除
		QUERYED_TO_PAY, //申请支付
		WAITING_FOR_PAY_CONFIRM,
		PAID, //收到支付反馈
		DELIVERED //用户已提货
		
		public String toString() {
			KeyedMessage.populate("SaleOrderStatus-${name()}")
		}
	}
}
