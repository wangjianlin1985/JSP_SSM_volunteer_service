<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/organize.css" />
<div id="organize_editDiv">
	<form id="organizeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">组织id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_organizeId_edit" name="organize.organizeId" value="<%=request.getParameter("organizeId") %>" style="width:200px" />
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
				<script id="organize_organizeDesc_edit" name="organize.organizeDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">已报名人员:</span>
			<span class="inputControl">
				<textarea id="organize_signUpNames_edit" name="organize.signUpNames" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="organizeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Organize/js/organize_modify.js"></script> 
