
<%@ page import="com.surelution.utop.Imprest" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'imprest.label', default: 'Imprest')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-imprest" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-imprest" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list imprest">
			
				<g:if test="${imprestInstance?.transactionNo}">
				<li class="fieldcontain">
					<span id="transactionNo-label" class="property-label"><g:message code="imprest.transactionNo.label" default="Transaction No" /></span>
					
						<span class="property-value" aria-labelledby="transactionNo-label"><g:fieldValue bean="${imprestInstance}" field="transactionNo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${imprestInstance?.amount}">
				<li class="fieldcontain">
					<span id="amount-label" class="property-label"><g:message code="imprest.amount.label" default="Amount" /></span>
					
						<span class="property-value" aria-labelledby="amount-label"><g:fieldValue bean="${imprestInstance}" field="amount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${imprestInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="imprest.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${imprestInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${imprestInstance?.transferDate}">
				<li class="fieldcontain">
					<span id="transferDate-label" class="property-label"><g:message code="imprest.transferDate.label" default="Transfer Date" /></span>
					
						<span class="property-value" aria-labelledby="transferDate-label"><g:formatDate date="${imprestInstance?.transferDate}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${imprestInstance?.id}" />
					<g:link class="edit" action="edit" id="${imprestInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
