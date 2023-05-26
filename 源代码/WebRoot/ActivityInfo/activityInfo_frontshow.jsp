<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ActivityInfo" %>
<%@ page import="com.chengxusheji.po.SignUp" %>
<%@ page import="com.chengxusheji.po.ActivityType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的typeObj信息
    List<ActivityType> activityTypeList = (List<ActivityType>)request.getAttribute("activityTypeList");
    ActivityInfo activityInfo = (ActivityInfo)request.getAttribute("activityInfo");
    List<SignUp> signUpList = (ArrayList<SignUp>)request.getAttribute("signUpList");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看志愿项目详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>ActivityInfo/frontlist">志愿项目信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">项目id:</div>
		<div class="col-md-10 col-xs-6"><%=activityInfo.getActivityId()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">项目类型:</div>
		<div class="col-md-10 col-xs-6"><%=activityInfo.getTypeObj().getTypeName() %></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">项目主题:</div>
		<div class="col-md-10 col-xs-6"><%=activityInfo.getTitle()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">项目图片:</div>
		<div class="col-md-10 col-xs-6"><img class="img-responsive" src="<%=basePath %><%=activityInfo.getActivityPhoto() %>"  border="0px"/></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">项目内容:</div>
		<div class="col-md-10 col-xs-6"><%=activityInfo.getContent()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">项目时间:</div>
		<div class="col-md-10 col-xs-6"><%=activityInfo.getActivityTime()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">报名宣誓:</div>
		<div class="col-md-10 col-xs-6">
			<textarea id="signUpVow" style="width:100%" rows=8></textarea>
		</div>
	</div>
	
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="userSign();" class="btn btn-primary">我要报名</button>
			<button onclick="history.back();" class="btn btn-info">返回</button>
		</div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold"></div>
		<div class="col-md-8 col-xs-7">
			<% for(SignUp signUp: signUpList) { %>
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-2 col-xs-3">
					<div class="row text-center"><img src="<%=basePath %><%=signUp.getUserObj().getUserPhoto() %>" style="border: none;width:60px;height:60px;border-radius: 50%;" /></div>
					<div class="row text-center" style="margin: 5px 0px;"><%=signUp.getUserObj().getUser_name() %></div>
				</div>
				<div class="col-md-7 col-xs-5"><%=signUp.getSignUpVow() %></div>
				<div class="col-md-3 col-xs-4" ><%=signUp.getSignUpTime() %></div>
			</div>
		
			<% } %> 
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";
$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 });


function userSign() {
	var signUpVow = $("#signUpVow").val();
	if(signUpVow == "") {
		alert("请输入报名宣誓");
		return;
	}

	$.ajax({
		url : basePath + "SignUp/userAdd",
		type : "post",
		dataType: "json",
		data: {
			"signUp.activityObj.activityId": <%=activityInfo.getActivityId() %>,
			"signUp.signUpVow": signUpVow
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data);
			if(data.success){
				alert("报名成功~");
				location.reload();
			}else{
				alert(data.message);
			}
		}
	});
}



 </script> 
</body>
</html>

