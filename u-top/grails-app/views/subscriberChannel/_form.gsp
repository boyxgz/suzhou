<%@ page import="com.surelution.utop.SubscriberChannel" %>



<div class="fieldcontain ${hasErrors(bean: subscriberChannelInstance, field: 'subscriber', 'error')} required">
	<label for="subscriber">
		<g:message code="subscriberChannel.subscriber.label" default="Subscriber" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="subscriber" name="subscriber.id" from="${com.surelution.utop.Subscriber.list()}" optionKey="id" required="" value="${subscriberChannelInstance?.subscriber?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: subscriberChannelInstance, field: 'channel', 'error')} required">
	<label for="channel">
		<g:message code="subscriberChannel.channel.label" default="Channel" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="channel" name="channel.id" from="${com.surelution.utop.SubscribingChannel.list()}" optionKey="id" required="" value="${subscriberChannelInstance?.channel?.id}" class="many-to-one"/>
</div>

