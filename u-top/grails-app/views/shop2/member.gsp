<!doctype html>
<%@page import="com.surelution.utop.SaleOrderItem"%>
<%@page import="com.surelution.utop.DeliveryTicket"%>
<%@page import="com.surelution.utop.SaleOrder.SaleOrderStatus"%>
<html>
<head>
<meta name="layout" content="mobileShop">
<title>优米商城</title>
</head>

<body>

<div class="pro">
  <div id="TabbedPanels1" class="TabbedPanels">
	  <ul class="TabbedPanelsTabGroup">
	    <li class="TabbedPanelsTab" tabindex="0">优惠券</li>
	    <li class="TabbedPanelsTab" tabindex="0">订单管理</li>
    </ul>
	  <div class="TabbedPanelsContentGroup">
	    <div class="TabbedPanelsContent" style="padding-top:20px;">

<!--优惠券-->       
<div class="coupon">
  <ul>
  <g:each in="${vouchers }" var="voucher">
    <li><span>￥${voucher.amount }</span>${voucher.status }</li>
  </g:each>
  </ul>
</div>
<!--优惠券结束-->        
        </div>
	    <div class="TabbedPanelsContent" style="padding-top:20px;">
<!--订单 -->      
<g:each in="${orders }" var="order">
<%
	def ticket
	if(order.status == SaleOrderStatus.PAID || order.status == SaleOrderStatus.DELIVERED) {
		ticket = DeliveryTicket.findBySaleOrder(order)
	}
%>
<div class="car_box" style="width:90%; margin:0 auto;">
  <ul style="border-top:none;">
    <h2 style="text-align:left;" onclick="showHiddenQr(box,'${createLink(controller:'shop2', action:'deliveryQr', id:ticket.id)}')">提货号：<g:if test="${ticket }">${ticket.sn }</g:if><g:else>尚无</g:else><span>${order.status }</span></h2>
    <g:set var="items" value="${SaleOrderItem.findAllByOrderAndDeleted(order, false) }"/>
    <g:each in="${items }" var="item">
    	<li>${item.plan.product.name }&nbsp;${item.plan.product.spec }&nbsp;${item.plan.product.packingCount } X ${item.itemCount }<span>￥${item.itemCount * item.plan.price }</span></li>
    </g:each>
    <div>共${items.size() }件商品<span>￥${order.amount }</span></div>
  </ul>
</div>
</g:each>
<div id="box" style="display:none;"><a onclick="showHiddenQr(box,'')"><img src="" width="220" height="220" id="imgQr"></a></div>

<!--订单结束-->        
        </div>
    </div>
  </div>
</div>


</body>
</html>
