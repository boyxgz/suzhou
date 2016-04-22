
<%@ page import="com.surelution.wxmp.jx.UserGasStation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userGasStation.label', default: 'UserGasStation')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-userGasStation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-userGasStation" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						
						<th><g:message code="userGasStation.gasStation.label" default="Gas Station" /></th>
					
						<th><g:message code="user.username.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${userGasStationInstanceList}" status="i" var="userGasStationInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${userGasStationInstance?.gasStation?.name}</td>
					
						<td>${userGasStationInstance?.user?.username}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${userGasStationInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
