
<%@ page import="com.surelution.wxmp.jx.Survey" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'survey.label', default: 'Survey')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-survey" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-survey" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list survey">
			<g:set var="surveyGroupInstance" value="${surveyInstance.group }"></g:set>
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
				
				
				
				
				
			
				<g:if test="${surveyInstance?.title}">
				<li class="fieldcontain">
					<span id="title-label" class="property-label"><g:message code="survey.title.label" default="Title" /></span>
					
						<span class="property-value" aria-labelledby="title-label"><g:fieldValue bean="${surveyInstance}" field="title"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${surveyInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="survey.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${surveyInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${surveyInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="property-label"><g:message code="survey.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${surveyInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${surveyInstance?.acceptComment}">
				<li class="fieldcontain">
					<span id="acceptComment-label" class="property-label"><g:message code="survey.acceptComment.label" default="Accept Comment" /></span>
					
						<span class="property-value" aria-labelledby="acceptComment-label"><g:formatBoolean boolean="${surveyInstance?.acceptComment}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${surveyInstance?.single}">
				<li class="fieldcontain">
					<span id="single-label" class="property-label"><g:message code="survey.single.label" default="Single" /></span>
					
						<span class="property-value" aria-labelledby="single-label"><g:formatBoolean boolean="${surveyInstance?.single}" /></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
			<g:if test="${surveyItems }">
			<table>
				<thead>
					<tr>
					<td><g:message code="surveyItem.content.label" default="Content" /></td>
					<td>操作</td>
					</tr>
				</thead>
				<g:each in="${surveyItems }" var="surveyItem">
					<tr>
						<td>${surveyItem.content }</td>
						<td><a href="${createLink(action:'deleteItem', controller:'survey', id:surveyItem.id) }">删除</a></td>
					</tr>
				</g:each>
			</table>
			</g:if>
				<fieldset class="form">
					<div class="fieldcontain">
						<label for="content">
							<g:message code="surveyItem.content.label" default="Content" />
							
						</label>
						<g:textField name="content" />
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${surveyInstance?.id}" />
					<g:actionSubmit class="save" action="addItem" value="${message(code: 'survey.add.item.label', default: 'Add Item')}"/>
					<g:link class="edit" action="edit" id="${surveyInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					<g:link class="edit" action="create" id="${surveyInstance?.group?.id}">添加调查内容</g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
