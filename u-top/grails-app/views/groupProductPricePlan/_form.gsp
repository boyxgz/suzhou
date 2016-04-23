<%@ page import="com.surelution.utop.GroupProductPricePlan" %>



<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'confirmedAt', 'error')} ">
	<label for="confirmedAt">
		<g:message code="groupProductPricePlan.confirmedAt.label" default="Confirmed At" />
		
	</label>
	<g:datePicker name="confirmedAt" precision="day"  value="${groupProductPricePlanInstance?.confirmedAt}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'confirmedBy', 'error')} ">
	<label for="confirmedBy">
		<g:message code="groupProductPricePlan.confirmedBy.label" default="Confirmed By" />
		
	</label>
	<g:select id="confirmedBy" name="confirmedBy.id" from="${com.surelution.utop.User.list()}" optionKey="id" value="${groupProductPricePlanInstance?.confirmedBy?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'productPicId', 'error')} ">
	<label for="productPicId">
		<g:message code="groupProductPricePlan.productPicId.label" default="Product Pic Id" />
		
	</label>
	<g:field name="productPicId" type="number" value="${groupProductPricePlanInstance.productPicId}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'activedEndAt', 'error')} required">
	<label for="activedEndAt">
		<g:message code="groupProductPricePlan.activedEndAt.label" default="Actived End At" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="activedEndAt" precision="day"  value="${groupProductPricePlanInstance?.activedEndAt}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'activedStartAt', 'error')} required">
	<label for="activedStartAt">
		<g:message code="groupProductPricePlan.activedStartAt.label" default="Actived Start At" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="activedStartAt" precision="day"  value="${groupProductPricePlanInstance?.activedStartAt}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'confirmed', 'error')} ">
	<label for="confirmed">
		<g:message code="groupProductPricePlan.confirmed.label" default="Confirmed" />
		
	</label>
	<g:checkBox name="confirmed" value="${groupProductPricePlanInstance?.confirmed}" />
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'costPrice', 'error')} required">
	<label for="costPrice">
		<g:message code="groupProductPricePlan.costPrice.label" default="Cost Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="costPrice" value="${fieldValue(bean: groupProductPricePlanInstance, field: 'costPrice')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'index', 'error')} required">
	<label for="index">
		<g:message code="groupProductPricePlan.index.label" default="Index" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="index" type="number" value="${groupProductPricePlanInstance.index}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'onSale', 'error')} ">
	<label for="onSale">
		<g:message code="groupProductPricePlan.onSale.label" default="On Sale" />
		
	</label>
	<g:checkBox name="onSale" value="${groupProductPricePlanInstance?.onSale}" />
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'product', 'error')} required">
	<label for="product">
		<g:message code="groupProductPricePlan.product.label" default="Product" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="product" name="product.id" from="${com.surelution.utop.Product.list()}" optionKey="id" required="" value="${groupProductPricePlanInstance?.product?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'retailPrice', 'error')} required">
	<label for="retailPrice">
		<g:message code="groupProductPricePlan.retailPrice.label" default="Retail Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="retailPrice" value="${fieldValue(bean: groupProductPricePlanInstance, field: 'retailPrice')}" required=""/>
</div>

