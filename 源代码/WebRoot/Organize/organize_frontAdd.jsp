<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>志愿组织添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Organize/frontlist">志愿组织管理</a></li>
  			<li class="active">添加志愿组织</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="organizeAddForm" id="organizeAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="organize_organizeName" class="col-md-2 text-right">组织名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="organize_organizeName" name="organize.organizeName" class="form-control" placeholder="请输入组织名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="organize_organizePhoto" class="col-md-2 text-right">组织照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="organize_organizePhotoImg" border="0px"/><br/>
					    <input type="hidden" id="organize_organizePhoto" name="organize.organizePhoto"/>
					    <input id="organizePhotoFile" name="organizePhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="organize_makeDateDiv" class="col-md-2 text-right">成立日期:</label>
				  	 <div class="col-md-8">
		                <div id="organize_makeDateDiv" class="input-group date organize_makeDate col-md-12" data-link-field="organize_makeDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="organize_makeDate" name="organize.makeDate" size="16" type="text" value="" placeholder="请选择成立日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="organize_fuzheren" class="col-md-2 text-right">联系负责人:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="organize_fuzheren" name="organize.fuzheren" class="form-control" placeholder="请输入联系负责人">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="organize_telephone" class="col-md-2 text-right">报名电话:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="organize_telephone" name="organize.telephone" class="form-control" placeholder="请输入报名电话">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="organize_organizeDesc" class="col-md-2 text-right">组织介绍:</label>
				  	 <div class="col-md-8">
							    <textarea name="organize.organizeDesc" id="organize_organizeDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="organize_signUpNames" class="col-md-2 text-right">已报名人员:</label>
				  	 <div class="col-md-8">
					    <textarea id="organize_signUpNames" name="organize.signUpNames" rows="8" class="form-control" placeholder="请输入已报名人员"></textarea>
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxOrganizeAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#organizeAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
	    </div>
	</div>
</div>
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var organize_organizeDesc_editor = UE.getEditor('organize_organizeDesc'); //组织介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加志愿组织信息
	function ajaxOrganizeAdd() { 
		//提交之前先验证表单
		$("#organizeAddForm").data('bootstrapValidator').validate();
		if(!$("#organizeAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(organize_organizeDesc_editor.getContent() == "") {
			alert('组织介绍不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Organize/add",
			dataType : "json" , 
			data: new FormData($("#organizeAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#organizeAddForm").find("input").val("");
					$("#organizeAddForm").find("textarea").val("");
					organize_organizeDesc_editor.setContent("");
				} else {
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
	//验证志愿组织添加表单字段
	$('#organizeAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"organize.organizeName": {
				validators: {
					notEmpty: {
						message: "组织名称不能为空",
					}
				}
			},
			"organize.makeDate": {
				validators: {
					notEmpty: {
						message: "成立日期不能为空",
					}
				}
			},
			"organize.fuzheren": {
				validators: {
					notEmpty: {
						message: "联系负责人不能为空",
					}
				}
			},
			"organize.telephone": {
				validators: {
					notEmpty: {
						message: "报名电话不能为空",
					}
				}
			},
			"organize.signUpNames": {
				validators: {
					notEmpty: {
						message: "已报名人员不能为空",
					}
				}
			},
		}
	}); 
	//成立日期组件
	$('#organize_makeDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#organizeAddForm').data('bootstrapValidator').updateStatus('organize.makeDate', 'NOT_VALIDATED',null).validateField('organize.makeDate');
	});
})
</script>
</body>
</html>
