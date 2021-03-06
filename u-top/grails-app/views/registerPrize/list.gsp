
<%@ page import="com.surelution.wxmp.jx.RegisterPrize" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'registerPrize.label', default: 'RegisterPrize')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-registerPrize" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-registerPrize" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="registerPrize.awardedBy.label" default="Awarded By" /></th>
					
						<th><g:message code="registerPrize.awardedAt.label" default="Awarded At" /></th>
					
						<th><g:message code="registerPrize.subscriber.label" default="Subscriber" /></th>
					
						<g:sortableColumn property="createAt" title="${message(code: 'registerPrize.createAt.label', default: 'Create At')}" />
					
						<th><g:message code="registerPrize.prize.label" default="Prize" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${registerPrizeInstanceList}" status="i" var="registerPrizeInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${registerPrizeInstance.id}">${fieldValue(bean: registerPrizeInstance, field: "awardedBy")}</g:link></td>
					
						<td>${fieldValue(bean: registerPrizeInstance, field: "awardedAt")}</td>
					
						<td>${fieldValue(bean: registerPrizeInstance, field: "subscriber")}</td>
					
						<td><g:formatDate date="${registerPrizeInstance.createAt}" /></td>
					
						<td>${fieldValue(bean: registerPrizeInstance, field: "prize")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${registerPrizeInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
