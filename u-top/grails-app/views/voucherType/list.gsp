
<%@ page import="com.surelution.utop.VoucherType" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'voucherType.label', default: 'VoucherType')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-voucherType" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-voucherType" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="description" title="${message(code: 'voucherType.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="key" title="${message(code: 'voucherType.key.label', default: 'Key')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'voucherType.name.label', default: 'Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${voucherTypeInstanceList}" status="i" var="voucherTypeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${voucherTypeInstance.id}">${fieldValue(bean: voucherTypeInstance, field: "description")}</g:link></td>
					
						<td>${fieldValue(bean: voucherTypeInstance, field: "key")}</td>
					
						<td>${fieldValue(bean: voucherTypeInstance, field: "name")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${voucherTypeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
