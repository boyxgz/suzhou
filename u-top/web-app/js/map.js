function Show_Hidden(trid){
    if(trid.style.display=="block"){
        trid.style.display='none';
    }else{
        trid.style.display='block';
    }
}

function showHiddenQr(trid,url){
    if(trid.style.display=="block"){
    	trid.style.display='none';
    }else{
    	$('#imgQr').attr("src",url);
    	trid.style.display='block';
    }
}
