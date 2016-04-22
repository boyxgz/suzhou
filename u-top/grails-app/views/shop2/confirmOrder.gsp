<!doctype html>
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
	<wx:registerJsapi apiList="'closeWindow'"/>
	
	<script type="text/javascript">
		function fetchPrepayId() {
			var url = "${createLink(controller:'shop2', action:'preOrder', id:newOrder.id)}${selectVoucher?'?useVoucher=' + selectVoucher.id:''}";
			
			$.getJSON(url).done(function( json ) {
				if(json.valid) {
					if(json.needPay) { //需要支付
						placeOrder(json.appId, json.timeStamp, json.nonceStr, json.pkg, json.paySign);
					} else { //无需支付
						alert("订购成功，无需支付现金，稍后我们会下发订购成功通知");
			   			wx.closeWindow();
					}
				} else {
					alert("支付失败，原因可能是：系统维护或者重复支付，或请稍后再试。如有问题，请咨询店内工作人员");
				}
			  });
		}

		function placeOrder(appId, timeStamp, nonceStr, pkg, paySign) {
			if (typeof WeixinJSBridge == "undefined"){
			   if( document.addEventListener ){
			       document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
			   }else if (document.attachEvent){
			       document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
			       document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
			   }
			}else{
			   onBridgeReady(appId, timeStamp, nonceStr, pkg, paySign);
			}
		}

		function onBridgeReady(appId, timeStamp, nonceStr, pkg, paySign){
		   WeixinJSBridge.invoke(
		       'getBrandWCPayRequest', {
		           "appId" : appId,     //公众号名称，由商户传入     
		           "timeStamp": timeStamp,//时间戳，自1970年以来的秒数     
		           "nonceStr" : nonceStr, //随机串     
		           "package" : pkg,
		           "signType" : "MD5",//微信签名方式:     
		           "paySign" : paySign //微信签名 
		       },
		       function(res){
		    		// 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg将在用户支付成功后返回ok，但并不保证它绝对可靠。
		           if(res.err_msg == "get_brand_wcpay_request:ok" ) {
		        	   var url = "${createLink(controller:'shop2', action:'mobileReportPay', id:newOrder.id)}";
		        	   $.getJSON(url).done(function( json ) {
		   			  	});
		   			   alert("付款成功，稍后我们会下发订购成功通知");
						wx.closeWindow();
			       }      
		       }
		   );
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






<div class="car_box" >
  <div class="s_sp_title" style="overflow:hidden;">确认订单</div>
  <ul>
    <h2>商品清单：</h2>
    <g:each in="${orderItems}" var="item">
		<li>${item.plan.product.nameWithCount } X ${item.itemCount }</li>
	</g:each>
    <div>共${orderItems.size()}件商品<span>￥<g:formatNumber number="${newOrder.supposedAmount}" format="###.##"/></span></div>
  </ul>
  <ul>
    <h2>提货地点：</h2>
    <li>${newOrder.station.name }。地址在${newOrder.station.address }，联系电话${newOrder.station.tel }</li>
  </ul>
</div>

<div class="car_box_car">
  <div class="car_box_car_x">
    <div class="car_box_car_x_l" style="width:70%">应付金额：<span>￥<g:formatNumber number="${shouldPay}" format="###.##"/></span>优惠券：<span>￥${selectVoucher?selectVoucher.amount:0 }</span></div>
    <div class="car_box_car_x_r" style="width:30%;"><input type="button" onclick="fetchPrepayId()" value="付款"></div>
  </div>
</div>

<br><br><br><br><br><br><br><br><br><br><br><br><br><br>

</body>
</html>
