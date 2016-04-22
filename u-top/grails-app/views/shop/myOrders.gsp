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
	<link href="${resource(dir:'css', file:'mycenter.css') }" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${resource(dir:'js', file:'jquery-1.11.0.min.js') }"></script>
</head>
<body>
<div id="divBody">
<div class="wap_top">
      <p class="top_back" name="topback"><a href="javascript:;"><img src="${resource(dir:'images', file:'top_back.png') }" height="41" width="24"></a></p>
	  <p class="top_tit">我的提货券</p>
</div>
<div class="ind_content">
	<div class="my_account">
		<ul>
		<g:if test="${tickets }">
			<g:each in="${tickets }" var="ticket">
				<li>
					<a href="${createLink(controller:'shop', action:'showOrder', id:ticket.id) }" target="_self">
						<div class="ico"><img src="${resource(dir:'images', file:'my_n_ico03.png') }">${ticket.wellLookSn }</div>
						<div class="arrow"><img src="${resource(dir:'images', file:'arrow_n_right.png') }"></div>
					</a>
				</li>
			</g:each>
		</g:if>
		<g:else>
				<li>
					<a href="${createLink(controller:'shop', action:'index')}" target="_self">
						<div class="ico"><img src="${resource(dir:'images', file:'my_n_ico03.png') }">您没有任何可用提货券，请前往商城采购</div>
						<div class="arrow"><img src="${resource(dir:'images', file:'arrow_n_right.png') }"></div>
					</a>
				</li>
		</g:else>
		</ul>
	</div>
</div>
</div>

</body>
</html>