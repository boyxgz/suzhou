<%@ page import="com.surelution.utop.QrChannel" %>



<div class="fieldcontain ${hasErrors(bean: qrChannelInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="qrChannel.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${qrChannelInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: qrChannelInstance, field: 'qrNo', 'error')} ">
	<label for="qrNo">
		<g:message code="qrChannel.qrNo.label" default="Qr No" />
		
	</label>
	<g:textField name="qrNo" value="${qrChannelInstance?.qrNo}"/>
</div>

