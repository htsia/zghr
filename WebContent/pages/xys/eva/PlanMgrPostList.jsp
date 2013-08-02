<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
//考核岗位设置，岗位列表页面
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function evaModeSet(postId) {
        window.showModalDialog("/xys/eva/ModeSetEdit.jsf?planId=" + document.all("form1:planId").value + "&postId=" + postId, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
        return true;
    }
    function evaKpiSet(postId) {
        window.showModalDialog("/xys/eva/PlanPostLevelWeight.jsf?type=1&planId=" + document.all("form1:planId").value + "&postId=" + postId, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
        return false;
    }
    function eva360Set(postId) {
        window.showModalDialog("/xys/eva/PlanPostLevelWeight.jsf?type=2&planId=" + document.all("form1:planId").value + "&postId=" + postId, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
        return false;
    }
    function setKpiWeight(postId) {
        window.showModalDialog("/xys/eva/PlanWeightList.jsf?type=1&postId=" + postId+"&planId="+document.all("form1:planId").value, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
        return false;
    }

    function set360Weight(postId) {
        window.showModalDialog("/xys/eva/PlanWeightList.jsf?type=2&postId=" + postId+"&planId="+document.all("form1:planId").value, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function selectPost(){
    	var str="";
        chk=document.forms(0).selectItem;
        if (checkMutilSelect(chk)){
            var size = chk.length;
            if (size == null) {
                if (chk.checked) {
                    str+=chk.value;
                }
            } else {
                for (var i = 0; i < size; i++) {
                    if (chk[i].checked) {
                        if (str==""){
                            str+=chk[i].value;
                        }
                        else{
                            str+=","+chk[i].value;
                        }
                    }
                }
            }
           if(str != null && str!=""){
          	 document.all("form1:postIds").value =str;
          	 return true;
           }else{
        	  return false;
           }
           
        }else{
        	return false;
        }
        
    }
    function showProcessBar() {
   	    x = document.body.clientWidth / 2 - 150;
   	    y = document.body.clientHeight / 2;
   	    document.all('processbar').style.top = y;
   	    document.all('processbar').style.left = x;
   	    document.all('processbar').style.display = "";
   	 }
    
    function evaKpiSetBatch() {
    	var str="";
        chk=document.forms(0).selectItem;
        if (checkMutilSelect(chk)){
            var size = chk.length;
            if (size == null) {
                if (chk.checked) {
                    str+=chk.value;
                }
            } else {
                for (var i = 0; i < size; i++) {
                    if (chk[i].checked) {
                        if (str==""){
                            str+=chk[i].value;
                        }
                        else{
                            str+=","+chk[i].value;
                        }
                    }
                }
            }
           if(str != null && str!=""){
        	 window.showModalDialog("/xys/eva/PlanPostLevelWeightBatch.jsf?type=1&planId=" + document.all("form1:planId").value + "&postIds=" + str, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
          	 return true;
           }else{
        	  return false;
           }
        }else{
        	return false;
        }
    }
    function eva360SetBatch() {
    	var str="";
        chk=document.forms(0).selectItem;
        if (checkMutilSelect(chk)){
            var size = chk.length;
            if (size == null) {
                if (chk.checked) {
                    str+=chk.value;
                }
            } else {
                for (var i = 0; i < size; i++) {
                    if (chk[i].checked) {
                        if (str==""){
                            str+=chk[i].value;
                        }
                        else{
                            str+=","+chk[i].value;
                        }
                    }
                }
            }
           if(str != null && str!=""){
        	   window.showModalDialog("/xys/eva/PlanPostLevelWeightBatch.jsf?type=2&planId=" + document.all("form1:planId").value + "&postIds=" +str, null, "dialogWidth:600px;dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
               return true;
           }else{
        	  return false;
           }
        }else{
        	return false;
        }
    }
</script>
<x:saveState value="#{xys_PlanPostMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_PlanPostMgrBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{xys_PlanPostMgrBB.superId}"></h:inputHidden>
    <h:inputHidden id="planId" value="#{xys_PlanPostMgrBB.planId}"></h:inputHidden>
    <h:inputHidden id="postIds" value="#{xys_PlanPostMgrBB.postIds}"></h:inputHidden>
    <c:verbatim>
        <table height=98% width=98% align="center">
        <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
        <h:panelGrid align="left">
            <h:panelGroup>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="记录数:#{xys_PlanPostMgrBB.mypage.totalRecord}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="页数:#{xys_PlanPostMgrBB.mypage.totalPage}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="每页有#{xys_PlanPostMgrBB.mypage.pageSize}"></h:outputText>
                <h:outputText value="  "></h:outputText>
                <h:outputText value="当前为第#{xys_PlanPostMgrBB.mypage.currentPage}页"></h:outputText>
                <h:commandButton value="首页" action="#{xys_PlanPostMgrBB.first}" styleClass="button01"></h:commandButton>
                <h:commandButton value="上页" action="#{xys_PlanPostMgrBB.pre}" styleClass="button01"></h:commandButton>
                <h:commandButton value="下页" action="#{xys_PlanPostMgrBB.next}" styleClass="button01"></h:commandButton>
                <h:commandButton value="尾页" action="#{xys_PlanPostMgrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

        <h:panelGrid align="right" columns="2">
            <h:panelGroup>
                <h:commandButton value="加载考核关系 " action="#{xys_PlanPostMgrBB.loadEvaRel2}" styleClass="button01" onclick="showProcessBar();"></h:commandButton>
            	<h:commandButton value="排除岗位" action="#{xys_PlanPostMgrBB.excPost}" styleClass="button01" rendered="#{xys_PlanPostMgrBB.showMode=='1'}" onclick="return selectPost();"></h:commandButton>
            	<h:commandButton value="恢复岗位" action="#{xys_PlanPostMgrBB.evaPost}" styleClass="button01" rendered="#{xys_PlanPostMgrBB.showMode=='2'}" onclick="return selectPost();"></h:commandButton>
            	<h:commandButton value="KPI权重设置"  styleClass="button01" rendered="#{xys_PlanPostMgrBB.showMode=='1'}" onclick="return evaKpiSetBatch();"></h:commandButton>
            	<h:commandButton value="360权重设置"  styleClass="button01" rendered="#{xys_PlanPostMgrBB.showMode=='1'}" onclick="return eva360SetBatch();"></h:commandButton>
            </h:panelGroup>
        </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
        </td></tr>
        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
    <x:dataTable value="#{xys_PlanPostMgrBB.postList}" var="list" align="center" id="dateList" rowIndexVar="index"
                 headerClass="td_top"
                 columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="100%">
        <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.postId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
                </h:column>
        <x:column width="50px">
            <c:facet name="header"><h:outputText value="序号"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </x:column>
        <h:column>
            <c:facet name="header"><h:outputText value="岗位名称"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="所属部门"/></c:facet>
            <h:outputText value="#{list.deptName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="岗位类别"/></c:facet>
            <h:outputText value="#{list.postClass}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="模型权重"/></c:facet>
            <h:outputText value="#{list.weightDes}" escape="false"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="设置完成"/></c:facet>
            <h:outputText value="#{list.error}" escape="false"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="3">
	            <h:commandButton value="模型权重调整" onclick="return evaModeSet('#{list.postId}')" styleClass="button01"
	                             rendered="#{xys_PlanPostMgrBB.showMode=='1'}"></h:commandButton>
	            <h:commandButton value="KPI权重设置" onclick="return evaKpiSet('#{list.postId}')" styleClass="button01"
	                             rendered="#{xys_PlanPostMgrBB.showMode=='1'}"></h:commandButton>
	            <h:commandButton value="360权重设置" onclick="return eva360Set('#{list.postId}')" styleClass="button01"
	                             rendered="#{xys_PlanPostMgrBB.showMode=='1'}"></h:commandButton>
	         </h:panelGrid> 
	         <h:panelGrid columns="2">                   
	            <h:commandButton value="KPI考核关系调整" onclick="return setKpiWeight('#{list.postId}')" styleClass="button01"
	                             rendered="#{xys_PlanPostMgrBB.showMode=='1'}"></h:commandButton>
	            <h:commandButton value="360考核关系调整" onclick="return set360Weight('#{list.postId}')" styleClass="button01"
	                             rendered="#{xys_PlanPostMgrBB.showMode=='1'}"></h:commandButton>
            </h:panelGrid>
        </h:column>
    </x:dataTable>
    <c:verbatim>
        </div>
        </td></tr>
        </table>
        <marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>
    </c:verbatim>

</h:form>
<script type="text/javascript">
    setDataTableOver("form1:dateList");
</script>
