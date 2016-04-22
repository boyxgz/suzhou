
<%@ page import="com.surelution.wxmp.jx.MultiNewsMessage" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'multiNewsMessage.label', default: 'MultiNewsMessage')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-multiNewsMessage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-multiNewsMessage" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="inputMessage" title="${message(code: 'multiNewsMessage.inputMessage.label', default: 'Input Message')}" />
					
						<g:sortableColumn property="menuKey" title="${message(code: 'multiNewsMessage.menuKey.label', default: 'Menu Key')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'multiNewsMessage.description.label', default: 'Description')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${multiNewsMessageInstanceList}" status="i" var="multiNewsMessageInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${multiNewsMessageInstance.id}">${fieldValue(bean: multiNewsMessageInstance, field: "inputMessage")}</g:link></td>
					
						<td>${fieldValue(bean: multiNewsMessageInstance, field: "menuKey")}</td>
					
						<td>${fieldValue(bean: multiNewsMessageInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${multiNewsMessageInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
