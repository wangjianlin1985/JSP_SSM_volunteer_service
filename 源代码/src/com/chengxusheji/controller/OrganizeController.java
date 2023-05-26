package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.OrganizeService;
import com.chengxusheji.po.Organize;

//Organize管理控制层
@Controller
@RequestMapping("/Organize")
public class OrganizeController extends BaseController {

    /*业务层对象*/
    @Resource OrganizeService organizeService;

	@InitBinder("organize")
	public void initBinderOrganize(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("organize.");
	}
	/*跳转到添加Organize视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Organize());
		return "Organize_add";
	}

	/*客户端ajax方式提交添加志愿组织信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Organize organize, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			organize.setOrganizePhoto(this.handlePhotoUpload(request, "organizePhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        organizeService.addOrganize(organize);
        message = "志愿组织添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询志愿组织信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String organizeName,String makeDate,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (organizeName == null) organizeName = "";
		if (makeDate == null) makeDate = "";
		if (telephone == null) telephone = "";
		if(rows != 0)organizeService.setRows(rows);
		List<Organize> organizeList = organizeService.queryOrganize(organizeName, makeDate, telephone, page);
	    /*计算总的页数和总的记录数*/
	    organizeService.queryTotalPageAndRecordNumber(organizeName, makeDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = organizeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = organizeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Organize organize:organizeList) {
			JSONObject jsonOrganize = organize.getJsonObject();
			jsonArray.put(jsonOrganize);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询志愿组织信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Organize> organizeList = organizeService.queryAllOrganize();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Organize organize:organizeList) {
			JSONObject jsonOrganize = new JSONObject();
			jsonOrganize.accumulate("organizeId", organize.getOrganizeId());
			jsonOrganize.accumulate("organizeName", organize.getOrganizeName());
			jsonArray.put(jsonOrganize);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询志愿组织信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String organizeName,String makeDate,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (organizeName == null) organizeName = "";
		if (makeDate == null) makeDate = "";
		if (telephone == null) telephone = "";
		List<Organize> organizeList = organizeService.queryOrganize(organizeName, makeDate, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    organizeService.queryTotalPageAndRecordNumber(organizeName, makeDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = organizeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = organizeService.getRecordNumber();
	    request.setAttribute("organizeList",  organizeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("organizeName", organizeName);
	    request.setAttribute("makeDate", makeDate);
	    request.setAttribute("telephone", telephone);
		return "Organize/organize_frontquery_result"; 
	}

     /*前台查询Organize信息*/
	@RequestMapping(value="/{organizeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer organizeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键organizeId获取Organize对象*/
        Organize organize = organizeService.getOrganize(organizeId);

        request.setAttribute("organize",  organize);
        return "Organize/organize_frontshow";
	}

	/*ajax方式显示志愿组织修改jsp视图页*/
	@RequestMapping(value="/{organizeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer organizeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键organizeId获取Organize对象*/
        Organize organize = organizeService.getOrganize(organizeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonOrganize = organize.getJsonObject();
		out.println(jsonOrganize.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新志愿组织信息*/
	@RequestMapping(value = "/{organizeId}/update", method = RequestMethod.POST)
	public void update(@Validated Organize organize, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String organizePhotoFileName = this.handlePhotoUpload(request, "organizePhotoFile");
		if(!organizePhotoFileName.equals("upload/NoImage.jpg"))organize.setOrganizePhoto(organizePhotoFileName); 


		try {
			organizeService.updateOrganize(organize);
			message = "志愿组织更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "志愿组织更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除志愿组织信息*/
	@RequestMapping(value="/{organizeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer organizeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  organizeService.deleteOrganize(organizeId);
	            request.setAttribute("message", "志愿组织删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "志愿组织删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条志愿组织记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String organizeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = organizeService.deleteOrganizes(organizeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出志愿组织信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String organizeName,String makeDate,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(organizeName == null) organizeName = "";
        if(makeDate == null) makeDate = "";
        if(telephone == null) telephone = "";
        List<Organize> organizeList = organizeService.queryOrganize(organizeName,makeDate,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Organize信息记录"; 
        String[] headers = { "组织id","组织名称","组织照片","成立日期","联系负责人","报名电话"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<organizeList.size();i++) {
        	Organize organize = organizeList.get(i); 
        	dataset.add(new String[]{organize.getOrganizeId() + "",organize.getOrganizeName(),organize.getOrganizePhoto(),organize.getMakeDate(),organize.getFuzheren(),organize.getTelephone()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Organize.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
