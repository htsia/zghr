<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddLaw(){
        var superID=document.all('form1:superID').value;
        if (superID==null || superID==""){
            alert("请先选择类别！");
            return false;
        }
        window.showModalDialog("/rule/LawFileEdit.jsf?superID="+superID, null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
    function doModifyLaw(lawid){
        window.showModalDialog("/rule/LawFileEdit.jsf?fileID="+lawid, null, "dialogWidth:"+screen.width*0.75+"px; dialogHeight:"+screen.height*0.75+"px;center:center;resizable:yes;status:no;scroll:yes;");
        return false;
    }
</script>

<x:saveState value="#{law_browbb}"/>
<h:form id="form1">
      <h:inputHidden value="#{law_browbb.pageInit}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{law_browbb.superID}"></h:inputHidden>
    <c:verbatim>
    <table height=98% width=98% align="center">
          <tr><td height=8>
     </c:verbatim>
          <h:panelGrid columns="1" align="right">
                 <h:commandButton styleClass="button01" value="增加"  onclick="doAddLaw();"></h:commandButton>
          </h:panelGrid>
<c:verbatim>
          </td></tr>

          <tr><td >
          <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
            <x:dataTable value="#{law_browbb.lawlist}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_left,td_middle,td_middle_center,td_middle_center">

				<h:column>
					<f:facet name="header">
						<h:outputText value="标题" />
					</f:facet>
                    <h:outputText value="#{briefList.title}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="发布时间" />
                    </f:facet>
                    <h:outputText value="#{briefList.publicDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="生效时间" />
                    </f:facet>
                    <h:outputText value="#{briefList.actDate}" ></h:outputText>
                </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="失效时间" />
                    </f:facet>
                    <h:outputText value="#{briefList.invalidDate}" ></h:outputText>
                </h:column>


                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
   					<h:commandButton styleClass="button01" action="#{law_editbb.DeleteFile}" rendered="#{briefList.havePower}" value="删除" onclick="return confirm('确定要删除吗?')" >
                       <x:updateActionListener property="#{law_editbb.fileID}" value="#{briefList.fileID}"/>
                    </h:commandButton>
                    <h:commandButton styleClass="button01" value="修改" type="button" rendered="#{briefList.havePower}" onclick="return doModifyLaw('#{briefList.fileID}');" />
                    <h:commandButton styleClass="button01" value="查看" type="button" rendered="#{!briefList.havePower}" onclick="return doShowLaw('#{briefList.fileID}');" />
                </h:column>
			</x:dataTable>
<c:verbatim>
          </div>
          </td></tr>
		</table>
</c:verbatim>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

