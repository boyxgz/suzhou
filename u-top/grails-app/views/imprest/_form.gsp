<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.surelution.utop.Imprest" %>

<script type="text/javascript" src="${resource(file:'js/jquery-1.9.1.min.js') }"></script>
<link href="${resource(dir:'css/jquery.datetimepicker.css')}" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${resource(file:'js/jquery.datetimepicker.js') }"></script>
<script type="text/javascript">
	$( document ).ready(function() {
		$('#transferDate').datetimepicker({
			dayOfWeekStart : 1,
			lang:'ch',
			format:'Y-m-d H:i'
			});
		$('#transferDate').datetimepicker({step:10});
	});
</script>


<div class="fieldcontain ${hasErrors(bean: imprestInstance, field: 'transactionNo', 'error')} ">
	<label for="transactionNo">
		<g:message code="imprest.transactionNo.label" default="Transaction No" />
		
	</label>
	<g:textField name="transactionNo" value="${imprestInstance?.transactionNo}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: imprestInstance, field: 'amount', 'error')} required">
	<label for="amount">
		<g:message code="imprest.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="amount" value="${fieldValue(bean: imprestInstance, field: 'amount')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: imprestInstance, field: 'transferDate', 'error')} required">
	<label for="transferDate">
		<g:message code="imprest.transferDate.label" default="Transfer Date" />
		<span class="required-indicator">*</span>
	</label>
	
	<%
		def df = imprestInstance?.transferDate
		def sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm")
		if(!df) {
			def f = new Date().clearTime()
			f.setDate(f.getDate() - 1)
			f.setHours(16)
			df = sdf.format(f)
		}
	 %>
	 <g:textField name="transferDate" value="${df}"/>
</div>

