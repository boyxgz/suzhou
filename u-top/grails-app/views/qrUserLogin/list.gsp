
<%@ page import="com.surelution.utop.QrUserLogin" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'qrUserLogin.label', default: 'QrUserLogin')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-qrUserLogin" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-qrUserLogin" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="dateScanned" title="${message(code: 'qrUserLogin.dateScanned.label', default: 'Date Scanned')}" />
					
						<g:sortableColumn property="dateConfirmed" title="${message(code: 'qrUserLogin.dateConfirmed.label', default: 'Date Confirmed')}" />
					
						<g:sortableColumn property="dateLogout" title="${message(code: 'qrUserLogin.dateLogout.label', default: 'Date Logout')}" />
					
						<th><g:message code="qrUserLogin.subscriber.label" default="Subscriber" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'qrUserLogin.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="qrKey" title="${message(code: 'qrUserLogin.qrKey.label', default: 'Qr Key')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${qrUserLoginInstanceList}" status="i" var="qrUserLoginInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${qrUserLoginInstance.id}">${fieldValue(bean: qrUserLoginInstance, field: "dateScanned")}</g:link></td>
					
						<td><g:formatDate date="${qrUserLoginInstance.dateConfirmed}" /></td>
					
						<td><g:formatDate date="${qrUserLoginInstance.dateLogout}" /></td>
					
						<td>${fieldValue(bean: qrUserLoginInstance, field: "subscriber")}</td>
					
						<td><g:formatDate date="${qrUserLoginInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: qrUserLoginInstance, field: "qrKey")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${qrUserLoginInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
