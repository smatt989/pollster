$(document).on("click", ".poll_answer", function(){
	var response_obj = new Object();
	response_obj.poll_id=$("#poll_id_li").data("pid");
	response_obj.response_type=$(this).data("type");
	response_obj.content=$(this).html();
	$.ajax({
		type: "post",
		url: "/responses",
		data: response_obj,
		dataTye: "script",
		success: function(){
			alert('created!');
		}
	});
})