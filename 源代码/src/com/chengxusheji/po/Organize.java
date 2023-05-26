package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Organize {
    /*组织id*/
    private Integer organizeId;
    public Integer getOrganizeId(){
        return organizeId;
    }
    public void setOrganizeId(Integer organizeId){
        this.organizeId = organizeId;
    }

    /*组织名称*/
    @NotEmpty(message="组织名称不能为空")
    private String organizeName;
    public String getOrganizeName() {
        return organizeName;
    }
    public void setOrganizeName(String organizeName) {
        this.organizeName = organizeName;
    }

    /*组织照片*/
    private String organizePhoto;
    public String getOrganizePhoto() {
        return organizePhoto;
    }
    public void setOrganizePhoto(String organizePhoto) {
        this.organizePhoto = organizePhoto;
    }

    /*成立日期*/
    @NotEmpty(message="成立日期不能为空")
    private String makeDate;
    public String getMakeDate() {
        return makeDate;
    }
    public void setMakeDate(String makeDate) {
        this.makeDate = makeDate;
    }

    /*联系负责人*/
    @NotEmpty(message="联系负责人不能为空")
    private String fuzheren;
    public String getFuzheren() {
        return fuzheren;
    }
    public void setFuzheren(String fuzheren) {
        this.fuzheren = fuzheren;
    }

    /*报名电话*/
    @NotEmpty(message="报名电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*组织介绍*/
    @NotEmpty(message="组织介绍不能为空")
    private String organizeDesc;
    public String getOrganizeDesc() {
        return organizeDesc;
    }
    public void setOrganizeDesc(String organizeDesc) {
        this.organizeDesc = organizeDesc;
    }

    /*已报名人员*/
    @NotEmpty(message="已报名人员不能为空")
    private String signUpNames;
    public String getSignUpNames() {
        return signUpNames;
    }
    public void setSignUpNames(String signUpNames) {
        this.signUpNames = signUpNames;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonOrganize=new JSONObject(); 
		jsonOrganize.accumulate("organizeId", this.getOrganizeId());
		jsonOrganize.accumulate("organizeName", this.getOrganizeName());
		jsonOrganize.accumulate("organizePhoto", this.getOrganizePhoto());
		jsonOrganize.accumulate("makeDate", this.getMakeDate().length()>19?this.getMakeDate().substring(0,19):this.getMakeDate());
		jsonOrganize.accumulate("fuzheren", this.getFuzheren());
		jsonOrganize.accumulate("telephone", this.getTelephone());
		jsonOrganize.accumulate("organizeDesc", this.getOrganizeDesc());
		jsonOrganize.accumulate("signUpNames", this.getSignUpNames());
		return jsonOrganize;
    }}