<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/organize.css" />
<div id="organizeAddDiv">
	<form id="organizeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">组织名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_organizeName" name="organize.organizeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">组织照片:</span>
			<span class="inputControl">
				<input id="organizePhotoFile" name="organizePhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_makeDate" name="organize.makeDate" />

			</span>

		</div>
		<div>
			<span class="label">联系负责人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_fuzheren" name="organize.fuzheren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">报名电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="organize_telephone" name="organize.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">组织介绍:</span>
			<span class="inputControl">
				<script name="organize.organizeDesc" id="organize_organizeDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">已报名人员:</span>
			<span class="inputControl">
				<textarea id="organize_signUpNames" name="organize.signUpNames" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="organizeAddButton" class="easyui-linkbutton">添加</a>
			<a id="organizeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Organize/js/organize_add.js"></script> 
