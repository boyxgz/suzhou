package com.surelution.utop

class Product {

    static constraints = {
		description nullable:true
		spec nullable:true
		exercisePrice nullable:true
		extroInfo nullable:true
		reason nullable:true
		index nullable:true
    }
	
	static mapping = {
		cache true
		index column:'_index'
	}
	
	static transients = ['settlementPrice', 'nameWithCount', 'defaultPictureId']

	String name
	Category category
	String description
	String spec
	BigDecimal price
	BigDecimal exercisePrice
	String extroInfo
	String reason
	Date dateCreated
	Date lastUpdated
	String code
	Boolean onSale = true
	Integer index = 0

	/**
	 * 由于中油便利店系统设置，没有整箱销售的概念，如一瓶可乐3元，整箱6瓶15元销售，做不到，
	 * 顾设置整箱件数字段
	 */
	Integer packingCount = 1
	
	public Float getSettlementPrice() {
		return exercisePrice?exercisePrice:price
	}
	
	public String getNameWithCount() {
		if(packingCount > 1) {
			return "${name} X ${packingCount}"
		} else {
			return name
		}
	}
	
	public Long getDefaultPictureId() {
		ProductPicture.findAllByProduct(this).min{it.index}?.file?.id
	}
}
