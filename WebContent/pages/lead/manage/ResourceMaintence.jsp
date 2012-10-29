<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
    function forAdd() {
        window.showModalDialog("/lead/LeadResourceEdit.jsf", null, "dialogWidth:430px; dialogHeight:250px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forModify(ID) {
        var v=window.showModalDialog("/lead/LeadResourceEdit.jsf?ID="+ID, null, "dialogWidth:430px; dialogHeight:250px;center:center;resizable:no;status:no;scroll:no;");
        return true;
    }
    function forModifyContent(Style,ID) {
        if (Style=="文本条"){
           window.showModalDialog("/lead/TextResMaintence.jsf?res_id="+ID, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;");
        }
        else if (Style=="表格"){
           window.showModalDialog("/lead/GridResMaintence.jsf?res_id="+ID, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;");
        }
        else if (Style=="图表"){
           window.showModalDialog("/lead/ChartResMaintence.jsf?res_id="+ID, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;");
        }
        return true;
    }
    function toconfirm(){
          if (confirm(' 确定要删除吗 ?'))
             return true;
          else
             return false;
        }
</script>

  <x:saveState id="resmaintenanceBackingBean" value="#{resmaintenanceBackingBean}"/>
  <h:form id="formtimem">
    <h:inputHidden value="#{resmaintenanceBackingBean.pageInit}"  />
	<h:panelGrid width="98%" align="center" border="0"  cellpadding="2" cellspacing="0" columns="2" styleClass="td_title">
        <h:panelGroup>
         <h:graphicImage value="/images/tips.gif" />
         <h:outputText value=" 分析模型管理"/>
        </h:panelGroup>

	   <h:panelGrid align="right" columns="4">
           <h:commandButton id="id_add" value="增加" styleClass="button01"    onclick="forAdd()"  />
           <h:outputText value="    " />

           <h:commandButton id="id_dele" value="删除" styleClass="button01" onclick="return toconfirm();"   action="#{resmaintenanceBackingBean.deleTypeList}"  />
           <h:outputText value="    " />
	  </h:panelGrid>
	</h:panelGrid>

      <c:verbatim><br></c:verbatim>   
    <h:dataTable value="#{resmaintenanceBackingBean.showtypevolist}"
            headerClass="td_top" styleClass="table03"  id="dateList"
            var="timelist" width="95%"
			columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center" align="center">
			<h:column>
				<f:facet name="header">
					<h:outputText value="模型代码" style="width:90px"/>
				</f:facet>
               <h:outputText id="showcode"  value="#{timelist.showCode}" style="width:90px;border:0px"/>
			</h:column>
			
			<h:column>
				<f:facet name="header">
					<h:outputText value="模型名称" style="width:120px"/>
				</f:facet>
				<h:outputText id="showname"  value="#{timelist.showName}" style="width:120px;border:0px"/>
			</h:column>
			
			<h:column  >
				<f:facet name="header">
					<h:outputText value="模型类型" style="width:80px" />
				</f:facet>
                <h:outputText id="storeTable"  value="#{timelist.storeTable}" style="width:120px;border:0px"/>
			</h:column>

			<h:column  >
				<f:facet name="header">
					<h:outputText value="更新频度" style="width:80px" />
				</f:facet>
                <h:outputText id="updateFrequency"  value="#{timelist.updateFrequency}" style="width:120px;border:0px"/>
			</h:column>

        <h:column >
            <f:facet name="header">
                <h:outputText value="状态" style="width:80px" />
            </f:facet>
            <h:outputText id="status"  value="#{timelist.isuse}" style="width:120px;border:0px"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="修改属性" styleClass="button01"  
                                  onclick="return forModify('#{timelist.resId}');"/>
                <h:commandButton value="修改定义" styleClass="button01" 
                                  onclick="return forModifyContent('#{timelist.storeTable}','#{timelist.resId}');"/>
                <h:commandButton value="删除" styleClass="button01" onclick="return confirm('确定要删除吗?');" action="#{resmaintenanceBackingBean.deleTypeList}">
                    <x:updateActionListener property="#{resmaintenanceBackingBean.resID}" value="#{timelist.resId}"/>
                </h:commandButton>
            </h:panelGrid>
        </h:column>

        </h:dataTable>
	</h:form>
<script type="text/javascript">
   setDataTableOver("formtimem:dateList");
</script>

