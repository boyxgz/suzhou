
<%@ page import="com.surelution.utop.GroupProductPricePlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-groupProductPricePlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="groupProductPricePlan.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<h1>待确认价格计划</h1>
		<div id="list-productPricePlan" class="content scaffold-list" role="main" style="overflow: scroll;">
		<g:form action="confirm">
			<table>
				<thead>
					<tr>
					
						<th>确认</th>
					
						<g:sortableColumn property="product" title="${message(code: 'product.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="product" title="${message(code: 'product.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="product" title="${message(code: 'product.packingCount.label', default: 'Packing<br/>Count')}" />
					
						<g:sortableColumn property="costPrice" title="${message(code: 'groupProductPricePlan.costPrice.label', default: 'Cost<br/>Price')}" />
					
						<g:sortableColumn property="retailPrice" title="${message(code: 'groupProductPricePlan.retailPrice.label', default: 'Retail<br/>Price')}" />
					
						<g:sortableColumn  property="activedStartAt" title="${message(code: 'groupProductPricePlan.activedStartAt.label', default: 'Actived<br/>Start<br/>At')}" />
					
						<g:sortableColumn  property="activedEndAt" title="${message(code: 'groupProductPricePlan.activedEndAt.label', default: 'Actived<br/>End<br/>At')}" />
					
						<g:sortableColumn property="confirmed" title="${message(code: 'groupProductPricePlan.confirmed.label', default: 'Confirmed')}" />
					
						<g:sortableColumn property="confirmedAt" title="${message(code: 'groupProductPricePlan.confirmedAt.label', default: 'Confirmed<br/>At')}" />
					
						<th><g:message code="productPricePlan.confirmedBy.label" default="Confirmed By" /></th>
					
						<th><g:message code="productPricePlan.onSale.label" default="OnSale" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${groupProductPricePlanInstanceList}" status="i" var="groupProductPricePlanInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:checkBox name="id" value="${groupProductPricePlanInstance.id}"/></td>
					
						<td><g:link action="show" id="${groupProductPricePlanInstance.id}" target="_blank">${groupProductPricePlanInstance.product.code}</g:link></td>
					
						<td NOWRAP>${groupProductPricePlanInstance.product.name}</td>
					
						<td>${groupProductPricePlanInstance.product.packingCount}</td>
					
						<td>${fieldValue(bean: groupProductPricePlanInstance, field: "costPrice")}</td>
					
						<td>${fieldValue(bean: groupProductPricePlanInstance, field: "retailPrice")}</td>
					
						<td NOWRAP><g:formatDate date="${groupProductPricePlanInstance.activedStartAt}" /></td>
					
						<td NOWRAP><g:formatDate date="${groupProductPricePlanInstance.activedEndAt}" /></td>
					
						<td><g:formatBoolean boolean="${groupProductPricePlanInstance.confirmed}" /></td>
					
						<td>${fieldValue(bean: groupProductPricePlanInstance, field: "confirmedAt")}</td>
					
						<td>${fieldValue(bean: groupProductPricePlanInstance, field: "confirmedBy")}</td>
					
						<td><g:formatBoolean boolean="${groupProductPricePlanInstance.onSale}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<fieldset class="buttons">
				<g:actionSubmit action="confirm" value="确认" onclick="return confirm('确定要确认上述价格计划吗？');"/>
			</fieldset>
			</g:form>
		</div>
	</body>
</html>
