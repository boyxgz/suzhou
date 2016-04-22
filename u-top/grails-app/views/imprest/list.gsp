
<%@ page import="com.surelution.utop.Imprest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'imprest.label', default: 'Imprest')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-imprest" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-imprest" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="transactionNo" title="${message(code: 'imprest.transactionNo.label', default: 'Transaction No')}" />
					
						<g:sortableColumn property="amount" title="${message(code: 'imprest.amount.label', default: 'Amount')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'imprest.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="transferDate" title="${message(code: 'imprest.transferDate.label', default: 'Transfer Date')}" />
					
						<g:sortableColumn property="confirmedAt" title="${message(code: 'imprest.confirmedAt.label', default: 'Confirmed At')}" />
					
						<g:sortableColumn property="confirmedBy" title="${message(code: 'imprest.confirmedBy.label', default: 'Confirmed By')}" />
					
						<g:sortableColumn property="confirmed" title="${message(code: 'imprest.confirmed.label', default: 'Confirmed')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${imprestInstanceList}" status="i" var="imprestInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<g:if test="${imprestInstance.confirmed}">
							<td>${fieldValue(bean: imprestInstance, field: "transactionNo")}</td>
						</g:if>
						<g:else>
							<td><g:link action="show" id="${imprestInstance.id}">${fieldValue(bean: imprestInstance, field: "transactionNo")}</g:link></td>
						</g:else>
					
						<td>${fieldValue(bean: imprestInstance, field: "amount")}</td>
					
						<td><g:formatDate date="${imprestInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${imprestInstance.transferDate}" /></td>
					
						<td><g:formatDate date="${imprestInstance.confirmedAt}" /></td>
					
						<td>${imprestInstance.confirmedBy?.username}</td>
						
						<td><g:formatBoolean boolean="${imprestInstance.confirmed}"/></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${imprestInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
