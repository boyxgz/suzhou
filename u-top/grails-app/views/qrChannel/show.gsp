
<%@ page import="com.surelution.utop.QrChannel" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'qrChannel.label', default: 'QrChannel')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-qrChannel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-qrChannel" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list qrChannel">
			
				<g:if test="${qrChannelInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="qrChannel.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${qrChannelInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${qrChannelInstance?.qrNo}">
				<li class="fieldcontain">
					<span id="qrNo-label" class="property-label"><g:message code="qrChannel.qrNo.label" default="Qr No" /></span>
					
						<span class="property-value" aria-labelledby="qrNo-label"><g:fieldValue bean="${qrChannelInstance}" field="qrNo"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${qrChannelInstance?.id}" />
					<g:link class="edit" action="edit" id="${qrChannelInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
