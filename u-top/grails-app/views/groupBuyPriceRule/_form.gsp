<%@ page import="com.surelution.utop.GroupBuyPriceRule" %>



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
	<g:select id="plan" name="plan.id" from="${com.surelution.utop.GroupProductPricePlan.list()}" optionKey="id" required="" value="${groupBuyPriceRuleInstance?.plan?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: groupBuyPriceRuleInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="groupBuyPriceRule.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="price" value="${fieldValue(bean: groupBuyPriceRuleInstance, field: 'price')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: groupBuyPriceRuleInstance, field: 'settled', 'error')} ">
	<label for="settled">
		<g:message code="groupBuyPriceRule.settled.label" default="Settled" />
		
	</label>
	<g:checkBox name="settled" value="${groupBuyPriceRuleInstance?.settled}" />
</div>

