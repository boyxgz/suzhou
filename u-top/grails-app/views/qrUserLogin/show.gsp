
<%@ page import="com.surelution.utop.QrUserLogin" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'qrUserLogin.label', default: 'QrUserLogin')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-qrUserLogin" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-qrUserLogin" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list qrUserLogin">
			
				<g:if test="${qrUserLoginInstance?.dateScanned}">
				<li class="fieldcontain">
					<span id="dateScanned-label" class="property-label"><g:message code="qrUserLogin.dateScanned.label" default="Date Scanned" /></span>
					
						<span class="property-value" aria-labelledby="dateScanned-label"><g:formatDate date="${qrUserLoginInstance?.dateScanned}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${qrUserLoginInstance?.dateConfirmed}">
				<li class="fieldcontain">
					<span id="dateConfirmed-label" class="property-label"><g:message code="qrUserLogin.dateConfirmed.label" default="Date Confirmed" /></span>
					
						<span class="property-value" aria-labelledby="dateConfirmed-label"><g:formatDate date="${qrUserLoginInstance?.dateConfirmed}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${qrUserLoginInstance?.dateLogout}">
				<li class="fieldcontain">
					<span id="dateLogout-label" class="property-label"><g:message code="qrUserLogin.dateLogout.label" default="Date Logout" /></span>
					
						<span class="property-value" aria-labelledby="dateLogout-label"><g:formatDate date="${qrUserLoginInstance?.dateLogout}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${qrUserLoginInstance?.subscriber}">
				<li class="fieldcontain">
					<span id="subscriber-label" class="property-label"><g:message code="qrUserLogin.subscriber.label" default="Subscriber" /></span>
					
						<span class="property-value" aria-labelledby="subscriber-label"><g:link controller="subscriber" action="show" id="${qrUserLoginInstance?.subscriber?.id}">${qrUserLoginInstance?.subscriber?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${qrUserLoginInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="qrUserLogin.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${qrUserLoginInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${qrUserLoginInstance?.qrKey}">
				<li class="fieldcontain">
					<span id="qrKey-label" class="property-label"><g:message code="qrUserLogin.qrKey.label" default="Qr Key" /></span>
					
						<span class="property-value" aria-labelledby="qrKey-label"><g:fieldValue bean="${qrUserLoginInstance}" field="qrKey"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${qrUserLoginInstance?.user}">
				<li class="fieldcontain">
					<span id="user-label" class="property-label"><g:message code="qrUserLogin.user.label" default="User" /></span>
					
						<span class="property-value" aria-labelledby="user-label"><g:link controller="user" action="show" id="${qrUserLoginInstance?.user?.id}">${qrUserLoginInstance?.user?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${qrUserLoginInstance?.validationCode}">
				<li class="fieldcontain">
					<span id="validationCode-label" class="property-label"><g:message code="qrUserLogin.validationCode.label" default="Validation Code" /></span>
					
						<span class="property-value" aria-labelledby="validationCode-label"><g:fieldValue bean="${qrUserLoginInstance}" field="validationCode"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${qrUserLoginInstance?.id}" />
					<g:link class="edit" action="edit" id="${qrUserLoginInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
