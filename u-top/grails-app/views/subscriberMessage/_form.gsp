<%@ page import="com.surelution.wxmp.jx.SubscriberMessage" %>



<div class="fieldcontain ${hasErrors(bean: subscriberMessageInstance, field: 'content', 'error')} ">
	<label for="content">
		<g:message code="subscriberMessage.content.label" default="Content" />
		
	</label>
	<g:textField name="content" value="${subscriberMessageInstance?.content}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: subscriberMessageInstance, field: 'date', 'error')} required">
	<label for="date">
		<g:message code="subscriberMessage.date.label" default="Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="date" precision="day"  value="${subscriberMessageInstance?.date}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: subscriberMessageInstance, field: 'fromSubscriber', 'error')} required">
	<label for="fromSubscriber">
		<g:message code="subscriberMessage.fromSubscriber.label" default="From Subscriber" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="fromSubscriber" name="fromSubscriber.id" from="${com.surelution.wxmp.jx.Subscriber.list()}" optionKey="id" required="" value="${subscriberMessageInstance?.fromSubscriber?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: subscriberMessageInstance, field: 'isSolved', 'error')} ">
	<label for="isSolved">
		<g:message code="subscriberMessage.isSolved.label" default="Is Solved" />
		
	</label>
	<g:checkBox name="isSolved" value="${subscriberMessageInstance?.isSolved}" />
</div>

<div class="fieldcontain ${hasErrors(bean: subscriberMessageInstance, field: 'toStation', 'error')} required">
	<label for="toStation">
		<g:message code="subscriberMessage.toStation.label" default="To Station" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="toStation" name="toStation.id" from="${com.surelution.wxmp.jx.GasStation.list()}" optionKey="id" required="" value="${subscriberMessageInstance?.toStation?.id}" class="many-to-one"/>
</div>

