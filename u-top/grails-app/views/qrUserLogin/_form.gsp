<%@ page import="com.surelution.utop.QrUserLogin" %>



<div class="fieldcontain ${hasErrors(bean: qrUserLoginInstance, field: 'dateScanned', 'error')} ">
	<label for="dateScanned">
		<g:message code="qrUserLogin.dateScanned.label" default="Date Scanned" />
		
	</label>
	<g:datePicker name="dateScanned" precision="day"  value="${qrUserLoginInstance?.dateScanned}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: qrUserLoginInstance, field: 'dateConfirmed', 'error')} ">
	<label for="dateConfirmed">
		<g:message code="qrUserLogin.dateConfirmed.label" default="Date Confirmed" />
		
	</label>
	<g:datePicker name="dateConfirmed" precision="day"  value="${qrUserLoginInstance?.dateConfirmed}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: qrUserLoginInstance, field: 'dateLogout', 'error')} ">
	<label for="dateLogout">
		<g:message code="qrUserLogin.dateLogout.label" default="Date Logout" />
		
	</label>
	<g:datePicker name="dateLogout" precision="day"  value="${qrUserLoginInstance?.dateLogout}" default="none" noSelection="['': '']" />
</div>

<div class="fieldcontain ${hasErrors(bean: qrUserLoginInstance, field: 'subscriber', 'error')} ">
	<label for="subscriber">
		<g:message code="qrUserLogin.subscriber.label" default="Subscriber" />
		
	</label>
	<g:select id="subscriber" name="subscriber.id" from="${com.surelution.utop.Subscriber.list()}" optionKey="id" value="${qrUserLoginInstance?.subscriber?.id}" class="many-to-one" noSelection="['null': '']"/>
</div>

<div class="fieldcontain ${hasErrors(bean: qrUserLoginInstance, field: 'qrKey', 'error')} required">
	<label for="qrKey">
		<g:message code="qrUserLogin.qrKey.label" default="Qr Key" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="qrKey" type="number" value="${qrUserLoginInstance.qrKey}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: qrUserLoginInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="qrUserLogin.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.surelution.utop.User.list()}" optionKey="id" required="" value="${qrUserLoginInstance?.user?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: qrUserLoginInstance, field: 'validationCode', 'error')} ">
	<label for="validationCode">
		<g:message code="qrUserLogin.validationCode.label" default="Validation Code" />
		
	</label>
	<g:textField name="validationCode" value="${qrUserLoginInstance?.validationCode}"/>
</div>

