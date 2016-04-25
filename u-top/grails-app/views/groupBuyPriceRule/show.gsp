
<%@ page import="com.surelution.utop.GroupBuyPriceRule" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-groupBuyPriceRule" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="groupBuyPriceRule.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="groupBuyPriceRule.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-groupBuyPriceRule" class="content scaffold-show" role="main">
			<h1><g:message code="groupBuyPriceRule.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list groupBuyPriceRule">
			
				<g:if test="${groupBuyPriceRuleInstance?.amountFrom}">
				<li class="fieldcontain">
					<span id="amountFrom-label" class="property-label"><g:message code="groupBuyPriceRule.amountFrom.label" default="Amount From" /></span>
					
						<span class="property-value" aria-labelledby="amountFrom-label"><g:fieldValue bean="${groupBuyPriceRuleInstance}" field="amountFrom"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupBuyPriceRuleInstance?.amountTo}">
				<li class="fieldcontain">
					<span id="amountTo-label" class="property-label"><g:message code="groupBuyPriceRule.amountTo.label" default="Amount To" /></span>
					
						<span class="property-value" aria-labelledby="amountTo-label"><g:fieldValue bean="${groupBuyPriceRuleInstance}" field="amountTo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupBuyPriceRuleInstance?.plan}">
				<li class="fieldcontain">
					<span id="plan-label" class="property-label"><g:message code="groupBuyPriceRule.plan.label" default="Plan" /></span>
					
						<span class="property-value" aria-labelledby="plan-label">
							<g:link controller="groupProductPricePlan" action="show" id="${groupBuyPriceRuleInstance?.plan?.id}">
								${groupBuyPriceRuleInstance?.plan?.product?.name} X ${groupBuyPriceRuleInstance?.plan?.product?.packingCount}， 货号为  ${groupBuyPriceRuleInstance?.plan?.product?.code}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupBuyPriceRuleInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="groupBuyPriceRule.price.label" default="Price" /></span>
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${groupBuyPriceRuleInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${groupBuyPriceRuleInstance?.settled}">
				<li class="fieldcontain">
					<span id="settled-label" class="property-label"><g:message code="groupBuyPriceRule.settled.label" default="Settled" /></span>
					
						<span class="property-value" aria-labelledby="settled-label"><g:formatBoolean boolean="${groupBuyPriceRuleInstance?.settled}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${groupBuyPriceRuleInstance?.id}" />
					<g:link class="edit" action="edit" id="${groupBuyPriceRuleInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
