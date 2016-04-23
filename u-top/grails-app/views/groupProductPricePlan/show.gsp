
<%@ page import="com.surelution.utop.GroupProductPricePlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-groupProductPricePlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="groupProductPricePlan.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="groupProductPricePlan.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-groupProductPricePlan" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list groupProductPricePlan">
				<li class="fieldcontain">
					<span id="product-label" class="property-label"><g:message code="product.name.label" default="Product" /></span>
					
					<span class="property-value" aria-labelledby="product-label">${groupProductPricePlanInstance?.product?.name}</span>
					
				</li>
			
				<li class="fieldcontain">
					<span id="product-label" class="property-label"><g:message code="product.code.label" default="Code" /></span>
					
					<span class="property-value" aria-labelledby="product-label">${groupProductPricePlanInstance?.product?.code}</span>
					
				</li>
			
				<li class="fieldcontain">
					<span id="product-label" class="property-label"><g:message code="product.packingCount.label" default="Packing Count" /></span>
					
					<span class="property-value" aria-labelledby="product-label">${groupProductPricePlanInstance?.product?.packingCount}</span>
					
				</li>
			
				<g:if test="${groupProductPricePlanInstance?.activedStartAt}">
				<li class="fieldcontain">
					<span id="activedStartAt-label" class="property-label"><g:message code="groupProductPricePlan.activedStartAt.label" default="Actived Start At" /></span>
					
						<span class="property-value" aria-labelledby="activedStartAt-label"><g:formatDate date="${groupProductPricePlanInstance?.activedStartAt}" format="yyyy-MM-dd HH:mm"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupProductPricePlanInstance?.activedEndAt}">
				<li class="fieldcontain">
					<span id="activedEndAt-label" class="property-label"><g:message code="groupProductPricePlan.activedEndAt.label" default="Actived End At" /></span>
					
						<span class="property-value" aria-labelledby="activedEndAt-label"><g:formatDate date="${groupProductPricePlanInstance?.activedEndAt}" format="yyyy-MM-dd HH:mm"/></span>
					
				</li>
				</g:if>
			
				<li class="fieldcontain">
					<span id="confirmed-label" class="property-label"><g:message code="groupProductPricePlan.confirmed.label" default="Confirmed" /></span>
					
						<span class="property-value" aria-labelledby="confirmed-label"><g:formatBoolean boolean="${groupProductPricePlanInstance?.confirmed}" /></span>
					
				</li>
			
				<g:if test="${groupProductPricePlanInstance?.costPrice}">
				<li class="fieldcontain">
					<span id="costPrice-label" class="property-label"><g:message code="groupProductPricePlan.costPrice.label" default="Cost Price" /></span>
					
						<span class="property-value" aria-labelledby="costPrice-label"><g:fieldValue bean="${groupProductPricePlanInstance}" field="costPrice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupProductPricePlanInstance?.retailPrice}">
				<li class="fieldcontain">
					<span id="retailPrice-label" class="property-label"><g:message code="groupProductPricePlan.retailPrice.label" default="Retail Price" /></span>
					
						<span class="property-value" aria-labelledby="retailPrice-label"><g:fieldValue bean="${groupProductPricePlanInstance}" field="retailPrice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupProductPricePlanInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="groupProductPricePlan.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${groupProductPricePlanInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<li class="fieldcontain">
					<span id="onSale-label" class="property-label"><g:message code="groupProductPricePlan.onSale.label" default="On Sale" /></span>
					
						<span class="property-value" aria-labelledby="onSale-label"><g:formatBoolean boolean="${groupProductPricePlanInstance?.onSale}" /></span>
					
				</li>
			
				<g:if test="${groupProductPricePlanInstance?.confirmedAt}">
				<li class="fieldcontain">
					<span id="confirmedAt-label" class="property-label"><g:message code="groupProductPricePlan.confirmedAt.label" default="Confirmed At" /></span>
					
						<span class="property-value" aria-labelledby="confirmedAt-label"><g:formatDate date="${groupProductPricePlanInstance?.confirmedAt}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupProductPricePlanInstance?.confirmedBy}">
				<li class="fieldcontain">
					<span id="confirmedBy-label" class="property-label"><g:message code="groupProductPricePlan.confirmedBy.label" default="Confirmed By" /></span>
					
						<span class="property-value" aria-labelledby="confirmedBy-label">${groupProductPricePlanInstance?.confirmedBy?.username}</span>
					
				</li>
				</g:if>				
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${groupProductPricePlanInstance?.id}" />
					<g:link class="edit" action="edit" id="${groupProductPricePlanInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
