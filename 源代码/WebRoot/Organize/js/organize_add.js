$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('organize_organizeDesc');
	var organize_organizeDesc_editor = UE.getEditor('organize_organizeDesc'); //组织介绍编辑框
	$("#organize_organizeName").validatebox({
		required : true, 
		missingMessage : '请输入组织名称',
	});

	$("#organize_makeDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#organize_fuzheren").validatebox({
		required : true, 
		missingMessage : '请输入联系负责人',
	});

	$("#organize_telephone").validatebox({
		required : true, 
		missingMessage : '请输入报名电话',
	});

	$("#organize_signUpNames").validatebox({
		required : true, 
		missingMessage : '请输入已报名人员',
	});

	//单击添加按钮
	$("#organizeAddButton").click(function () {
		if(organize_organizeDesc_editor.getContent() == "") {
			alert("请输入组织介绍");
			return;
		}
		//验证表单 
		if(!$("#organizeAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#organizeAddForm").form({
			    url:"Organize/add",
			    onSubmit: function(){
					if($("#organizeAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#organizeAddForm").form("clear");
                        organize_organizeDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#organizeAddForm").submit();
		}
	});

	//单击清空按钮
	$("#organizeClearButton").click(function () { 
		$("#organizeAddForm").form("clear"); 
	});
});
