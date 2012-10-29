<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%  
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function forDataType(actType){
        var form = document.forms(0);
        form["formInfoItemEdit:itemDefaultValue"].dict_num="";
        form["formInfoItemEdit:itemDefaultValue"].dict="";
        form["formInfoItemEdit:helpButton"].disabled="true"

        var len=form["formInfoItemEdit:itemDataType"].options.length;
        var opt=form["formInfoItemEdit:itemDataType"].options;
        if(1==actType){
            form["formInfoItemEdit:itemDefaultValue"].value="";
        }

        if(opt(5).selected){  //代码型
            form["formInfoItemEdit:itemIsSelect"].disabled=false;
            form["formInfoItemEdit:itemCodeSet"].disabled=false;
            form["formInfoItemEdit:itemDataLength"].disabled=true;
            form["formInfoItemEdit:itemMax"].disabled=true;
            form["formInfoItemEdit:itemMin"].disabled=true;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemDefaultValue"].dict_num="";
            form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            form["formInfoItemEdit:helpButton"].disabled=false;
        }else if( opt(6).selected  //机构类型
                || opt(7).selected  //人员
                || opt(10).selected  //岗位
                || opt(11).selected  // 党组织
                || opt(12).selected){  //薪资机构
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=true;
            form["formInfoItemEdit:itemMax"].disabled=true;
            form["formInfoItemEdit:itemMin"].disabled=true;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:helpButton"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
            if(opt(6).selected) {    //机构
               form["formInfoItemEdit:itemDefaultValue"].dict_num="OU";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            }else if(opt(7).selected){ //人员
                form["formInfoItemEdit:itemDefaultValue"].dict_num="PE";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            }else if(opt(10).selected){  // 岗位
                form["formInfoItemEdit:itemDefaultValue"].dict_num="PO";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            }else if(opt(11).selected){  // 党组织
                form["formInfoItemEdit:itemDefaultValue"].dict_num="PA";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            }else if(opt(12).selected){  // 党组织
                form["formInfoItemEdit:itemDefaultValue"].dict_num="WA";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes" ;
            }
        }else  if(opt(9).selected){    //计算类型
           form["formInfoItemEdit:itemIsSelect"].disabled=true;
            form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=true;
            form["formInfoItemEdit:itemMax"].disabled=false;
            form["formInfoItemEdit:itemMin"].disabled=false;
            form["formInfoItemEdit:itemDefaultValue"].disabled=true;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
            //forsetdefault()
        }else if(opt(2).selected){      //字符
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=false;
            form["formInfoItemEdit:itemMax"].disabled=true;
            form["formInfoItemEdit:itemMin"].disabled=true;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
        }else if(opt(0).selected){ //整型
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            //form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=false;
            form["formInfoItemEdit:itemMax"].disabled=false;
            form["formInfoItemEdit:itemMin"].disabled=false;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
        }else if(opt(1).selected){  //小数
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            //form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=false;
            form["formInfoItemEdit:itemMax"].disabled=false;
            form["formInfoItemEdit:itemMin"].disabled=false;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=false;
        } else if(opt(3).selected || opt(4).selected){  // 日期
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=true;
            form["formInfoItemEdit:itemMax"].disabled=true;
            form["formInfoItemEdit:itemMin"].disabled=true;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
        }
        showTitle();
    }

    function   forCodeSelect(){
        var form = document.forms(0);
        var opt=form["formInfoItemEdit:itemCodeSet"].options;
        len = opt.length;
        for(i=0;i<len;i++){
           if(opt(i).selected){
              form["formInfoItemEdit:itemDefaultValue"].dict_num=opt(i).value;
              break;
           }
        }
    }

    function forPopupDlg(objName){
     var form = document.forms(0);
     var obj = form[objName];
     var dict_num = obj.dict_num;
     if(dict_num == "" || dict_num==null) {
         obj.dict_num=document.all('formInfoItemEdit:itemCodeSet').value;
         dict_num = obj.dict_num;
         if(dict_num == "" || dict_num==null) return;
     }
     if(dict_num=="OU"){
         PopUpOrgDlg(objName,"1");
     }else if(dict_num=="PE"){
         fPopUpPerDlg(objName);
     }else if(dict_num=="PO"){
        fPopUpPostDlg(objName);
     }else if(dict_num=="PA"){
        fPopUpPartyDlg(objName,"1");
     }else if(dict_num=="WA"){
        fPopUpWageUnitDlg(objName,true);
     }else{
         PopUpCodeDlgOneControl(objName);
     }
    }
    function showTitle(){
         if (document.all('formInfoItemEdit:itemDataType').value=='14'){
             document.all('max').innerText="<%=LanguageSupport.getResource("XTGL-1400","高")%>";
             document.all('min').innerText="<%=LanguageSupport.getResource("XTGL-1401","宽")%>";
         }
         else{
             document.all('max').innerText="<%=LanguageSupport.getResource("XTGL-1195","最大值")%>";
             document.all('min').innerText="<%=LanguageSupport.getResource("XTGL-1194","最小值")%>";
         }
    }
</script>
<x:saveState value="#{sys_infoItemEditBB}"></x:saveState>
<h:form id="formInfoItemEdit">
<h:inputHidden id="pageInit" value="#{sys_infoItemEditBB.pageInit}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.setId}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.itemId}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.itemSelf}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.editStatus}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.set_sType}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.itemMust}"></h:inputHidden>
<h:inputHidden id="showcode" />
<h:inputHidden id="showvalue" />

<h:panelGrid columns="1" width="740" cellpadding="0" align="left"     cellspacing="0" border="0" >
    <h:outputText escape="false" value="<font color='blue'><strong>基本情况：</strong></font>"></h:outputText>
    <h:panelGrid  columns="4"
                width="97%"
                cellpadding="0" border="1" align="left"
                styleClass="table03"
                columnClasses="td_form01,td_form02,td_form01,td_form02">
     <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1136","指标集名称")%>
    </f:verbatim>
    <h:inputText value="#{sys_infoItemEditBB.setName}" alt="指标集名称|1|s|50" styleClass="input"/>
    <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1190","指标项名称")%>
    </f:verbatim>
    <h:inputText value="#{sys_infoItemEditBB.itemName}" alt="指标项名称|0|s|50" styleClass="input"/>

    <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1015","描述")%>
    </f:verbatim>
    <h:inputText value="#{sys_infoItemEditBB.itemDesc}" alt="描述|1|s|100" styleClass="input"/>
    <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1199","数据类型")%>
    </f:verbatim>
    <h:selectOneMenu id="itemDataType" value="#{sys_infoItemEditBB.itemDataType}" onchange="forDataType(1)">
        <f:selectItem itemValue="1" itemLabel="整型"/>
        <f:selectItem itemValue="2" itemLabel="小数"/>
        <f:selectItem itemValue="3" itemLabel="字符"/>
        <f:selectItem itemValue="5" itemLabel="8位日期"/>
        <f:selectItem itemValue="15" itemLabel="6位日期"/>
        <f:selectItem itemValue="6" itemLabel="代码"/>
        <f:selectItem itemValue="7" itemLabel="机构"/>
        <f:selectItem itemValue="8" itemLabel="人员"/>
        <f:selectItem itemValue="4" itemLabel="备注"/>
        <f:selectItem itemValue="9" itemLabel="计算"/>
        <f:selectItem itemValue="11" itemLabel="岗位"/>
        <f:selectItem itemValue="12" itemLabel="党组织"/>
        <f:selectItem itemValue="13" itemLabel="薪资机构"/>
        <f:selectItem itemValue="23" itemLabel="薪资部门"/>
        <f:selectItem itemValue="14" itemLabel="图片"/>
    </h:selectOneMenu>

    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1180","代码集")%>
    </f:verbatim>
    <h:panelGroup>
        <h:selectOneMenu id="itemCodeSet" value="#{sys_infoItemEditBB.itemCodeSet}" onchange="forCodeSelect()">
            <f:selectItems value="#{sys_infoItemEditBB.codeSetList}"/>
        </h:selectOneMenu>
        <h:commandButton value="显示代码树"  type="button" onclick="PopUpCodeDlgTwoControl(document.all('formInfoItemEdit:showcode'),document.all('formInfoItemEdit:showvalue'),document.all('formInfoItemEdit:itemCodeSet').value)" styleClass="button01" />
    </h:panelGroup>

     <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1197","数据长度")%>
    </f:verbatim>
    <h:inputText id="itemDataLength"   alt="数据长度|1|i|20"  value="#{sys_infoItemEditBB.itemDataLength}" styleClass="input"/>

   <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1198"," 下拉框显示")%>
    </f:verbatim>
    <h:selectOneMenu id="itemIsSelect" value="#{sys_infoItemEditBB.itemIsSelect}">
        <f:selectItem itemValue="0" itemLabel="否"/>
        <f:selectItem itemValue="1" itemLabel="是"/>
    </h:selectOneMenu>
    
    <f:verbatim>
         <%=LanguageSupport.getResource("XTGL-1196","小数位数")%>
    </f:verbatim>
    <h:inputText id="itemPrecision" alt="数据长度|1|i|10" value="#{sys_infoItemEditBB.itemPrecision}" styleClass="input"/>


     <f:verbatim>
            <span id="max"></span>
    </f:verbatim>
    <h:inputText id="itemMax" alt="最大值|1|f|20" value="#{sys_infoItemEditBB.itemMax}" styleClass="input"/>
     <f:verbatim>
            <span id="min"></span>
    </f:verbatim>
    <h:inputText id="itemMin" alt="最小值|1|f|20" value="#{sys_infoItemEditBB.itemMin}" styleClass="input"/>


    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1005","显示顺序")%>
    </f:verbatim>
    <h:inputText  alt="显示顺序|1|i|20" value="#{sys_infoItemEditBB.itemSequence}" styleClass="input"/>
    
    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1200","是否必填项")%>
    </f:verbatim>
    <h:selectOneRadio value="#{sys_infoItemEditBB.itemNotNull}">
        <f:selectItem itemValue="0" itemLabel="否"/>
        <f:selectItem itemValue="1" itemLabel="是"/>
    </h:selectOneRadio>

   <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1201","指标属性")%>
    </f:verbatim>
    <h:selectOneMenu value="#{sys_infoItemEditBB.itemProperty}">
        <f:selectItem itemValue="4" itemLabel="可编辑"/>
        <f:selectItem itemValue="2" itemLabel="只读"/>
    </h:selectOneMenu>

    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1193","缺省值")%>
    </f:verbatim>
    <h:panelGroup>
        <h:inputText   alt="缺省值|1|s|20" code="" dict="" dict_num=""  id="itemDefaultValue" value="#{sys_infoItemEditBB.itemDefaultValue}" styleClass="input"/>
        <h:commandButton id="helpButton" type="button" styleClass="button_select" onclick="forPopupDlg('formInfoItemEdit:itemDefaultValue')"/>
    </h:panelGroup>

    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1006","启用/禁用")%>
    </f:verbatim>
    <h:selectOneRadio value="#{sys_infoItemEditBB.itemStatus}" disabled="#{sys_infoItemEditBB.itemMust=='1'}">
        <f:selectItem itemValue="1" itemLabel="启用"/>
        <f:selectItem itemValue="0" itemLabel="禁用"/>
    </h:selectOneRadio>


    <h:outputText value="代码分机构"></h:outputText>
    <h:selectOneRadio value="#{sys_infoItemEditBB.codeByOrg}">
        <c:selectItem itemValue="1" itemLabel="是"></c:selectItem>
        <c:selectItem itemValue="0" itemLabel="否"></c:selectItem>
    </h:selectOneRadio>

     <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1192","允许挂接帐套里")%>
    </f:verbatim>
    <h:selectOneRadio id="canInWage" value="#{sys_infoItemEditBB.modiInWage}">
        <f:selectItem itemValue="0" itemLabel="不可以"/>
        <f:selectItem itemValue="1" itemLabel="可以"/>
    </h:selectOneRadio>

    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1138","是否允许导入")%>
    </f:verbatim>
    <h:selectOneRadio id="canImport" value="#{sys_infoItemEditBB.canInport}">
        <f:selectItem itemValue="0" itemLabel="不可以"/>
        <f:selectItem itemValue="1" itemLabel="可以"/>
    </h:selectOneRadio>
</h:panelGrid>
    <h:panelGrid columns="2"
                 width="97%"
                 cellpadding="0" border="1" align="left"
                 styleClass="table03"
              columnClasses="td_form01,td_form02">
        <f:verbatim>
                <%=LanguageSupport.getResource("XTGL-1191","项目用途")%>
        </f:verbatim>
        <h:inputTextarea id="itemIssue" value="#{sys_infoItemEditBB.itemIssue}" styleClass="input" cols="85" rows="3"/>
    </h:panelGrid>

    <h:outputText escape="false" value="<br><font color='blue'><strong>对应JY/T 1006—2012标准情况：</strong></font>"></h:outputText>
    <h:panelGrid  columns="4"
                width="97%"
                cellpadding="0" border="1" align="left"
                styleClass="table03"
                columnClasses="td_form01,td_form02,td_form01,td_form02">
                       <%=LanguageSupport.getResource("XTGL-1136","指标集名称")%>
        <h:outputText value="编号"></h:outputText>
        <h:inputText value="#{sys_infoItemEditBB.jy1006bh}" alt="编号|1|s|50" styleClass="input"/>

        <h:outputText value="数据项名"></h:outputText>
        <h:inputText value="#{sys_infoItemEditBB.jy1006name}" alt="数据项名|1|s|50" styleClass="input"/>
    </h:panelGrid>

    <h:outputText escape="false" value="<br><font color='blue'><strong>对应GB/T14946-2009标准情况：</strong></font>"></h:outputText>
    <h:panelGrid  columns="2"
                width="97%"
                cellpadding="0" border="1" align="left"
                styleClass="table03"
                columnClasses="td_form01,td_form02,td_form01,td_form02">
                       <%=LanguageSupport.getResource("XTGL-1136","指标集名称")%>
        <h:outputText value="编号"></h:outputText>
        <h:inputText value="#{sys_infoItemEditBB.gb14946}" alt="编号|1|s|50" styleClass="input"/>

    </h:panelGrid>

<f:verbatim>
    <br>
</f:verbatim>

<h:panelGrid columns="2" width="20%" cellpadding="0"
                align="right" border="0">
    <h:commandButton value="保 存" onclick="return forsubmit(document.forms(0))"
                     action="#{sys_infoItemEditBB.saveInfoItem}" styleClass="button01">
        <x:updateActionListener property="#{sys_infoItemListBB.setId}" value="#{sys_infoItemEditBB.setId}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.set_sType}" value="#{sys_infoItemEditBB.set_sType}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.setName}" value="#{sys_infoItemEditBB.setName}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.showOnlyOpen}" value="#{sys_infoItemEditBB.showOnlyOpen}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.showOnlyUser}" value="#{sys_infoItemEditBB.showOnlyUser}"/>
    </h:commandButton>
    <h:commandButton value="返 回" action="itemlist" styleClass="button01">
        <x:updateActionListener property="#{sys_infoItemListBB.setId}" value="#{sys_infoItemEditBB.setId}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.set_sType}" value="#{sys_infoItemEditBB.set_sType}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.setName}" value="#{sys_infoItemEditBB.setName}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.showOnlyOpen}" value="#{sys_infoItemEditBB.showOnlyOpen}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.showOnlyUser}" value="#{sys_infoItemEditBB.showOnlyUser}"/>
    </h:commandButton>
</h:panelGrid>
</h:panelGrid>
<script type="text/javascript">
	forDataType(2);
	interpret(document.forms(0));
</script>
</h:form>
