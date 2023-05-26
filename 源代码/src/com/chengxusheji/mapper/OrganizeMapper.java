package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Organize;

public interface OrganizeMapper {
	/*添加志愿组织信息*/
	public void addOrganize(Organize organize) throws Exception;

	/*按照查询条件分页查询志愿组织记录*/
	public ArrayList<Organize> queryOrganize(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有志愿组织记录*/
	public ArrayList<Organize> queryOrganizeList(@Param("where") String where) throws Exception;

	/*按照查询条件的志愿组织记录数*/
	public int queryOrganizeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条志愿组织记录*/
	public Organize getOrganize(int organizeId) throws Exception;

	/*更新志愿组织记录*/
	public void updateOrganize(Organize organize) throws Exception;

	/*删除志愿组织记录*/
	public void deleteOrganize(int organizeId) throws Exception;

}
