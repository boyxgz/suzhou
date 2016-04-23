<%@ page import="com.surelution.utop.ShelfProductPricePlan" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'shelfProductPricePlan.label', default: 'ShelfProductPricePlan')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
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
		<a href="#create-shelfProductPricePlan" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="shelfProductPricePlan.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-shelfProductPricePlan" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${shelfProductPricePlanInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${shelfProductPricePlanInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form action="save" >
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
					<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'activedStartAt', 'error')} required">
						<label for="activedStartAt">
							<g:message code="shelfProductPricePlan.activedStartAt.label" default="Actived Start At" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField name="activedStartAt" value="${df }" id="activedStartAt"/>
					</div>
					<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'activedEndAt', 'error')} required">
						<label for="activedEndAt">
							<g:message code="shelfProductPricePlan.activedEndAt.label" default="Actived End At" />
							<span class="required-indicator">*</span>
						</label>
						<g:textField name="activedEndAt" value="${dt }"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'costPrice', 'error')} required">
						<label for="costPrice">
							<g:message code="shelfProductPricePlan.costPrice.label" default="Cost Price" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="costPrice" value="${fieldValue(bean: shelfProductPricePlanInstance, field: 'costPrice')}" required=""/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'retailPrice', 'error')} required">
						<label for="retailPrice">
							<g:message code="shelfProductPricePlan.retailPrice.label" default="Retail Price" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="retailPrice" value="${fieldValue(bean: shelfProductPricePlanInstance, field: 'retailPrice')}" required="required"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'onSale', 'error')} ">
						<label for="onSale">
							<g:message code="shelfProductPricePlan.onSale.label" default="On Sale" />
							
						</label>
						<g:checkBox name="onSale" value="${shelfProductPricePlanInstance?.onSale}" />
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'price', 'error')} required">
						<label for="price">
							<g:message code="shelfProductPricePlan.price.label" default="Price" />
							<span class="required-indicator">*</span>
						</label>
						<g:field name="price" value="${fieldValue(bean: shelfProductPricePlanInstance, field: 'price')}" required="required"/>
					</div>
					
					<div class="fieldcontain ${hasErrors(bean: shelfProductPricePlanInstance, field: 'product', 'error')} required">
						<label for="product">
							<g:message code="shelfProductPricePlan.product.label" default="Product" />
							<span class="required-indicator">*</span>
						</label>
						<g:select id="product" name="product.id" from="${com.surelution.utop.Product.list()}" optionKey="id" optionValue="${{it.name + " X " + it.packingCount + "，货号为：" + it.code} }" required="" value="${shelfProductPricePlanInstance?.product?.id}" class="many-to-one"/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
