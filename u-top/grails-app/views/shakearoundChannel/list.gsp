
<%@ page import="com.surelution.utop.ShakearoundChannel" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'shakearoundChannel.label', default: 'ShakearoundChannel')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-shakearoundChannel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-shakearoundChannel" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="major" title="${message(code: 'shakearoundChannel.major.label', default: 'Major')}" />
					
						<g:sortableColumn property="minor" title="${message(code: 'shakearoundChannel.minor.label', default: 'Minor')}" />
					
						<g:sortableColumn property="name" title="${message(code: 'shakearoundChannel.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="uuid" title="${message(code: 'shakearoundChannel.uuid.label', default: 'Uuid')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${shakearoundChannelInstanceList}" status="i" var="shakearoundChannelInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${shakearoundChannelInstance.id}">${fieldValue(bean: shakearoundChannelInstance, field: "major")}</g:link></td>
					
						<td>${fieldValue(bean: shakearoundChannelInstance, field: "minor")}</td>
					
						<td>${fieldValue(bean: shakearoundChannelInstance, field: "name")}</td>
					
						<td>${fieldValue(bean: shakearoundChannelInstance, field: "uuid")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${shakearoundChannelInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
