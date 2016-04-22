
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
				$('#dateFrom').datetimepicker({
					dayOfWeekStart : 1,
					lang:'ch',
					format:'Y-m-d H:i'
					});
				$('#dateFrom').datetimepicker({step:10});
			});
			$( document ).ready(function() {
				$('#dateTo').datetimepicker({
					dayOfWeekStart : 1,
					lang:'ch',
					format:'Y-m-d H:i'
					});
				$('#dateTo').datetimepicker({step:10});
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
		<!-- 
		<div id="create-voucher">
			<h1>价格计划</h1>
			<g:form action="list">
				<fieldset class="form">
					<div class="fieldcontain">
						<label for="dateFrom">
							<g:message code="voucher.paidAt.dateFrom.label" default="开始时间" />
							
						</label>
						<%
							def df = params.dateFrom
							def sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm")
							if(!df) {
								def f = new Date().clearTime()
								f.setDate(f.getDate() - 1)
								f.setHours(16)
								df = sdf.format(f)
							}
							def dt = params.dateTo
							if(!dt) {
								def t = new Date().clearTime()
								t.setHours(16)
								dt = sdf.format(t)
							}
						 %>
						 <g:textField name="dateFrom" value="${df}"/>
					</div>
					<div class="fieldcontain">
						<label for="dateTo">
							<g:message code="voucher.paidAt.dateTo.label" default="结束时间" />
							
						</label>
						<g:textField name="dateTo" value="${dt}"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.search.label', default: '查询')}" />
				</fieldset>
			</g:form>
		</div>
		 -->
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
				<g:each in="${productPricePlanInstanceList}" status="i" var="productPricePlanInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:checkBox name="id" value="${productPricePlanInstance.id}"/></td>
					
						<td><g:link action="show" id="${productPricePlanInstance.id}" target="_blank">${productPricePlanInstance.product.code}</g:link></td>
					
						<td NOWRAP>${productPricePlanInstance.product.name}</td>
					
						<td>${productPricePlanInstance.product.packingCount}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "price")}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "costPrice")}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "retailPrice")}</td>
					
						<td><g:formatDate date="${productPricePlanInstance.activedStartAt}" /></td>
					
						<td><g:formatDate date="${productPricePlanInstance.activedEndAt}" /></td>
					
						<td><g:formatBoolean boolean="${productPricePlanInstance.confirmed}" /></td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "confirmedAt")}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "confirmedBy")}</td>
					
						<td><g:formatBoolean boolean="${productPricePlanInstance.onSale}" /></td>
					
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
