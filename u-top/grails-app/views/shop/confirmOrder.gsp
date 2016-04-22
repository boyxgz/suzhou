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
	<link href="${resource(dir:'css', file:'youmi.css') }?v=325" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'list.css') }" rel="stylesheet" type="text/css" />
	<link href="${resource(dir:'css', file:'scrollbar.css') }" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${resource(dir:'js', file:'jquery-1.11.0.min.js') }"></script>
	<wx:registerJsapi apiList="'closeWindow'"/>
	
	<script type="text/javascript">
		function fetchPrepayId() {
			var url = "${createLink(controller:'shop', action:'preOrder', id:newOrder.id)}${selectVoucher?'?useVoucher=' + selectVoucher.id:''}";
			
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
		        	   var url = "${createLink(controller:'shop', action:'mobileReportPay', id:newOrder.id)}";
		        	   $.getJSON(url).done(function( json ) {
		   			  	});
		   			   alert("付款成功，稍后我们会下发订购成功通知");
		   				wx.closeWindow();
			       }      
		       }
		   );
		}
	</script>
</head>
<body>
<div id="divBody">
	<div id="divOrder">
		<div class="wap_top" id="normalCss">
	      	 	<p class="top_back" name="myback"><a href="javascript:;" target="_self"><img src="${resource(dir:'images', file:'top_back.png') }" height="41" width="24"></a></p>
		  	 <p class="top_tit" id="toptit">确认提交</p>
		</div>
		<div class="ind_content">
		<div class="orders_buy">
		<div class="orders_price">应付总额：
			<span>
				￥<g:formatNumber number="${shouldPay}" format="###.##"/>
			</span>
		</div>
		<g:if test="${selectVoucher }">
			<div class="orders_price">使用代金券：
				<span>
					${selectVoucher.amount }元
				</span>
			</div>
		</g:if>
		<div class="orders_btn" name="subOrder" id="subOrderBottom"><a href="javascript:fetchPrepayId();">付款</a></div>
	</div>
	<div class="orders">
	<!-- 
    	<dl>
			<dt>
				<a href="javascript:;" id="showAddress">
					<div class="orders_next"><img src="http://image5.benlailife.com/wap/images/arrow_r.png"></div>
					<div class="word3">
							姓名xxx
							<span>电话号码</span>
							<p>地址xxxx</p>
					</div>
	            </a>
			</dt>
		</dl>
		 -->
		<dl>
			<dt>
	            <a href="javascript:;">
		          	<div class="orders_ico"><img src="${resource(dir:'images', file:'orders_ico01.gif') }" height="32" width="32"></div>
		          	<!--<div class="orders_next"><img src="http://image6.benlailife.com/wap/images/arrow_r.png"></div>-->
		          	<div class="word">提货地点<p>
			          	</p><p>
			          		${newOrder.station.name }。地址在${newOrder.station.address }，联系电话${newOrder.station.tel }
					    </p>
					</div>
				</a>

            </dt>
		</dl>
		<!-- 
			<dl>
				<dt>
					<a href="javascript:;" class="select" id="aScore" data-checked="false" data-val="35" data-canuse="35" data-message="">使用积分 <span>（现存积分35,本次使用范围0-35）</span>
						<img src="http://image2.benlailife.com/wap/images/choice_close.png">
					</a>
				</dt>
			</dl>
			<dl>
				<dt>
					<a href="javascript:;" class="select" id="aBalance" data-checked="false" data-val="0" data-canuse="0" data-message="">使用余额<span>（现存余额￥0.0）</span>
						<img src="http://image2.benlailife.com/wap/images/choice_forbid.png">
					</a>
				</dt>
			</dl>
			<dl>
				<dt>
					<a href="javascript:;" class="select" id="aGiftCard" data-checked="false" data-val="0" data-canuse="0" data-message="">使用礼金卡<span>（现存￥0.0）</span>
						<img src="http://image3.benlailife.com/wap/images/choice_forbid.png">
					</a>
				</dt>
			</dl>
			<dl>
				<dt>
						<a href="javascript:;" class="select" id="aCoupon" data-checked="false">使用优惠劵<span>（现存 0张）</span>
						<img src="http://image1.benlailife.com/wap/images/choice_close.png">
					</a>
				</dt>
			</dl>
			 -->
		<dl>
			<dt>
	            <a href="javascript:;" id="aProductInfo">
						<div class="orders_ico"><img src="${resource(dir:'images', file:'orders_ico03.gif') }" height="32" width="32"></div>
						<div class="quantity">共${orderItems.sum{it.itemCount} }件商品<br></div>
						<div class="word2">
	                        商品清单
	                    <g:each in="${orderItems}" var="item">
	                    <p>
						${item.plan.product.nameWithCount } X ${item.itemCount }
						<br>
						</p>
	                    </g:each>
	                  </div>
	            </a>
            </dt>
		</dl>
		<!-- 
		<dl>
			<dt>
				<a>
					<div class="orders_ico"><img src="http://image5.benlailife.com/wap/images/cart/orders_ico03.gif" height="32" width="32"></div>
					<div class="word">发票<p>很抱歉，近期我们暂时不能提供发票。<br>请联系4008-000-917，我们将尽快为您补寄。</p></div>
				</a>
			</dt>
		</dl>
		 -->
      </div>
      
		<!-- 
	<div class="orders_money">
			<dl class="price">
				<dt>商品金额</dt>
				<dd>+￥25.80</dd>
		  	</dl>
			<dl>
				<dt>运费：</dt>
				<dd>+￥20.00</dd>
			</dl>
	<dl class="money_btn" name="subOrder" id="subOrderFoot"><a href="javascript:;">提交订单</a></dl>
	</div>
			 -->
	<!--<div id="abc" style="width: 180px;height: 150px;position: fixed;top: 50%;left: 50%;margin-top: -50px;margin-left: -50px;background-color: black;">
		<dd>
	      <input type="radio" name="radiobutton" value="radiobutton" checked><a href="javascript:;">货到付款</a><br>
	      <input type="radio" name="radiobutton" value="radiobutton"><a href="javascript:;">支付宝网页支付</a><br>
	      <input type="radio" name="radiobutton" value="radiobutton"><a href="javascript:;">支付宝客户端支付</a><br>
	      <input type="radio" name="radiobutton" value="radiobutton"><a href="javascript:;" class="b0">百度支付</a><br>
		</dd>
	</div>
	
	<div id="greybackground" style="display: block; position: absolute; top: 0%; left: 0%; background-color: black; z-index: 9000; opacity: 0.5; height: 7481px; width: 1903px;"></div>-->
</div>
	</div>
</div>
<!--<div id="fullScreen" class="wap_fullScreen" style="display:none;"></div>-->
<div id="fullScreen" class="wap_fullScreen" style="display: none; position: fixed; top: 0%; left: 0%; background-color: black; z-index: 9000; opacity: 0.5;width:100%;height:100%"></div>
<div id="msgArea" class="wap_pop" style="display:none;z-index:9001; position:fixed; left:50%;top:50%;margin-left:-270px;margin-top:-100px;">
	<div id="msgCloseBtn" class="close" onclick="closeMsg()">
		<a href="javascript:;"><s></s></a>
	</div>
	<div id="msgTitleArea" class="tit"></div>
	<div id="msgContentArea" class="word2"></div>
	<div id="msgBtnArea" class="btn" style="display:none;">
		<a id="msgBtn1" href="javascript:;" target="_self" class="buy_btn09 mr35">确定</a>
		<a id="msgBtn2" href="javascript:;" target="_self" class="buy_btn09">取消</a>
	</div>
</div>

<div id="sharePop" class="share_pop"><!-- style="display:none" -->
	<div class="share_tit"><a id="closeShareBtn" href="javascript:;" onclick="closeShare();"><s></s></a></div>
	<dl>
		<a id="sLink_Sina" href="javascript:;">
			<dt><s class="ico01"></s></dt>
			<dd>分享到新浪微博</dd>
		</a>
	</dl>
	<dl>
		<a id="sLink_Qzone" href="javascript:;">
			<dt><s class="ico02"></s></dt>
			<dd>分享到腾讯微博</dd>
		</a>
	</dl>
	<!--<dl>
		<a href="javascript:;">
			<dt><s class="ico03"></s></dt>
			<dd>分享到微信好友</dd>
		</a>
	</dl>
	<dl class="b0">
		<a href="javascript:;">
			<dt><s class="ico04"></s></dt>
			<dd>分享到朋友圈</dd>
		</a>
	</dl>-->
</div>
</body>
</html>