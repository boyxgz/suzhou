<%@ page import="com.surelution.wxmp.jx.MultiNewsMessageItem" %>

<script type="text/javascript" charset="utf-8">
	function ckeditorFileBrowserItemSelected(path) {
		//${request.remoteHost}
		document.getElementById("pictureUrl").value='http://${request.remoteHost}' + path;
		//alert(path);
	}
</script>

<div class="fieldcontain ${hasErrors(bean: multiNewsMessageItemInstance, field: 'firstNews', 'error')} ">
	<label for="firstNews">
		<g:message code="multiNewsMessageItem.firstNews.label" default="First News" />
		
	</label>
	<g:checkBox name="firstNews" value="${multiNewsMessageItemInstance?.firstNews}" />
</div>

<div class="fieldcontain ${hasErrors(bean: multiNewsMessageItemInstance, field: 'message', 'error')} required">
	<label for="message">
		<g:message code="multiNewsMessageItem.message.label" default="Message" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="message" name="message.id" from="${com.surelution.wxmp.jx.MultiNewsMessage.list()}" optionKey="id" optionValue="description" required="" value="${multiNewsMessageItemInstance?.message?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: multiNewsMessageItemInstance, field: 'title', 'error')} ">
	<label for="title">
		<g:message code="multiNewsMessageItem.title.label" default="Title" />
		
	</label>
	<g:textField name="title" value="${multiNewsMessageItemInstance?.title}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: multiNewsMessageItemInstance, field: 'description', 'error')} ">
	<label for="description">
		<g:message code="multiNewsMessageItem.description.label" default="Description" />
		
	</label>
	<g:textArea name="description" value="${multiNewsMessageItemInstance?.description}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: multiNewsMessageItemInstance, field: 'pictureUrl', 'error')} ">
	<label for="pictureUrl">
		<g:message code="multiNewsMessageItem.pictureUrl.label" default="Picture Url" />
		
	</label>
	<g:textField name="pictureUrl" value="${multiNewsMessageItemInstance?.pictureUrl}"/>
	<ckeditor:fileBrowser fileBrowser="ofm" target="_blank" userSpace='userone'><g:message code="multiNewsMessageItem.openFile.label" default="Open file browser" /></ckeditor:fileBrowser>
</div>

<div class="fieldcontain ${hasErrors(bean: multiNewsMessageItemInstance, field: 'url', 'error')} ">
	<label for="url">
		<g:message code="multiNewsMessageItem.url.label" default="Url" />
		
	</label>
	<g:textField name="url" value="${multiNewsMessageItemInstance?.url}"/>
</div>

