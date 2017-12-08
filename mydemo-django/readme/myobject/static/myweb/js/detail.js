$(function(){
	// 添加商品数量

	$(".add").click(function(){
		var count = parseFloat($(".num").text())+1;
		$(".num").text(count);
		var b = $('#J_price').text();
		var a = count*b;
		$(".total_price").text(a);
	})

	$(".sub").click(function(){
		var count = parseFloat($(".num").text());
		if(count==1){count=1;
			alert("亲,不能再点了!")
		}else{count--};
		$(".num").text(count);
		var b = $('#J_price').text();
		var a =count*b;
		$(".total_price").text(a);

	})
})