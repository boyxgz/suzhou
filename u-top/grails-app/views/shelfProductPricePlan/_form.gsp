<%@ page import="com.surelution.utop.ShelfProductPricePlan" %>



<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'confirmedAt', 'error')} ">
	<label for="confirmedAt">
		<g:message code="shelfProductPricePlan.confirmedAt.label" default="Confirmed At" />
		
	</label>
	<g:datePicker name="confirmedAt" precision="day"  value="${shelfProductPricePlanInstance?.confirmedAt}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'confirmedBy', 'error')} ">
	<label for="confirmedBy">
		<g:message code="shelfProductPricePlan.confirmedBy.label" default="Confirmed By" />
		
	</label>
	<g:select id="confirmedBy" name="confirmedBy.id" from="${com.surelution.utop.User.list()}" optionKey="id" value="${shelfProductPricePlanInstance?.confirmedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'productPicId', 'error')} ">
	<label for="productPicId">
		<g:message code="shelfProductPricePlan.productPicId.label" default="Product Pic Id" />
		
	</label>
	<g:field name="productPicId" type="number" value="${shelfProductPricePlanInstance.productPicId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'activedEndAt', 'error')} required">
	<label for="activedEndAt">
		<g:message code="shelfProductPricePlan.activedEndAt.label" default="Actived End At" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="activedEndAt" precision="day"  value="${shelfProductPricePlanInstance?.activedEndAt}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'activedStartAt', 'error')} required">
	<label for="activedStartAt">
		<g:message code="shelfProductPricePlan.activedStartAt.label" default="Actived Start At" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="activedStartAt" precision="day"  value="${shelfProductPricePlanInstance?.activedStartAt}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'confirmed', 'error')} ">
	<label for="confirmed">
		<g:message code="shelfProductPricePlan.confirmed.label" default="Confirmed" />
		
	</label>
	<g:checkBox name="confirmed" value="${shelfProductPricePlanInstance?.confirmed}" />
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'costPrice', 'error')} required">
	<label for="costPrice">
		<g:message code="shelfProductPricePlan.costPrice.label" default="Cost Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="costPrice" value="${fieldValue(bean: shelfProductPricePlanInstance, field: 'costPrice')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'index', 'error')} required">
	<label for="index">
		<g:message code="shelfProductPricePlan.index.label" default="Index" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="index" type="number" value="${shelfProductPricePlanInstance.index}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'onSale', 'error')} ">
	<label for="onSale">
		<g:message code="shelfProductPricePlan.onSale.label" default="On Sale" />
		
	</label>
	<g:checkBox name="onSale" value="${shelfProductPricePlanInstance?.onSale}" />
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="shelfProductPricePlan.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="price" value="${fieldValue(bean: shelfProductPricePlanInstance, field: 'price')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'product', 'error')} required">
	<label for="product">
		<g:message code="shelfProductPricePlan.product.label" default="Product" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="product" name="product.id" from="${com.surelution.utop.Product.list()}" optionKey="id" required="" value="${shelfProductPricePlanInstance?.product?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'retailPrice', 'error')} required">
	<label for="retailPrice">
		<g:message code="shelfProductPricePlan.retailPrice.label" default="Retail Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="retailPrice" value="${fieldValue(bean: shelfProductPricePlanInstance, field: 'retailPrice')}" required=""/>
</div>

