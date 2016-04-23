
<%@page import="com.surelution.utop.ProductLabel"%>
<%@page import="com.surelution.utop.PricePlanLabel"%>
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
			function addLabel(planId, labelId) {
				$('#operation').val('add');
				$('#planId').val(planId);
				$('#labelId').val(labelId);
				$('#labelMaintainForm').submit();
			}
			function removeLabel(planLabelId) {
				$('#operation').val('remove');
				$('#planLabelId').val(planLabelId);
				$('#labelMaintainForm').submit();
			}
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
			<h1>价格计划</h1>
			<g:form action="availablePlan" name="labelMaintainForm">
			<g:hiddenField name="operation"/>
			<g:hiddenField name="planId"/>
			<g:hiddenField name="labelId"/>
			<g:hiddenField name="planLabelId"/>
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
						 %>
						 <g:textField name="dateFrom" value="${df}"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.search.label', default: '查询')}" />
				</fieldset>
			</g:form>
		</div>
		 <h1>待确认价格计划</h1>
		<div id="list-productPricePlan" class="content scaffold-list" role="main" style="overflow: scroll;">
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="product" title="${message(code: 'product.code.label', default: 'Code')}" />
						
						<th>已入分类</th>

						<th>新增分类</th>
					
						<g:sortableColumn property="product" title="${message(code: 'product.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="product" title="${message(code: 'product.packingCount.label', default: 'Packing<br/>Count')}" />
					
						<g:sortableColumn property="price" title="${message(code: 'productPricePlan.price.label', default: 'Price')}" />
					
						<g:sortableColumn property="costPrice" title="${message(code: 'productPricePlan.costPrice.label', default: 'Cost<br/>Price')}" />
					
						<g:sortableColumn property="retailPrice" title="${message(code: 'productPricePlan.retailPrice.label', default: 'Retail<br/>Price')}" />
					
						<g:sortableColumn property="activedStartAt" title="${message(code: 'productPricePlan.activedStartAt.label', default: 'Actived<br/>Start<br/>At')}" />
					
						<g:sortableColumn property="activedEndAt" title="${message(code: 'productPricePlan.activedEndAt.label', default: 'Actived<br/>End<br/>At')}" />
					
						<g:sortableColumn property="confirmed" title="${message(code: 'productPricePlan.confirmed.label', default: 'Confirmed')}" />
					
						<th><g:message code="productPricePlan.onSale.label" default="OnSale" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:set var="allLabels" value="${ProductLabel.findAllByAvailable(true) }"/>
				<g:each in="${plans}" status="i" var="productPricePlanInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${productPricePlanInstance.id}" target="_blank">${productPricePlanInstance.product.code}</g:link></td>
					
						<td>
							<g:set var="labeled" value="${PricePlanLabel.findAllByPlan(productPricePlanInstance) }"/>
							 <g:each in="${labeled }" var="label">
							 	<a href="javascript:removeLabel('${label.id }')">-${label.label.name }</a><br/>
							 </g:each>
						</td>
						
						<td>
							<g:each in="${allLabels }" var="l">
								<g:if test="${!(labeled.any{it.label.id == l.id}) }"><a href="javascript:addLabel('${productPricePlanInstance.id }', '${l.id }')">+${l.name }</a><br/></g:if>
							</g:each>
						</td>
						
					
						<td NOWRAP>${productPricePlanInstance.product.name}</td>
					
						<td>${productPricePlanInstance.product.packingCount}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "price")}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "costPrice")}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "retailPrice")}</td>
					
						<td><g:formatDate date="${productPricePlanInstance.activedStartAt}" /></td>
					
						<td><g:formatDate date="${productPricePlanInstance.activedEndAt}" /></td>
					
						<td><g:formatBoolean boolean="${productPricePlanInstance.confirmed}" /></td>
					
						<td><g:formatBoolean boolean="${productPricePlanInstance.onSale}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
