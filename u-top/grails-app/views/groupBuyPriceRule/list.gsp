
<%@ page import="com.surelution.utop.GroupBuyPriceRule" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupBuyPriceRule.label', default: 'GroupBuyPriceRule')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-groupBuyPriceRule" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-groupBuyPriceRule" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="amountFrom" title="${message(code: 'groupBuyPriceRule.amountFrom.label', default: 'Amount From')}" />
					
						<g:sortableColumn property="amountTo" title="${message(code: 'groupBuyPriceRule.amountTo.label', default: 'Amount To')}" />
					
						<th><g:message code="groupBuyPriceRule.plan.label" default="Plan" /></th>
					
						<g:sortableColumn property="price" title="${message(code: 'groupBuyPriceRule.price.label', default: 'Price')}" />
					
						<g:sortableColumn property="settled" title="${message(code: 'groupBuyPriceRule.settled.label', default: 'Settled')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${groupBuyPriceRuleInstanceList}" status="i" var="groupBuyPriceRuleInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${groupBuyPriceRuleInstance.id}">${fieldValue(bean: groupBuyPriceRuleInstance, field: "amountFrom")}</g:link></td>
					
						<td>${fieldValue(bean: groupBuyPriceRuleInstance, field: "amountTo")}</td>
					
						<td>${fieldValue(bean: groupBuyPriceRuleInstance, field: "plan")}</td>
					
						<td>${fieldValue(bean: groupBuyPriceRuleInstance, field: "price")}</td>
					
						<td><g:formatBoolean boolean="${groupBuyPriceRuleInstance.settled}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${groupBuyPriceRuleInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
