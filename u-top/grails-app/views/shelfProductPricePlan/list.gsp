
<%@ page import="com.surelution.utop.ShelfProductPricePlan" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-shelfProductPricePlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="shelfProductPricePlan.new.label" args="[entityName]" /></g:link></li>
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
					
						<g:sortableColumn property="price" title="${message(code: 'shelfProductPricePlan.price.label', default: 'Price')}" />
					
						<g:sortableColumn property="costPrice" title="${message(code: 'shelfProductPricePlan.costPrice.label', default: 'Cost<br/>Price')}" />
					
						<g:sortableColumn property="retailPrice" title="${message(code: 'shelfProductPricePlan.retailPrice.label', default: 'Retail<br/>Price')}" />
					
						<g:sortableColumn property="activedStartAt" title="${message(code: 'shelfProductPricePlan.activedStartAt.label', default: 'Actived<br/>Start<br/>At')}" />
					
						<g:sortableColumn property="activedEndAt" title="${message(code: 'shelfProductPricePlan.activedEndAt.label', default: 'Actived<br/>End<br/>At')}" />
					
						<g:sortableColumn property="confirmed" title="${message(code: 'shelfProductPricePlan.confirmed.label', default: 'Confirmed')}" />
					
						<g:sortableColumn property="confirmedAt" title="${message(code: 'shelfProductPricePlan.confirmedAt.label', default: 'Confirmed<br/>At')}" />
					
						<th><g:message code="productPricePlan.confirmedBy.label" default="Confirmed By" /></th>
					
						<th><g:message code="productPricePlan.onSale.label" default="OnSale" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${shelfProductPricePlanInstanceList}" status="i" var="shelfProductPricePlanInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:checkBox name="id" value="${shelfProductPricePlanInstance.id}"/></td>
					
						<td><g:link action="show" id="${shelfProductPricePlanInstance.id}" target="_blank">${shelfProductPricePlanInstance.product.code}</g:link></td>
					
						<td NOWRAP>${shelfProductPricePlanInstance.product.name}</td>
					
						<td>${shelfProductPricePlanInstance.product.packingCount}</td>
					
						<td>${fieldValue(bean: shelfProductPricePlanInstance, field: "price")}</td>
					
						<td>${fieldValue(bean: shelfProductPricePlanInstance, field: "costPrice")}</td>
					
						<td>${fieldValue(bean: shelfProductPricePlanInstance, field: "retailPrice")}</td>
					
						<td><g:formatDate date="${shelfProductPricePlanInstance.activedStartAt}" /></td>
					
						<td><g:formatDate date="${shelfProductPricePlanInstance.activedEndAt}" /></td>
					
						<td><g:formatBoolean boolean="${shelfProductPricePlanInstance.confirmed}" /></td>
					
						<td>${fieldValue(bean: shelfProductPricePlanInstance, field: "confirmedAt")}</td>
					
						<td>${fieldValue(bean: shelfProductPricePlanInstance, field: "confirmedBy")}</td>
					
						<td><g:formatBoolean boolean="${shelfProductPricePlanInstance.onSale}" /></td>
					
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
