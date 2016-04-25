<%@ page import="com.surelution.utop.GroupBuyPriceRule" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-groupBuyPriceRule" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="groupBuyPriceRule.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-groupBuyPriceRule" class="content scaffold-create" role="main">
			<h1><g:message code="groupBuyPriceRule.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${groupBuyPriceRuleInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${groupBuyPriceRuleInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" >
				<fieldset class="form">
					<div class="fieldcontain ${hasErrors(bean: groupBuyPriceRuleInstance, field: 'amountFrom', 'error')} required">
						<label for="amountFrom">
							<g:message code="groupBuyPriceRule.amountFrom.label" default="Amount From" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="amountFrom" type="number" value="${groupBuyPriceRuleInstance.amountFrom}" required=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: groupBuyPriceRuleInstance, field: 'amountTo', 'error')} required">
						<label for="amountTo">
							<g:message code="groupBuyPriceRule.amountTo.label" default="Amount To" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="amountTo" type="number" value="${groupBuyPriceRuleInstance.amountTo}" required=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: groupBuyPriceRuleInstance, field: 'plan', 'error')} required">
						<label for="plan">
							<g:message code="groupBuyPriceRule.plan.label" default="Plan" />
							<span class="required-indicator">*</span>																	
						</label>
						<g:select id="plan" name="plan.id" from="${com.surelution.utop.GroupProductPricePlan.list()}" optionKey="id" 
							optionValue="${{gppp -> "${gppp.product.name} ${"X"} ${gppp.product.packingCount} ${"，货号为:"}${gppp.product.code}"}}" value="${groupBuyPriceRuleInstance?.plan?.id}" required="" class="many-to-one"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: groupBuyPriceRuleInstance, field: 'price', 'error')} required">
						<label for="price">
							<g:message code="groupBuyPriceRule.price.label" default="Price" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="price" type="" value="${fieldValue(bean: groupBuyPriceRuleInstance, field: 'price')}" required=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: groupBuyPriceRuleInstance, field: 'settled', 'error')} ">
						<label for="settled">
							<g:message code="groupBuyPriceRule.settled.label" default="Settled" />
						</label>
						<g:checkBox name="settled" value="${groupBuyPriceRuleInstance?.settled}" />
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
