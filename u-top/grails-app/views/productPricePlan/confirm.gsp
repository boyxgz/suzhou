
<%@ page import="com.surelution.utop.ProductPricePlan" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
	</head>
	<body>
		<div>
		<p align="center" style="font-size: 2em">价格执行计划单</p>
		</div>
			<table>
				<thead>
					<tr>
					
						<th>序号</th>
					
						<th>${message(code: 'product.code.label', default: 'Code')}</th>
					
						<th>${message(code: 'product.name.label', default: 'Name')}</th>
					
						<th>${message(code: 'product.packingCount.label', default: 'Packing<br/>Count')}</th>
					
						<th>${message(code: 'productPricePlan.price.label', default: 'Price')}</th>
					
						<th>${message(code: 'productPricePlan.costPrice.label', default: 'Cost<br/>Price')}</th>
					
						<th>${message(code: 'productPricePlan.retailPrice.label', default: 'Retail<br/>Price')}</th>

						<th>${message(code: 'productPricePlan.activedStartAt.label', default: 'Actived<br/>End<br/>At')}</th>
					
						<th>${message(code: 'productPricePlan.activedEndAt.label', default: 'Actived<br/>End<br/>At')}</th>
					</tr>
				</thead>
				<tbody>
				<g:each in="${productPricePlanInstanceList}" status="i" var="productPricePlanInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${i + 1}</td>
					
						<td>${productPricePlanInstance.product.code}</td>
					
						<td width="200">${productPricePlanInstance.product.name}</td>
					
						<td>${productPricePlanInstance.product.packingCount}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "price")}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "costPrice")}</td>
					
						<td>${fieldValue(bean: productPricePlanInstance, field: "retailPrice")}</td>
					
						<td><g:formatDate date="${productPricePlanInstance.activedStartAt}" /></td>
					
						<td><g:formatDate date="${productPricePlanInstance.activedEndAt}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<table>
				<tr>
					<td>制表时间：<g:formatDate date="${new Date() }" format="yyyy-MM-dd"/></td>
					<td>制单员：${operator.username }</td>
					<td>确认人签字：</td>
					<td width="300">&nbsp;</td>
				</tr>
			</table>
	</body>
</html>
