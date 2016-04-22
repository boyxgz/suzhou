
<%@ page import="com.surelution.utop.SubscriberChannel" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'subscriberChannel.label', default: 'SubscriberChannel')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-subscriberChannel" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-subscriberChannel" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list subscriberChannel">
			
				<g:if test="${subscriberChannelInstance?.subscriber}">
				<li class="fieldcontain">
					<span id="subscriber-label" class="property-label"><g:message code="subscriberChannel.subscriber.label" default="Subscriber" /></span>
					
						<span class="property-value" aria-labelledby="subscriber-label"><g:link controller="subscriber" action="show" id="${subscriberChannelInstance?.subscriber?.id}">${subscriberChannelInstance?.subscriber?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${subscriberChannelInstance?.channel}">
				<li class="fieldcontain">
					<span id="channel-label" class="property-label"><g:message code="subscriberChannel.channel.label" default="Channel" /></span>
					
						<span class="property-value" aria-labelledby="channel-label"><g:link controller="subscribingChannel" action="show" id="${subscriberChannelInstance?.channel?.id}">${subscriberChannelInstance?.channel?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${subscriberChannelInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="subscriberChannel.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${subscriberChannelInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${subscriberChannelInstance?.id}" />
					<g:link class="edit" action="edit" id="${subscriberChannelInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
