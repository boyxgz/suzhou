
<%@page import="com.surelution.whistle.push.UserInfo"%>
<%@ page import="com.surelution.wxmp.jx.SubscriberMessage" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'subscriberMessage.label', default: 'SubscriberMessage')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-subscriberMessage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-subscriberMessage" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list subscriberMessage">
			
				<g:if test="${subscriberMessageInstance?.content}">
				<li class="fieldcontain">
					<span id="content-label" class="property-label"><g:message code="subscriberMessage.content.label" default="Content" /></span>
					
						<span class="property-value" aria-labelledby="content-label"><g:fieldValue bean="${subscriberMessageInstance}" field="content"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${subscriberMessageInstance?.date}">
				<li class="fieldcontain">
					<span id="date-label" class="property-label"><g:message code="subscriberMessage.date.label" default="Date" /></span>
					
						<span class="property-value" aria-labelledby="date-label"><g:formatDate date="${subscriberMessageInstance?.date}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${subscriberMessageInstance?.fromSubscriber}">
				<li class="fieldcontain">
					<span id="fromSubscriber-label" class="property-label"><g:message code="subscriberMessage.fromSubscriber.label" default="From Subscriber" /></span>
						<span class="property-value" aria-labelledby="fromSubscriber-label">${UserInfo.loadUserInfo(subscriberMessageInstance?.fromSubscriber.openId).nickname}</span>
					
				</li>
				</g:if>
			
				<g:if test="${subscriberMessageInstance?.isSolved}">
				<li class="fieldcontain">
					<span id="isSolved-label" class="property-label"><g:message code="subscriberMessage.isSolved.label" default="Is Solved" /></span>
					
						<span class="property-value" aria-labelledby="isSolved-label"><g:formatBoolean boolean="${subscriberMessageInstance?.isSolved}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${subscriberMessageInstance?.toStation}">
				<li class="fieldcontain">
					<span id="toStation-label" class="property-label"><g:message code="subscriberMessage.toStation.label" default="To Station" /></span>
					
						<span class="property-value" aria-labelledby="toStation-label">${subscriberMessageInstance?.toStation?.name}</span>
					
				</li>
				</g:if>
				
				<table>
				    <thead>
						<tr>
						  <th>加油站</th>
						  <th>回复者</th>
						  <th>回复内容</th>
						</tr>
					</thead>
					<tbody>
						
					<g:each in="${userMsg}" var="msg">
						<tr>
						  <th>${msg?.fromUser?.gasStation?.name}</th>
						  <th>${msg?.fromUser?.user?.username}</th>
						  <th>${msg?.content}</th>
						</tr>
					</g:each>
					
					</tbody>
				
				</table>
			
			
			</ol>
			<g:form>
			  <g:textArea name="message"  style="width:50%;"></g:textArea>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${subscriberMessageInstance?.id}" />
					<g:actionSubmit class="edit" action="sendUserMsg" value="回复" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
