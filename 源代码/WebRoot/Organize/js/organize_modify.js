$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('organize_organizeDesc_edit');
	var organize_organizeDesc_edit = UE.getEditor('organize_organizeDesc_edit'); //组织介绍编辑器
	organize_organizeDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Organize/" + $("#organize_organizeId_edit").val() + "/update",
		type : "get",
		data : {
			//organizeId : $("#organize_organizeId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (organize, response, status) {
			$.messager.progress("close");
			if (organize) { 
				$("#organize_organizeId_edit").val(organize.organizeId);
				$("#organize_organizeId_edit").validatebox({
					required : true,
					missingMessage : "请输入组织id",
					editable: false
				});
				$("#organize_organizeName_edit").val(organize.organizeName);
				$("#organize_organizeName_edit").validatebox({
					required : true,
					missingMessage : "请输入组织名称",
				});
				$("#organize_organizePhoto").val(organize.organizePhoto);
				$("#organize_organizePhotoImg").attr("src", organize.organizePhoto);
				$("#organize_makeDate_edit").datebox({
					value: organize.makeDate,
					required: true,
					showSeconds: true,
				});
				$("#organize_fuzheren_edit").val(organize.fuzheren);
				$("#organize_fuzheren_edit").validatebox({
					required : true,
					missingMessage : "请输入联系负责人",
				});
				$("#organize_telephone_edit").val(organize.telephone);
				$("#organize_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入报名电话",
				});
				organize_organizeDesc_edit.setContent(organize.organizeDesc);
				$("#organize_signUpNames_edit").val(organize.signUpNames);
				$("#organize_signUpNames_edit").validatebox({
					required : true,
					missingMessage : "请输入已报名人员",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#organizeModifyButton").click(function(){ 
		if ($("#organizeEditForm").form("validate")) {
			$("#organizeEditForm").form({
			    url:"Organize/" +  $("#organize_organizeId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#organizeEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#organizeEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
