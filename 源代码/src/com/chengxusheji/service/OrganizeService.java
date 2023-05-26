package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Organize;

import com.chengxusheji.mapper.OrganizeMapper;
@Service
public class OrganizeService {

	@Resource OrganizeMapper organizeMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加志愿组织记录*/
    public void addOrganize(Organize organize) throws Exception {
    	organizeMapper.addOrganize(organize);
    }

    /*按照查询条件分页查询志愿组织记录*/
    public ArrayList<Organize> queryOrganize(String organizeName,String makeDate,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!organizeName.equals("")) where = where + " and t_organize.organizeName like '%" + organizeName + "%'";
    	if(!makeDate.equals("")) where = where + " and t_organize.makeDate like '%" + makeDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_organize.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return organizeMapper.queryOrganize(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Organize> queryOrganize(String organizeName,String makeDate,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!organizeName.equals("")) where = where + " and t_organize.organizeName like '%" + organizeName + "%'";
    	if(!makeDate.equals("")) where = where + " and t_organize.makeDate like '%" + makeDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_organize.telephone like '%" + telephone + "%'";
    	return organizeMapper.queryOrganizeList(where);
    }

    /*查询所有志愿组织记录*/
    public ArrayList<Organize> queryAllOrganize()  throws Exception {
        return organizeMapper.queryOrganizeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String organizeName,String makeDate,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!organizeName.equals("")) where = where + " and t_organize.organizeName like '%" + organizeName + "%'";
    	if(!makeDate.equals("")) where = where + " and t_organize.makeDate like '%" + makeDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_organize.telephone like '%" + telephone + "%'";
        recordNumber = organizeMapper.queryOrganizeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取志愿组织记录*/
    public Organize getOrganize(int organizeId) throws Exception  {
        Organize organize = organizeMapper.getOrganize(organizeId);
        return organize;
    }

    /*更新志愿组织记录*/
    public void updateOrganize(Organize organize) throws Exception {
        organizeMapper.updateOrganize(organize);
    }

    /*删除一条志愿组织记录*/
    public void deleteOrganize (int organizeId) throws Exception {
        organizeMapper.deleteOrganize(organizeId);
    }

    /*删除多条志愿组织信息*/
    public int deleteOrganizes (String organizeIds) throws Exception {
    	String _organizeIds[] = organizeIds.split(",");
    	for(String _organizeId: _organizeIds) {
    		organizeMapper.deleteOrganize(Integer.parseInt(_organizeId));
    	}
    	return _organizeIds.length;
    }
}
