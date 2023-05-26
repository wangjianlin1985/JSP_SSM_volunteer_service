package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ActivityType;

public interface ActivityTypeMapper {
	/*添加项目类型信息*/
	public void addActivityType(ActivityType activityType) throws Exception;

	/*按照查询条件分页查询项目类型记录*/
	public ArrayList<ActivityType> queryActivityType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有项目类型记录*/
	public ArrayList<ActivityType> queryActivityTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的项目类型记录数*/
	public int queryActivityTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条项目类型记录*/
	public ActivityType getActivityType(int typeId) throws Exception;

	/*更新项目类型记录*/
	public void updateActivityType(ActivityType activityType) throws Exception;

	/*删除项目类型记录*/
	public void deleteActivityType(int typeId) throws Exception;

}
