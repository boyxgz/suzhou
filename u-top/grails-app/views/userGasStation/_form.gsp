<%@ page import="com.surelution.wxmp.jx.UserGasStation" %>



<div class="fieldcontain ${hasErrors(bean: userGasStationInstance, field: 'gasStation', 'error')} required">
	<label for="gasStation">
		<g:message code="gasStation.label" default="Gas Station" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="gasStation" name="gasStation.id" from="${com.surelution.wxmp.jx.GasStation.list()}" optionKey="id" optionValue="name" required="" value="${userGasStationInstance?.gasStation?.id}" class="many-to-one"/>
</div>

<%--<div class="fieldcontain ${hasErrors(bean: userGasStationInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="userGasStation.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.surelution.wxmp.jx.User.list()}" optionKey="id" required="" value="${userGasStationInstance?.user?.id}" class="many-to-one"/>
</div>

--%>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${userInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="password" required="" value="${userInstance?.password}"/>
</div>
