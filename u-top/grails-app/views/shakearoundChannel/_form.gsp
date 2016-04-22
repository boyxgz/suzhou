<%@ page import="com.surelution.utop.ShakearoundChannel" %>



<div class="fieldcontain ${hasErrors(bean: shakearoundChannelInstance, field: 'major', 'error')} ">
	<label for="major">
		<g:message code="shakearoundChannel.major.label" default="Major" />
		
	</label>
	<g:textField name="major" value="${shakearoundChannelInstance?.major}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shakearoundChannelInstance, field: 'minor', 'error')} ">
	<label for="minor">
		<g:message code="shakearoundChannel.minor.label" default="Minor" />
		
	</label>
	<g:textField name="minor" value="${shakearoundChannelInstance?.minor}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shakearoundChannelInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="shakearoundChannel.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${shakearoundChannelInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: shakearoundChannelInstance, field: 'uuid', 'error')} ">
	<label for="uuid">
		<g:message code="shakearoundChannel.uuid.label" default="Uuid" />
		
	</label>
	<g:textField name="uuid" value="${shakearoundChannelInstance?.uuid}"/>
</div>

