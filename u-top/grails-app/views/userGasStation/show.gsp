
<%@ page import="com.surelution.wxmp.jx.UserGasStation" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'userGasStation.label', default: 'UserGasStation')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-userGasStation" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-userGasStation" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list userGasStation">
			
				<g:if test="${userGasStationInstance?.gasStation}">
				<li class="fieldcontain">
					<span id="gasStation-label" class="property-label"><g:message code="userGasStation.gasStation.label" default="Gas Station" /></span>
					
						<span class="property-value" aria-labelledby="gasStation-label">${userGasStationInstance?.gasStation?.name}</span>
					
				</li>
				</g:if>
			
				<g:if test="${userGasStationInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="user.username.label" default="User" /></span>
					
					<span class="property-value" aria-labelledby="user-label">${userGasStationInstance?.user?.username}</span>
					
				</li>
				</g:if>
			
			</ol>
		</div>
	</body>
</html>
