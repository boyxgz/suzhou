<%@ page import="com.surelution.utop.Product" %>



<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="product.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${productInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'spec', 'error')} ">
	<label for="spec">
		<g:message code="product.spec.label" default="Spec" />
		
	</label>
	<g:textField name="spec" value="${productInstance?.spec}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'exercisePrice', 'error')} ">
	<label for="exercisePrice">
		<g:message code="product.exercisePrice.label" default="Exercise Price" />
		
	</label>
	<g:field name="exercisePrice" value="${fieldValue(bean: productInstance, field: 'exercisePrice')}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'extroInfo', 'error')} ">
	<label for="extroInfo">
		<g:message code="product.extroInfo.label" default="Extro Info" />
		
	</label>
	<g:textField name="extroInfo" value="${productInstance?.extroInfo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'reason', 'error')} ">
	<label for="reason">
		<g:message code="product.reason.label" default="Reason" />
		
	</label>
	<g:textField name="reason" value="${productInstance?.reason}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'category', 'error')} required">
	<label for="category">
		<g:message code="product.category.label" default="Category" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="category" name="category.id" from="${com.surelution.utop.Category.findAllByEnabled(true)}" optionKey="id" optionValue="name" required="" value="${productInstance?.category?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="product.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${productInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'packingCount', 'error')} ">
	<label for="packingCount">
		<g:message code="product.packingCount.label" default="Packing Count" />
		
	</label>
	<g:textField name="packingCount" value="${productInstance?.packingCount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'code', 'error')} ">
	<label for="code">
		<g:message code="product.code.label" default="Code" />
		
	</label>
	<g:textField name="code" value="${productInstance?.code}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'onSale', 'error')} ">
	<label for="onSale">
		<g:message code="product.onSale.label" default="On Sale" />
		
	</label>
	<g:checkBox name="onSale" value="${productInstance?.onSale}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="product.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="price" value="${fieldValue(bean: productInstance, field: 'price')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: productInstance, field: 'index', 'error')} required">
	<label for="index">
		<g:message code="product.index.label" default="Index" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="index" value="${fieldValue(bean: productInstance, field: 'index')}" required=""/>
</div>

