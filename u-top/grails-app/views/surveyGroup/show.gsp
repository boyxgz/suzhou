
<%@ page import="com.surelution.wxmp.jx.SurveyGroup" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'surveyGroup.label', default: 'SurveyGroup')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-surveyGroup" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-surveyGroup" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list surveyGroup">
			
				<g:if test="${surveyGroupInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="surveyGroup.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${surveyGroupInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${surveyGroupInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="surveyGroup.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${surveyGroupInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${surveyGroupInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="property-label"><g:message code="surveyGroup.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${surveyGroupInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${surveyGroupInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="surveyGroup.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${surveyGroupInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${surveyGroupInstance?.id}" />
					<g:link class="edit" action="create" controller="survey" id="${surveyGroupInstance?.id}">添加选项</g:link>
					<g:link class="edit" action="edit" id="${surveyGroupInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					<g:link class="edit" action="configCurrent" controller="surveyGroup" id="${surveyGroupInstance?.id}"><g:message code="survey.make.current.label" default="Enable" /></g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
