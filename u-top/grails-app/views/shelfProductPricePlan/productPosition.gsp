
<%@ page import="com.surelution.utop.ProductPricePlan" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'productPricePlan.label', default: 'ProductPricePlan')}" />
		<title>价格计划</title>
		
		<script type="text/javascript" src="${resource(file:'js/jquery-1.9.1.min.js') }"></script>
		<link href="${resource(dir:'css/jquery.datetimepicker.css')}" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${resource(file:'js/jquery.datetimepicker.js') }"></script>
		<script type="text/javascript">
			$( document ).ready(function() {
				$('#date').datetimepicker({
					dayOfWeekStart : 1,
					lang:'ch',
					format:'Y-m-d'
					});
			});
		</script>
	</head>
	<body>
		<a href="#list-productPricePlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="create-voucher">
			<h1>商品排序</h1>
			<g:form action="productPosition">
				<fieldset class="form">
					<div class="fieldcontain">
						<label for="dateFrom">
							<g:message code="voucher.paidAt.dateFrom.label" default="时间" />
							
						</label>
						<%
							def df = params.dateFrom
							def sdf = new SimpleDateFormat("yyyy-MM-dd")
							if(!df) {
								def f = new Date().clearTime()
								f.setDate(f.getDate() - 1)
								f.setHours(16)
								df = sdf.format(f)
							}
						 %>
						 <g:textField name="date" value="${df}"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.search.label', default: '查询')}" />
				</fieldset>
			</g:form>
		</div>
		 <h1>待确认价格计划</h1>
		<div id="list-productPricePlan" class="content scaffold-list" role="main" style="overflow: scroll;">
		<g:form action="updateProductPosition">
			<table>
				<thead>
					<tr>
					
						<th>确认</th>
					
						<g:sortableColumn property="product" title="${message(code: 'product.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="product" title="${message(code: 'product.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="product" title="${message(code: 'product.packingCount.label', default: 'Packing<br/>Count')}" />
					
						<g:sortableColumn property="price" title="${message(code: 'productPricePlan.price.label', default: 'Price')}" />
					
						<g:sortableColumn property="costPrice" title="${message(code: 'productPricePlan.costPrice.label', default: 'Cost<br/>Price')}" />
					
						<g:sortableColumn property="retailPrice" title="${message(code: 'productPricePlan.retailPrice.label', default: 'Retail<br/>Price')}" />
					
						<g:sortableColumn property="activedStartAt" title="${message(code: 'productPricePlan.activedStartAt.label', default: 'Actived<br/>Start<br/>At')}" />
					
						<g:sortableColumn property="activedEndAt" title="${message(code: 'productPricePlan.activedEndAt.label', default: 'Actived<br/>End<br/>At')}" />
					
						<g:sortableColumn property="confirmed" title="${message(code: 'productPricePlan.confirmed.label', default: 'Confirmed')}" />
					
						<g:sortableColumn property="confirmedAt" title="${message(code: 'productPricePlan.confirmedAt.label', default: 'Confirmed<br/>At')}" />
					
						<th><g:message code="productPricePlan.confirmedBy.label" default="Confirmed By" /></th>
					
						<th><g:message code="productPricePlan.onSale.label" default="OnSale" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${shelfProductPricePlanInstanceList}" status="i" var="shelfProductPricePlanInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:textField name="plan-id-${shelfProductPricePlanInstance.id }" value="${shelfProductPricePlanInstance.index }" size="3"/></td>
					
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
					
						<td>${shelfProductPricePlanInstance?.confirmedBy?.username}</td>
					
						<td><g:formatBoolean boolean="${shelfProductPricePlanInstance.onSale}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<fieldset class="buttons">
				<g:actionSubmit action="updateProductPosition" value="更新"/>
			</fieldset>
			</g:form>
		</div>
	</body>
</html>
