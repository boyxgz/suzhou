<%@ page import="com.surelution.utop.Station" %>



<div class="fieldcontain ${hasErrors(bean: stationInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="station.address.label" default="Address" />
		
	</label>
	<g:textField name="address" value="${stationInstance?.address}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stationInstance, field: 'enabled', 'error')} ">
	<label for="enabled">
		<g:message code="station.enabled.label" default="Enabled" />
		
	</label>
	<g:checkBox name="enabled" value="${stationInstance?.enabled}" />
</div>

<div class="fieldcontain ${hasErrors(bean: stationInstance, field: 'latitude', 'error')} required">
	<label for="latitude">
		<g:message code="station.latitude.label" default="Latitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="latitude" value="${fieldValue(bean: stationInstance, field: 'latitude')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: stationInstance, field: 'longitude', 'error')} required">
	<label for="longitude">
		<g:message code="station.longitude.label" default="Longitude" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="longitude" value="${fieldValue(bean: stationInstance, field: 'longitude')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: stationInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="station.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${stationInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: stationInstance, field: 'tel', 'error')} ">
	<label for="tel">
		<g:message code="station.tel.label" default="Tel" />
		
	</label>
	<g:textField name="tel" value="${stationInstance?.tel}"/>
</div>

