
<%@ page import="com.surelution.utop.Product" %>
<%@ page import="com.surelution.utop.ProductPicture" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'product.label', default: 'Product')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-product" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-product" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list product">
			
				<g:if test="${productInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="product.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${productInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.spec}">
				<li class="fieldcontain">
					<span id="spec-label" class="property-label"><g:message code="product.spec.label" default="Spec" /></span>
					
						<span class="property-value" aria-labelledby="spec-label"><g:fieldValue bean="${productInstance}" field="spec"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.exercisePrice}">
				<li class="fieldcontain">
					<span id="exercisePrice-label" class="property-label"><g:message code="product.exercisePrice.label" default="Exercise Price" /></span>
					
						<span class="property-value" aria-labelledby="exercisePrice-label"><g:fieldValue bean="${productInstance}" field="exercisePrice"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.extroInfo}">
				<li class="fieldcontain">
					<span id="extroInfo-label" class="property-label"><g:message code="product.extroInfo.label" default="Extro Info" /></span>
					
						<span class="property-value" aria-labelledby="extroInfo-label"><g:fieldValue bean="${productInstance}" field="extroInfo"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.reason}">
				<li class="fieldcontain">
					<span id="reason-label" class="property-label"><g:message code="product.reason.label" default="Reason" /></span>
					
						<span class="property-value" aria-labelledby="reason-label"><g:fieldValue bean="${productInstance}" field="reason"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.category}">
				<li class="fieldcontain">
					<span id="category-label" class="property-label"><g:message code="product.category.label" default="Category" /></span>
					
						<span class="property-value" aria-labelledby="category-label">${productInstance?.category?.name}</span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.dateCreated}">
				<li class="fieldcontain">
					<span id="dateCreated-label" class="property-label"><g:message code="product.dateCreated.label" default="Date Created" /></span>
					
						<span class="property-value" aria-labelledby="dateCreated-label"><g:formatDate date="${productInstance?.dateCreated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.lastUpdated}">
				<li class="fieldcontain">
					<span id="lastUpdated-label" class="property-label"><g:message code="product.lastUpdated.label" default="Last Updated" /></span>
					
						<span class="property-value" aria-labelledby="lastUpdated-label"><g:formatDate date="${productInstance?.lastUpdated}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="product.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${productInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.packingCount}">
				<li class="fieldcontain">
					<span id="packingCount-label" class="property-label"><g:message code="product.packingCount.label" default="Packing Count" /></span>
					
						<span class="property-value" aria-labelledby="packingCount-label"><g:fieldValue bean="${productInstance}" field="packingCount"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.code}">
				<li class="fieldcontain">
					<span id="code-label" class="property-label"><g:message code="product.code.label" default="Code" /></span>
					
						<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${productInstance}" field="code"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.onSale}">
				<li class="fieldcontain">
					<span id="onSale-label" class="property-label"><g:message code="product.onSale.label" default="On Sale" /></span>
					
						<span class="property-value" aria-labelledby="onSale-label"><g:fieldValue bean="${productInstance}" field="onSale"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="product.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${productInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${productInstance?.index}">
				<li class="fieldcontain">
					<span id="index-label" class="property-label"><g:message code="product.index.label" default="Index" /></span>
					
						<span class="property-value" aria-labelledby="index-label"><g:fieldValue bean="${productInstance}" field="index"/></span>
					
				</li>
				</g:if>
			
				<li class="fieldcontain">
					<span id="picture-label" class="property-label"><g:message code="productPicture.label" default="Picture" /></span>
					<g:uploadForm action="saveFile">
					<input type="hidden" name="id" value="${productInstance.id }">
					<input name="productPicture" type="file"/>
					<input name="index"/>
					<g:submitButton name="Save"/>
					</g:uploadForm>
				</li>
			
				<li class="fieldcontain">
					<span id="pictureList-label" class="property-label"><g:message code="productPicture.label" default="Picture" /></span>
					
						<table>
							<g:each in="${ProductPicture.findAllByProduct(productInstance).sort(true, {it.index}) }" var="pp">
								<tr>
									<td><img alt="" src="${createLink(controller:'image', action:'name', id:pp.file.id) }"></td>
									<td>${pp.index }</td>
									<td><a href="${createLink(controller:'product', action:'deleteFile', id:pp.id) }">x</a></td>
								</tr>
							</g:each>
						</table>
					
				</li>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${productInstance?.id}" />
					<g:link class="edit" action="edit" id="${productInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
