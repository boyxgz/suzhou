
<%@ page import="com.surelution.utop.Imprest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'imprest.label', default: 'Imprest')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<script type="text/javascript">
			function confirmImprest(imprestId) {
				if(confirm("您确定这笔资金已经入账吗？")) {
					document.location.href="${createLink(controller:'imprest', action:'confirm')}/" + imprestId;
				}
			}
		</script>
	</head>
	<body>
		<a href="#list-imprest" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
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
					
						<th>操作</th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${imprestInstanceList}" status="i" var="imprestInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td>${fieldValue(bean: imprestInstance, field: "transactionNo")}</td>
					
						<td>${fieldValue(bean: imprestInstance, field: "amount")}</td>
					
						<td><g:formatDate date="${imprestInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${imprestInstance.transferDate}" /></td>
					
						<td>
						<g:if test="${!imprestInstance.confirmed}">
						<a href="javascript:confirmImprest('${imprestInstance.id}')">确认</a>
						</g:if>
						<g:else>
							已确认
						</g:else>
						</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
