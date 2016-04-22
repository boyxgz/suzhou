<%@ page import="com.surelution.utop.AdPageShoppingChannel" %>



<div class="fieldcontain ${hasErrors(bean: adPageShoppingChannelInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="adPageShoppingChannel.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${adPageShoppingChannelInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: adPageShoppingChannelInstance, field: 'station', 'error')} required">
	<label for="station">
		<g:message code="adPageShoppingChannel.station.label" default="Station" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="station" name="station.id" from="${com.surelution.utop.Station.list()}" optionValue="name" optionKey="id" required="" value="${adPageShoppingChannelInstance?.station?.id}" class="many-to-one"/>
</div>

