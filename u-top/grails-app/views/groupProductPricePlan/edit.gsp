<%@ page import="com.surelution.utop.GroupProductPricePlan" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'groupProductPricePlan.label', default: 'GroupProductPricePlan')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-groupProductPricePlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="groupProductPricePlan.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="groupProductPricePlan.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-groupProductPricePlan" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${groupProductPricePlanInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${groupProductPricePlanInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${groupProductPricePlanInstance?.id}" />
				<g:hiddenField name="version" value="${groupProductPricePlanInstance?.version}" />
				<fieldset class="form">
					<%
						def df = params.activedStartAt
						def sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm")
						if(!df) {
							def f = new Date().clearTime()
							f.setDate(f.getDate() - 1)
							f.setHours(16)
							df = sdf.format(f)
						}
						def dt = params.activedEndAt
						if(!dt) {
							def t = new Date().clearTime()
							t.setHours(16)
							dt = sdf.format(t)
						}
					 %>
					
					<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'activedStartAt', 'error')} required">
						<label for="activedStartAt">
							<g:message code="groupProductPricePlan.activedStartAt.label" default="Actived Start At" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField name="activedStartAt" value="${groupProductPricePlanInstance?.activedStartAt?.format('yyyy-MM-dd HH:mm')}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'activedEndAt', 'error')} required">
						<label for="activedEndAt">
							<g:message code="groupProductPricePlan.activedEndAt.label" default="Actived End At" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField name="activedEndAt" value="${groupProductPricePlanInstance?.activedEndAt?.format('yyyy-MM-dd HH:mm')}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'costPrice', 'error')} required">
						<label for="costPrice">
							<g:message code="groupProductPricePlan.costPrice.label" default="Cost Price" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="costPrice" type="" value="${fieldValue(bean: groupProductPricePlanInstance, field: 'costPrice')}" required=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'retailPrice', 'error')} required">
						<label for="retailPrice">
							<g:message code="groupProductPricePlan.retailPrice.label" default="Retail Price" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="retailPrice" type="" value="${fieldValue(bean: groupProductPricePlanInstance, field: 'retailPrice')}" required=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'onSale', 'error')} ">
						<label for="onSale">
							<g:message code="groupProductPricePlan.onSale.label" default="On Sale" />
							
						</label>
						<g:checkBox name="onSale" value="${groupProductPricePlanInstance?.onSale}" />
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: groupProductPricePlanInstance, field: 'product', 'error')} required">
						<label for="product">
							<g:message code="groupProductPricePlan.product.label" default="Product" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="product" name="product.id" from="${com.surelution.utop.Product.list()}" optionKey="id" optionValue="${{it.name + " X " + it.packingCount + "，货号为：" + it.code} }" required="" value="${groupProductPricePlanInstance?.product?.id}" class="many-to-one"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
