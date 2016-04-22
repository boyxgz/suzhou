<%@ page import="com.surelution.utop.VoucherType" %>



<div class="fieldcontain ${hasErrors(bean: voucherTypeInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="voucherType.description.label" default="Description" />
		
	</label>
	<g:textField name="description" value="${voucherTypeInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: voucherTypeInstance, field: 'key', 'error')} ">
	<label for="key">
		<g:message code="voucherType.key.label" default="Key" />
		
	</label>
	<g:textField name="key" value="${voucherTypeInstance?.key}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: voucherTypeInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="voucherType.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${voucherTypeInstance?.name}"/>
</div>

