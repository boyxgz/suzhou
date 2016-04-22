
<%@ page import="com.surelution.wxmp.jx.SubscriberMessage" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'subscriberMessage.label', default: 'SubscriberMessage')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-subscriberMessage" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
			<div id="create-salesOrder" class="scaffold-create" role="main">
			<g:form action="list" >
					<fieldset class="form">
					    <sec:ifAnyGranted roles="ROLE_ADMIN">
					    
						<div class="fieldcontain  ">
							<label for="branch">
								<g:message code="subscriberMessage.toStation.label" default="Station" />
							</label>
							<g:select id="gasStation" name="gasStationId" noSelection="['':'']" from="${com.surelution.wxmp.jx.GasStation.list()}" optionKey="id" optionValue="name" />
						</div>
						</sec:ifAnyGranted>
						<div class="fieldcontain  ">
							<label for="branch">
								<g:message code="subscriberMessage.fromSubscriber.label" default="fromSubscriber" />
							</label>
							<g:textField name="fromSubscriber" value="${params.fromSubscriber}"/>
						</div>
					</fieldset>
					<fieldset class="buttons">
						<g:submitButton name="search" class="search" value="${message(code: 'default.button.search.label', default: 'Search')}" />
					</fieldset>
				</g:form>
		</div>
		<div id="list-subscriberMessage" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th>Id</th>
					
						<th><g:message code="subscriberMessage.fromSubscriber.label" default="From Subscriber" /></th>
						
						<g:sortableColumn property="content" title="${message(code: 'subscriberMessage.content.label', default: 'Content')}"  params="${params}"/>
					
						<g:sortableColumn property="date" title="${message(code: 'subscriberMessage.date.label', default: 'Date')}"  params="${params}"/>
					
						<g:sortableColumn property="isSolved" title="${message(code: 'subscriberMessage.isSolved.label', default: 'Is Solved')}"  params="${params}"/>
					
						<th><g:message code="subscriberMessage.toStation.label" default="To Station" /></th>
						
						
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${subscriberMessageInstanceList}" status="i" var="subscriberMessageInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${subscriberMessageInstance.id}">${fieldValue(bean: subscriberMessageInstance, field: "id")}</g:link></td>
						
						<td>${subscriberMessageInstance?.fromSubscriberName}</td>
						<td>${fieldValue(bean: subscriberMessageInstance, field: "content")}</td>
					
						<td><g:formatDate dateStyle="${subscriberMessageInstance.date}" format="yyyy-MM-dd"/></td>
					
						<td><g:formatBoolean boolean="${subscriberMessageInstance.isSolved}" /></td>
					
						<td>${subscriberMessageInstance?.toStation?.name}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${subscriberMessageInstanceTotal}" params="${params}" />
			</div>
		</div>
	</body>
</html>
