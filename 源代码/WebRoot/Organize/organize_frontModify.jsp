<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Organize" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Organize organize = (Organize)request.getAttribute("organize");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改志愿组织信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">志愿组织信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="organizeEditForm" id="organizeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="organize_organizeId_edit" class="col-md-3 text-right">组织id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="organize_organizeId_edit" name="organize.organizeId" class="form-control" placeholder="请输入组织id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="organize_organizeName_edit" class="col-md-3 text-right">组织名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="organize_organizeName_edit" name="organize.organizeName" class="form-control" placeholder="请输入组织名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="organize_organizePhoto_edit" class="col-md-3 text-right">组织照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="organize_organizePhotoImg" border="0px"/><br/>
			    <input type="hidden" id="organize_organizePhoto" name="organize.organizePhoto"/>
			    <input id="organizePhotoFile" name="organizePhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="organize_makeDate_edit" class="col-md-3 text-right">成立日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date organize_makeDate_edit col-md-12" data-link-field="organize_makeDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="organize_makeDate_edit" name="organize.makeDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="organize_fuzheren_edit" class="col-md-3 text-right">联系负责人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="organize_fuzheren_edit" name="organize.fuzheren" class="form-control" placeholder="请输入联系负责人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="organize_telephone_edit" class="col-md-3 text-right">报名电话:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="organize_telephone_edit" name="organize.telephone" class="form-control" placeholder="请输入报名电话">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="organize_organizeDesc_edit" class="col-md-3 text-right">组织介绍:</label>
		  	 <div class="col-md-9">
			    <script name="organize.organizeDesc" id="organize_organizeDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="organize_signUpNames_edit" class="col-md-3 text-right">已报名人员:</label>
		  	 <div class="col-md-9">
			    <textarea id="organize_signUpNames_edit" name="organize.signUpNames" rows="8" class="form-control" placeholder="请输入已报名人员"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxOrganizeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#organizeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var organize_organizeDesc_editor = UE.getEditor('organize_organizeDesc_edit'); //组织介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改志愿组织界面并初始化数据*/
function organizeEdit(organizeId) {
  organize_organizeDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(organizeId);
  });
}
 function ajaxModifyQuery(organizeId) {
	$.ajax({
		url :  basePath + "Organize/" + organizeId + "/update",
		type : "get",
		dataType: "json",
		success : function (organize, response, status) {
			if (organize) {
				$("#organize_organizeId_edit").val(organize.organizeId);
				$("#organize_organizeName_edit").val(organize.organizeName);
				$("#organize_organizePhoto").val(organize.organizePhoto);
				$("#organize_organizePhotoImg").attr("src", basePath +　organize.organizePhoto);
				$("#organize_makeDate_edit").val(organize.makeDate);
				$("#organize_fuzheren_edit").val(organize.fuzheren);
				$("#organize_telephone_edit").val(organize.telephone);
				organize_organizeDesc_editor.setContent(organize.organizeDesc, false);
				$("#organize_signUpNames_edit").val(organize.signUpNames);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交志愿组织信息表单给服务器端修改*/
function ajaxOrganizeModify() {
	$.ajax({
		url :  basePath + "Organize/" + $("#organize_organizeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#organizeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#organizeQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*成立日期组件*/
    $('.organize_makeDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    organizeEdit("<%=request.getParameter("organizeId")%>");
 })
 </script> 
</body>
</html>

