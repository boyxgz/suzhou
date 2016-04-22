
<%@ page import="com.surelution.utop.ProductPricePlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'productPricePlan.label', default: 'ProductPricePlan')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-productPricePlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="show-productPricePlan" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list productPricePlan">
			
				<li class="fieldcontain">
					<span id="product-label" class="property-label"><g:message code="product.name.label" default="Product" /></span>
					
					<span class="property-value" aria-labelledby="product-label">${productPricePlanInstance?.product?.name}</span>
					
				</li>
			
				<li class="fieldcontain">
					<span id="product-label" class="property-label"><g:message code="product.code.label" default="Code" /></span>
					
					<span class="property-value" aria-labelledby="product-label">${productPricePlanInstance?.product?.code}</span>
					
				</li>
			
				<li class="fieldcontain">
					<span id="product-label" class="property-label"><g:message code="product.packingCount.label" default="Packing Count" /></span>
					
					<span class="property-value" aria-labelledby="product-label">${productPricePlanInstance?.product?.packingCount}</span>
					
				</li>
			
				<g:if test="${productPricePlanInstance?.activedStartAt}">
				<li class="fieldcontain">
					<span id="activedStartAt-label" class="property-label"><g:message code="productPricePlan.activedStartAt.label" default="Actived Start At" /></span>
					
						<span class="property-value" aria-labelledby="activedStartAt-label"><g:formatDate date="${productPricePlanInstance?.activedStartAt}" format="yyyy-MM-dd HH:mm"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productPricePlanInstance?.activedEndAt}">
				<li class="fieldcontain">
					<span id="activedEndAt-label" class="property-label"><g:message code="productPricePlan.activedEndAt.label" default="Actived End At" /></span>
					
						<span class="property-value" aria-labelledby="activedEndAt-label"><g:formatDate date="${productPricePlanInstance?.activedEndAt}" format="yyyy-MM-dd HH:mm"/></span>
					
				</li>
				</g:if>
			
				<li class="fieldcontain">
					<span id="confirmed-label" class="property-label"><g:message code="productPricePlan.confirmed.label" default="Confirmed" /></span>
					
						<span class="property-value" aria-labelledby="confirmed-label"><g:formatBoolean boolean="${productPricePlanInstance?.confirmed}" /></span>
					
				</li>
			
				<g:if test="${productPricePlanInstance?.costPrice}">
				<li class="fieldcontain">
					<span id="costPrice-label" class="property-label"><g:message code="productPricePlan.costPrice.label" default="Cost Price" /></span>
					
						<span class="property-value" aria-labelledby="costPrice-label"><g:fieldValue bean="${productPricePlanInstance}" field="costPrice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productPricePlanInstance?.retailPrice}">
				<li class="fieldcontain">
					<span id="retailPrice-label" class="property-label"><g:message code="productPricePlan.retailPrice.label" default="Retail Price" /></span>
					
						<span class="property-value" aria-labelledby="retailPrice-label"><g:fieldValue bean="${productPricePlanInstance}" field="retailPrice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productPricePlanInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="productPricePlan.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${productPricePlanInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productPricePlanInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="productPricePlan.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${productPricePlanInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<li class="fieldcontain">
					<span id="onSale-label" class="property-label"><g:message code="productPricePlan.onSale.label" default="On Sale" /></span>
					
						<span class="property-value" aria-labelledby="onSale-label"><g:formatBoolean boolean="${productPricePlanInstance?.onSale}" /></span>
					
				</li>
			
				<g:if test="${productPricePlanInstance?.confirmedAt}">
				<li class="fieldcontain">
					<span id="confirmedAt-label" class="property-label"><g:message code="productPricePlan.confirmedAt.label" default="Confirmed At" /></span>
					
						<span class="property-value" aria-labelledby="confirmedAt-label"><g:formatDate date="${productPricePlanInstance?.confirmedAt}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${productPricePlanInstance?.confirmedBy}">
				<li class="fieldcontain">
					<span id="confirmedBy-label" class="property-label"><g:message code="productPricePlan.confirmedBy.label" default="Confirmed By" /></span>
					
						<span class="property-value" aria-labelledby="confirmedBy-label">${productPricePlanInstance?.confirmedBy?.username}</span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${productPricePlanInstance?.id}" />
					<g:link class="edit" action="edit" id="${productPricePlanInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
