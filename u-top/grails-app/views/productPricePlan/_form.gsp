<%@ page import="com.surelution.utop.ProductPricePlan" %>



<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'confirmedAt', 'error')} ">
	<label for="confirmedAt">
		<g:message code="productPricePlan.confirmedAt.label" default="Confirmed At" />
		
	</label>
	<g:datePicker name="confirmedAt" precision="day"  value="${productPricePlanInstance?.confirmedAt}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'confirmedBy', 'error')} ">
	<label for="confirmedBy">
		<g:message code="productPricePlan.confirmedBy.label" default="Confirmed By" />
		
	</label>
	<g:select id="confirmedBy" name="confirmedBy.id" from="${com.surelution.utop.User.list()}" optionKey="id" value="${productPricePlanInstance?.confirmedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'activedEndAt', 'error')} required">
	<label for="activedEndAt">
		<g:message code="productPricePlan.activedEndAt.label" default="Actived End At" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="activedEndAt" precision="day"  value="${productPricePlanInstance?.activedEndAt}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'activedStartAt', 'error')} required">
	<label for="activedStartAt">
		<g:message code="productPricePlan.activedStartAt.label" default="Actived Start At" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="activedStartAt" precision="day"  value="${productPricePlanInstance?.activedStartAt}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'confirmed', 'error')} ">
	<label for="confirmed">
		<g:message code="productPricePlan.confirmed.label" default="Confirmed" />
		
	</label>
	<g:checkBox name="confirmed" value="${productPricePlanInstance?.confirmed}" />
</div>

<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'costPrice', 'error')} required">
	<label for="costPrice">
		<g:message code="productPricePlan.costPrice.label" default="Cost Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="costPrice" value="${fieldValue(bean: productPricePlanInstance, field: 'costPrice')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'onSale', 'error')} ">
	<label for="onSale">
		<g:message code="productPricePlan.onSale.label" default="On Sale" />
		
	</label>
	<g:checkBox name="onSale" value="${productPricePlanInstance?.onSale}" />
</div>

<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="productPricePlan.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="price" value="${fieldValue(bean: productPricePlanInstance, field: 'price')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'product', 'error')} required">
	<label for="product">
		<g:message code="productPricePlan.product.label" default="Product" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="product" name="product.id" from="${com.surelution.utop.Product.list()}" optionKey="id" required="" value="${productPricePlanInstance?.product?.id}" class="many-to-one"/>
</div>

