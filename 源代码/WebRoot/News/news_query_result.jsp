﻿<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/news.css" /> 

<div id="news_manage"></div>
<div id="news_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="news_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="news_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="news_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="news_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="news_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="newsQueryForm" method="post">
			新闻标题：<input type="text" class="textbox" id="title" name="title" style="width:110px" />
			新闻分类：<input type="text" class="textbox" id="newClass" name="newClass" style="width:110px" />
			发布时间：<input type="text" id="publishDate" name="publishDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="news_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="newsEditDiv">
	<form id="newsEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">新闻id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newsId_edit" name="news.newsId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">新闻标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_title_edit" name="news.title" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">新闻分类:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_newClass_edit" name="news.newClass" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">新闻内容:</span>
			<span class="inputControl">
				<script name="news.content" id="news_content_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="news_publishDate_edit" name="news.publishDate" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var news_content_editor = UE.getEditor('news_content_edit'); //新闻内容编辑器
</script>
<script type="text/javascript" src="News/js/news_manage.js"></script> 
