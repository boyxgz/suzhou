<%@ page import="com.surelution.utop.ProductPricePlan" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'productPricePlan.label', default: 'ProductPricePlan')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<script type="text/javascript" src="${resource(file:'js/jquery-1.9.1.min.js') }"></script>
		<link href="${resource(dir:'css/jquery.datetimepicker.css')}" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${resource(file:'js/jquery.datetimepicker.js') }"></script>
		<script type="text/javascript">
			$( document ).ready(function() {
				$('#activedStartAt').datetimepicker({
					dayOfWeekStart : 1,
					lang:'ch',
					format:'Y-m-d H:i'
					});
				$('#activedStartAt').datetimepicker({step:10});
			});
			$( document ).ready(function() {
				$('#activedEndAt').datetimepicker({
					dayOfWeekStart : 1,
					lang:'ch',
					format:'Y-m-d H:i'
					});
				$('#activedEndAt').datetimepicker({step:10});
			});
		</script>
	</head>
	<body>
		<a href="#edit-productPricePlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-productPricePlan" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${productPricePlanInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${productPricePlanInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${productPricePlanInstance?.id}" />
				<g:hiddenField name="version" value="${productPricePlanInstance?.version}" />
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
					
					<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'activedStartAt', 'error')} required">
						<label for="activedStartAt">
							<g:message code="productPricePlan.activedStartAt.label" default="Actived Start At" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField name="activedStartAt" value="${productPricePlanInstance?.activedStartAt?.format('yyyy-MM-dd HH:mm')}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'activedEndAt', 'error')} required">
						<label for="activedEndAt">
							<g:message code="productPricePlan.activedEndAt.label" default="Actived End At" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField name="activedEndAt" value="${productPricePlanInstance?.activedEndAt?.format('yyyy-MM-dd HH:mm')}"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'costPrice', 'error')} required">
						<label for="costPrice">
							<g:message code="productPricePlan.costPrice.label" default="Cost Price" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="costPrice" value="${fieldValue(bean: productPricePlanInstance, field: 'costPrice')}" required=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'retailPrice', 'error')} required">
						<label for="retailPrice">
							<g:message code="productPricePlan.retailPrice.label" default="Retail Price" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="retailPrice" value="${fieldValue(bean: productPricePlanInstance, field: 'retailPrice')}" required=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'onSale', 'error')} ">
						<label for="onSale">
							<g:message code="productPricePlan.onSale.label" default="On Sale" />
							
						</label>
						<g:checkBox name="onSale" value="${productPricePlanInstance?.onSale}" />
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'price', 'error')} required">
						<label for="price">
							<g:message code="productPricePlan.price.label" default="Price" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="price" value="${fieldValue(bean: productPricePlanInstance, field: 'price')}" required=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: productPricePlanInstance, field: 'product', 'error')} required">
						<label for="product">
							<g:message code="productPricePlan.product.label" default="Product" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="product" name="product.id" from="${com.surelution.utop.Product.list()}" optionKey="id" optionValue="${{it.name + " X " + it.packingCount + "，货号为：" + it.code} }" required="" value="${productPricePlanInstance?.product?.id}" class="many-to-one"/>
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
