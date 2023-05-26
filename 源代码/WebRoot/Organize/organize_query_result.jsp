<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/organize.css" /> 

<div id="organize_manage"></div>
<div id="organize_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="organize_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="organize_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="organize_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="organize_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="organize_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="organizeQueryForm" method="post">
			组织名称：<input type="text" class="textbox" id="organizeName" name="organizeName" style="width:110px" />
			成立日期：<input type="text" id="makeDate" name="makeDate" class="easyui-datebox" editable="false" style="width:100px">
			报名电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="organize_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="organizeEditDiv">
	<form id="organizeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">组织id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_organizeId_edit" name="organize.organizeId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">组织名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_organizeName_edit" name="organize.organizeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">组织照片:</span>
			<span class="inputControl">
				<img id="organize_organizePhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="organize_organizePhoto" name="organize.organizePhoto"/>
				<input id="organizePhotoFile" name="organizePhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_makeDate_edit" name="organize.makeDate" />

			</span>

		</div>
		<div>
			<span class="label">联系负责人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_fuzheren_edit" name="organize.fuzheren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">报名电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_telephone_edit" name="organize.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">组织介绍:</span>
			<span class="inputControl">
				<script name="organize.organizeDesc" id="organize_organizeDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">已报名人员:</span>
			<span class="inputControl">
				<textarea id="organize_signUpNames_edit" name="organize.signUpNames" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var organize_organizeDesc_editor = UE.getEditor('organize_organizeDesc_edit'); //组织介绍编辑器
</script>
<script type="text/javascript" src="Organize/js/organize_manage.js"></script> 
