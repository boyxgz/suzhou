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
</head>
<body>
<div id="divBody">
	<div class="wap_top">
		<p class="top_back" name="topback"><a href="javascript:;"><img src="${resource(dir:'images', file:'top_back.png') }" height="41" width="24"></a></p>
	  	<p class="top_tit">提货列表</p>
	</div>
	<div class="ind_content" id="ind_content">
	<g:if test="${saleOrder && orderItems}">
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
                        	${item.plan.product.nameWithCount } X ${item.itemCount }
                       </p>
                       <p class="cart_name2">&nbsp;</p>
                       <p class="cart_price">
							现价：￥${item.plan.price }&nbsp;<g:if test="${item.plan.price < item.plan.retailPrice }"><s style="color: gray">￥${item.plan.retailPrice }</s></g:if>
					</p>
                </div>
			</dd>
		</dl>
	</div>
	</g:each>
	
<div>
<br/>
	<p align="center">
		<img src="${createLink(controller:'shop', action:'deliveryQr', id:delivery.id) }" height="320" width="320"><br/>
		${ticket.wellLookSn }
	</p>
</div>
</g:if>
<g:else>
没有任何商品
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