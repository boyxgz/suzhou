<!doctype html>
<%@page import="com.surelution.utop.Station"%>
<%@page import="grails.util.Holders"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0, user-scalable=0"  charset="utf-8"/>  
<title>优米商城</title>
<link href="${resource(file:'css/style2.css')}" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/reset.css')}">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/reboot.css')}">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/main2.css')}">
<link rel="stylesheet" type="text/css" href="${resource(file:'css/media.css')}">
<script src="${resource(file:'js/map.js')}"></script>
<script src="${resource(file:'js/jquery.min.js')}"></script>
<script src="${resource(file:'js/jquery-ui.min.js')}"></script>
<script src="${resource(file:'js/jquery.simplesidebar.js')}"></script>
<script type="text/javascript" src="${resource(file:'js/jquery.flexslider-min.js')}"></script>
	<wx:registerJsapi apiList="'scanQRCode'"/>
	<script type="text/javascript">
		function showScan() {
			wx.scanQRCode({
			    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
			    scanType: ["qrCode"], // 可以指定扫二维码还是一维码，默认二者都有
			    success: function (res) {
			    	var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
			    	if(result.indexOf('${Holders.config.grails.serverURL}${createLink(controller:'shop2', action:'directShop')}') == 0) {
						document.location.href = result;
				    } else {
					    alert("请注意只扫码商品二维码，其他二维码无法识别！");
					}
				}
			});
		}
	</script>
<script type="text/javascript">
	function search() {
		var baseUrl = '${createLink(controller:'shop2', action:'search')}' + "/";
		document.location.href = baseUrl + $('#prodName').val();
	}
</script>
</head>

<body>

<div class="wrapper">
	<div class="toolbar">
      <div class="logo"><a href="${createLink(controller:'shop2', action:'index') }"><img src="${resource(file:'images/logo.jpg') }" width="80%"></a></div>
      <div class="top_btn"><input name="prodName" id='prodName' type="text" class="btn110" placeholder="请输入您需要搜索产品"><input name="" type="button" class="btn119" onclick="search()"></div>
	 
	</div>

</div>

<div class="car_box">
  <div class=" s_sp_title">购物车<a href="#" style="float:right; padding-right:6.5%;"><input type="button" onclick="showScan()" value="扫一扫添加商品" style=" padding:5px 10px; border:none; background:#e67817; color:#fff; cursor:pointer;"></a></div>
  
	<g:if test="${newOrder && orderItems}">
	<g:each in="${orderItems }" var="item">
  <dl>
      <div class="pic"><a href="javascript:deleteItem(${item.id })"><img src="${resource(file:'images/delete.png') }" width="20"></a></div>
    <dt><img src="${Holders.config.alioss.images.rootUrl }${item.plan.product.defaultPictureId}"></dt>
      <dd class="d2">${item.plan.product.name }</dd>
      <dd class="d1">价格：￥${item.plan.price }<span>市场价：￥${item.plan.retailPrice }</span></dd>
      <dd class="d1">规格：${item.plan.product.spec }</dd>
      <dd class="d1" style="color:#333;"><b style=" float:left; padding-right:10px;">数量:</b><a href="javascript:updateQty('${item.id }', 1)">+</a><input type="number" id="productCount_${item.id }" value="${item.itemCount }" onchange="updateQtyWithValue(${item.id }, this.value)" onafterpaste="this.value=this.value.replace(/\D/g,'')"><a href="javascript:updateQty('${item.id }', -1)">-</a></dd>
    </dl>
    </g:each>
    </g:if>
</div>
<g:form action='confirmOrder' name="orderForm">
<g:hiddenField name="orderId" value="${newOrder?.id }"/>
<div class="car_box_car">
  <div class="car_box_car_s">
    <div class="car_box_car_s_l">请选择代金券：<br>
    <g:if test="${vouchers}">
		<g:each in="${vouchers }" var="voucher">
			<g:checkBox id="selectVouchers-${voucher.id }" onchange="checkVoucher('${voucher.id }')" name="selectVouchers" checked="${selectedVoucher && selectedVoucher.id==voucher.id }" value="${voucher.id }"/><label for="selectVouchers-${voucher.id }" style="font-size: 1em">${voucher.amount }元</label><br/>
		</g:each>
    </g:if>
    <g:else>无可用代金券</g:else>
    </div>
    <div class="car_box_car_s_r">提货加油站：<br><g:select name="station.id" from="${Station.findAllByEnabled(true) }" optionKey="id" optionValue="${{it.name + '【' + it.address + '】'} }"/></div>
  </div>
  <div class="car_box_car_x">
    <div class="car_box_car_x_l">应付金额：<span>￥<g:formatNumber number="${shouldPay }" format="###.##"/></span></div>
    <div class="car_box_car_x_r"><a href="javascript:confirmOrder()"><input type="button" value="结算"></a></div>
  </div>
</div>
</g:form>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br>

</body>

<g:if test="${newOrder }">
<script type="text/javascript">
function updateQty(id,qty) {
	var eleId = "#productCount_" + id;
	var oQty = $(eleId).val();
	if(oQty == "") {
		oQty = "0";
	}
	var v = parseInt(oQty) + qty;
	if(v < 0) {
		v = 0;
	}
	$(eleId).val(v);
	updateItem(id, v);
}
function updateQtyWithValue(id,qty) {
	var eleId = "#productCount_" + id;
	$(eleId).val(qty);
	updateItem(id, qty);
}
	function updateItem(itemId, count) {
		var url = "${createLink(action:'updateCart')}/" + itemId + "?newCount=" + count;
		document.location.href = url;
	}

	function deleteItem(itemId) {
		if(confirm("确定删除？")) {
			var url = "${createLink(action:'deleteCart')}/" + itemId;
			document.location.href = url;
		}
	}

	function confirmOrder() {
		document.getElementById("orderForm").submit();
	}

	function checkVoucher(voucher) {
		var checked = document.getElementById('selectVouchers-' + voucher).checked;
		var url = "${createLink(action:'cart', id:newOrder?.id)}?inCart=1"
		if(checked) {
			url += "&voucherId=" + voucher;
		}
		document.location.href = url;
	}
</script>
</g:if>
</html>
