<%@ page import="com.surelution.wxmp.jx.Survey" %>
<%@ page import="com.surelution.wxmp.jx.SurveyItem" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'survey.label', default: 'Survey')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#create-survey" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-survey" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${surveyInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${surveyInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			
			<g:set var="surveyGroupInstance" value="${surveyInstance.group }"></g:set>
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
			
			<g:each in="${surveys }" var="s">
				<li class="fieldcontain">
					<span class="property-label">${s.title }</span>
					<span class="property-value">[<g:each in="${SurveyItem.findAllBySurvey(s) }" var="si">${si.content },</g:each>]</span>
					
				</li>
			</g:each>
			
			</ol>
			<g:form action="save" >
			<g:hiddenField name="group.id" value="${surveyInstance.group.id }"/>
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
