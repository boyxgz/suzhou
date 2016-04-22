<%@ page import="com.surelution.wxmp.jx.SurveyGroup" %>

<div class="fieldcontain ${hasErrors(bean: surveyGroupInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="surveyGroup.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${surveyGroupInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: surveyGroupInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="surveyGroup.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${surveyGroupInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: surveyGroupInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="surveyGroup.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${surveyGroupInstance?.remark}"/>
</div>