<!DOCTYPE html>
<%@page import="grails.util.Holders"%>
<%@page import="com.surelution.utop.Station"%>
<html>
<head>
	<meta charset="UTF-8" />	
	<meta content="yes" name="apple-mobile-web-app-capable" />
	<meta content="black" name="apple-mobile-web-app-status-bar-style" />
	<meta content="telephone=no" name="format-detection" />
	<meta name="viewport" content="minimal-ui, width=640, initial-scale=1, maximum-scale=0.5, minimum-scale=0.5, user-scalable=no, target-densitydpi=320"/>
	<title>优米</title>
	<link href="${resource(dir:'css', file:'youmi.css') }?v=4245" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'list.css') }" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'scrollbar.css') }" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${resource(dir:'js', file:'jquery-1.11.0.min.js') }"></script>
	<wx:registerJsapi apiList="'scanQRCode'"/>
	<script type="text/javascript">
		function showScan() {
			wx.scanQRCode({
			    needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
			    scanType: ["qrCode"], // 可以指定扫二维码还是一维码，默认二者都有
			    success: function (res) {
			    	var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
			    	if(result.indexOf('${Holders.config.grails.serverURL}${createLink(controller:'shop', action:'directShop')}') == 0) {
						document.location.href = result;
				    } else {
					    alert("请注意只扫码商品二维码，其他二维码无法识别！");
					}
				}
			});
		}
	</script>
</head>
<body>
<div id="divBody">
	<div class="wap_top">
		<p class="top_back" name="topback"><a href="javascript:;"><img src="${resource(dir:'images', file:'top_back.png') }" height="41" width="24"></a></p>
	  	<p class="top_word"><a href="javascript:showScan()">扫码</a></p>
	  	<p class="top_tit">购物车</p>
	</div>
	<div class="ind_content" id="ind_content">
	<g:if test="${newOrder && orderItems}">
	<g:each in="${orderItems }" var="item">
	<div class="cart_list">
		<dl class="b0">
			<dd>
				<div class="check">
					<a href="javascript:;" target="_self">
						<img id="chooseProduct_${item.plan.id }" data-val="1" data-pid="${item.plan.id }" src="${resource(dir:'images', file:'choice04.png') }" height="31" width="31">
					</a>
				</div>
				<div class="sku_pic">
						<a href="javascript:;" target="_self"><img src="${Holders.config.alioss.images.rootUrl }${item.plan.product.defaultPictureId}"></a>
				</div>
				<div class="cart_word" id="productWord_${item.plan.id }">
                       <p class="cart_name">
                        	${item.plan.product.nameWithCount }
                       </p>
                       <p class="cart_name2">&nbsp;</p>
                       <p class="cart_price">
							现价：￥${item.plan.price }&nbsp;<g:if test="${item.plan.price < item.plan.retailPrice }"><s style="color: gray">￥${item.plan.retailPrice }</s></g:if>
					</p>
                       <div class="cart_dtl">
                       		<input class="textgt" type="number" id="productCount_${item.plan.id }" value="${item.itemCount }" data-pid="${item.plan.id }" data-oc="1" data-ctype="0" onchange="updateItem(${item.id }, this.value)" onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="3">
							<a href="javascript:deleteItem(${item.id })" id="aDel" data-val="${item.plan.id },1" data-ctype="0" target="_self">
							<img src="${resource(dir:'images', file:'collect_ico02.gif') }" alt="" height="43" width="42">
							</a>
                       </div>
                </div>
			</dd>
		</dl>
	</div>
	</g:each>
	
	<g:form controller='shop' action='confirmOrder' name="orderForm">
	<div style="width:100%;height:1.075rem;bottom:0;left:0;float:left;border-top: 1px solid #c8c9ca;"></div>
	<div class="cart_buys" id="divTotal">
		<div class="price">
			<g:hiddenField name="orderId" value="${newOrder.id }"/>
			<g:if test="${vouchers}">
			请选择代金券：<br/>
			<g:each in="${vouchers }" var="voucher">
				<g:checkBox id="selectVouchers-${voucher.id }" onchange="checkVoucher('${voucher.id }')" name="selectVouchers" checked="${selectedVoucher && selectedVoucher.id==voucher.id }" value="${voucher.id }"/><label for="selectVouchers-${voucher.id }" style="font-size: 1em">${voucher.amount }元</label><br/>
			</g:each>
			</g:if>
			提货加油站：<g:select name="station.id" from="${Station.findAllByEnabled(true) }" optionKey="id" optionValue="${{it.name + '【' + it.address + '】'} }"/><br/>
			应付总额：<span class="bold" id="totalPrice">￥<g:formatNumber number="${shouldPay }" format="###.##"/></span>
		</div>
		<div class="orders_btn"><a href="javascript:confirmOrder()" class="buy_btn01">结算</a></div>
	</div>
	</g:form>
</g:if>
<g:else>
	<div class="cart_buys" id="divTotal">
	<div class="price">
		您尚未选择任何商品，请返回挑选商品！
		</div>
	</div>
</g:else>
</div>
</div>

<g:if test="${newOrder }">
<script type="text/javascript">
	function updateItem(itemId, count) {
		var url = "${createLink(controller:'shop', action:'updateCart')}/" + itemId + "?newCount=" + count;
		document.location.href = url;
	}

	function deleteItem(itemId) {
		if(confirm("确定删除？")) {
			var url = "${createLink(controller:'shop', action:'deleteCart')}/" + itemId;
			document.location.href = url;
		}
	}

	function confirmOrder() {
		document.getElementById("orderForm").submit();
	}

	function checkVoucher(voucher) {
		var checked = document.getElementById('selectVouchers-' + voucher).checked;
		var url = "${createLink(controller:'shop', action:'cart', id:newOrder?.id)}?inCart=1"
		if(checked) {
			url += "&voucherId=" + voucher;
		}
		document.location.href = url;
	}
</script>
</g:if>

</body>
</html>