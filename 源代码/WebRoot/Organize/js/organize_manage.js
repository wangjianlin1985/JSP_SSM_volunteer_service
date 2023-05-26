var organize_manage_tool = null; 
$(function () { 
	initOrganizeManageTool(); //建立Organize管理对象
	organize_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#organize_manage").datagrid({
		url : 'Organize/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "organizeId",
		sortOrder : "desc",
		toolbar : "#organize_manage_tool",
		columns : [[
			{
				field : "organizeId",
				title : "组织id",
				width : 70,
			},
			{
				field : "organizeName",
				title : "组织名称",
				width : 140,
			},
			{
				field : "organizePhoto",
				title : "组织照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "makeDate",
				title : "成立日期",
				width : 140,
			},
			{
				field : "fuzheren",
				title : "联系负责人",
				width : 140,
			},
			{
				field : "telephone",
				title : "报名电话",
				width : 140,
			},
		]],
	});

	$("#organizeEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#organizeEditForm").form("validate")) {
					//验证表单 
					if(!$("#organizeEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#organizeEditForm").form({
						    url:"Organize/" + $("#organize_organizeId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#organizeEditDiv").dialog("close");
			                        organize_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#organizeEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#organizeEditDiv").dialog("close");
				$("#organizeEditForm").form("reset"); 
			},
		}],
	});
});

function initOrganizeManageTool() {
	organize_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#organize_manage").datagrid("reload");
		},
		redo : function () {
			$("#organize_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#organize_manage").datagrid("options").queryParams;
			queryParams["organizeName"] = $("#organizeName").val();
			queryParams["makeDate"] = $("#makeDate").datebox("getValue"); 
			queryParams["telephone"] = $("#telephone").val();
			$("#organize_manage").datagrid("options").queryParams=queryParams; 
			$("#organize_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#organizeQueryForm").form({
			    url:"Organize/OutToExcel",
			});
			//提交表单
			$("#organizeQueryForm").submit();
		},
		remove : function () {
			var rows = $("#organize_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var organizeIds = [];
						for (var i = 0; i < rows.length; i ++) {
							organizeIds.push(rows[i].organizeId);
						}
						$.ajax({
							type : "POST",
							url : "Organize/deletes",
							data : {
								organizeIds : organizeIds.join(","),
							},
							beforeSend : function () {
								$("#organize_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#organize_manage").datagrid("loaded");
									$("#organize_manage").datagrid("load");
									$("#organize_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#organize_manage").datagrid("loaded");
									$("#organize_manage").datagrid("load");
									$("#organize_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#organize_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Organize/" + rows[0].organizeId +  "/update",
					type : "get",
					data : {
						//organizeId : rows[0].organizeId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (organize, response, status) {
						$.messager.progress("close");
						if (organize) { 
							$("#organizeEditDiv").dialog("open");
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
							organize_organizeDesc_editor.setContent(organize.organizeDesc, false);
							$("#organize_signUpNames_edit").val(organize.signUpNames);
							$("#organize_signUpNames_edit").validatebox({
								required : true,
								missingMessage : "请输入已报名人员",
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
