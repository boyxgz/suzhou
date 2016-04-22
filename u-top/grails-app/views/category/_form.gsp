<%@ page import="com.surelution.utop.Category" %>



<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="category.enabled.label" default="Enabled" />
		
	</label>
	<g:checkBox name="enabled" value="${categoryInstance?.enabled}" />
</div>

<div class="fieldcontain ${hasErrors(bean: categoryInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="category.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${categoryInstance?.name}"/>
</div>

