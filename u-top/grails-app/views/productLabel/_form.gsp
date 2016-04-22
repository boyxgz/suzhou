<%@ page import="com.surelution.utop.ProductLabel" %>



<div class="fieldcontain ${hasErrors(bean: productLabelInstance, field: 'key', 'error')} ">
	<label for="key">
		<g:message code="productLabel.key.label" default="Key" />
		
	</label>
	<g:textField name="key" value="${productLabelInstance?.key}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productLabelInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="productLabel.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${productLabelInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productLabelInstance, field: 'available', 'error')} ">
	<label for="available">
		<g:message code="productLabel.available.label" default="Available" />
		
	</label>
	<g:checkBox name="available" value="${productLabelInstance?.available}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: productLabelInstance, field: 'listInMenu', 'error')} ">
	<label for="listInMenu">
		<g:message code="productLabel.listInMenu.label" default="List In Menu" />
		
	</label>
	<g:checkBox name="listInMenu" value="${productLabelInstance?.listInMenu}"/>
</div>

