
<%@ page import="com.surelution.utop.Product" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-product" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-product" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'product.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="spec" title="${message(code: 'product.spec.label', default: 'Spec')}" />
					
						<g:sortableColumn property="exercisePrice" title="${message(code: 'product.exercisePrice.label', default: 'Exercise Price')}" />
					
						<g:sortableColumn property="extroInfo" title="${message(code: 'product.extroInfo.label', default: 'Extro Info')}" />
					
						<g:sortableColumn property="reason" title="${message(code: 'product.reason.label', default: 'Reason')}" />
					
						<th><g:message code="product.category.label" default="Category" /></th>
					
						<th><g:message code="product.index.label" default="Index" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${productInstanceList}" status="i" var="productInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${productInstance.id}">${fieldValue(bean: productInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: productInstance, field: "spec")}</td>
					
						<td>${fieldValue(bean: productInstance, field: "exercisePrice")}</td>
					
						<td>${fieldValue(bean: productInstance, field: "extroInfo")}</td>
					
						<td>${fieldValue(bean: productInstance, field: "reason")}</td>
					
						<td>${fieldValue(bean: productInstance, field: "category.name")}</td>
					
						<td>${fieldValue(bean: productInstance, field: "index")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${productInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
