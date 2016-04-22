
<%@ page import="com.surelution.wxmp.jx.SurveyGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'surveyGroup.label', default: 'SurveyGroup')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-surveyGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-surveyGroup" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="title" title="${message(code: 'surveyGroup.title.label', default: 'Title')}" />
					
						<g:sortableColumn property="description" title="${message(code: 'surveyGroup.description.label', default: 'Description')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'surveyGroup.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="remark" title="${message(code: 'surveyGroup.remark.label', default: 'Remark')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${surveyGroupInstanceList}" status="i" var="surveyGroupInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${surveyGroupInstance.id}">${fieldValue(bean: surveyGroupInstance, field: "title")}</g:link></td>
					
						<td>${fieldValue(bean: surveyGroupInstance, field: "remark")}</td>
					
						<td><g:formatDate date="${surveyGroupInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: surveyGroupInstance, field: "description")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${surveyGroupInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
