<%@ page import="com.surelution.wxmp.jx.Survey" %>



<div class="fieldcontain ${hasErrors(bean: surveyInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="survey.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${surveyInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: surveyInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="survey.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${surveyInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: surveyInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="survey.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${surveyInstance?.remark}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: surveyInstance, field: 'single', 'error')} ">
	<label for="single">
		<g:message code="survey.single.label" default="Single" />
		
	</label>
	<g:checkBox name="single" value="${surveyInstance?.single}" />
</div>

<div class="fieldcontain ${hasErrors(bean: surveyInstance, field: 'acceptComment', 'error')} ">
	<label for="acceptComment">
		<g:message code="survey.acceptComment.label" default="Accept Comment" />
		
	</label>
	<g:checkBox name="acceptComment" value="${surveyInstance?.acceptComment}" />
</div>

<div class="fieldcontain ${hasErrors(bean: surveyInstance, field: 'index', 'error')} ">
	<label for="index">
		<g:message code="survey.index.label" default="Index" />
		
	</label>
	<g:textField name="index" type="number" value="${surveyInstance?.index}"/>
</div>

