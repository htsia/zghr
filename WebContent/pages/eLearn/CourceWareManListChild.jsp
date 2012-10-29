<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    function doAddCource(){
        var superID=document.all('form1:superID').value;
        if (superID==null || superID==""){
            alert("请先选择类别！");
            return false;
        }
        window.showModalDialog("/eLearn/FileEdit.jsf?superID="+superID, null, "dialogWidth:500px; dialogHeight:240px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function showCource(id){
        window.showModalDialog("/eLearn/ShowCourse.jsf?courseID="+id, null, "dialogWidth:500px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eLearn_courcebb}"/>
<h:form id="form1">
      <h:inputHidden value="#{eLearn_courcebb.pageInit}"></h:inputHidden>
      <h:inputHidden id="superID" value="#{eLearn_courcebb.superID}"></h:inputHidden>
      <h:panelGrid width="98%" columns="1" align="center">
		  <h:panelGrid columns="1" align="right">
                 <h:commandButton value="增加" styleClass="button01" onclick="doAddCource();"></h:commandButton>
          </h:panelGrid>

          <x:dataTable value="#{eLearn_courcebb.manCourceList}"   id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="序号" />
                  </f:facet>
                  <h:outputText value="#{index+1}" ></h:outputText>
              </h:column>

				<h:column>
					<f:facet name="header">
						<h:outputText value="标题" />
					</f:facet>
                    <h:outputText value="#{briefList.courseName}" ></h:outputText>
                </h:column>

              <h:column>
                  <f:facet name="header">
                      <h:outputText value="单元数" />
                  </f:facet>
                  <h:outputText value="#{briefList.unitCount}" ></h:outputText>
              </h:column>

                <h:column>
                    <f:facet name="header">
                        <h:outputText value="操作" />
                    </f:facet>
                    <h:commandButton type="button" styleClass="button01" value="预览目录" onclick="showCource('#{briefList.courseID}');"></h:commandButton>
                    <h:commandButton action="#{eLearn_courcebb.deleteCourseFromDB}" styleClass="button01" value="删除" onclick="return Confirm('确定删除吗？');">
                        <x:updateActionListener property="#{eLearn_courcebb.courseID}" value="#{briefList.courseID}"/>
                    </h:commandButton>
                </h:column>
			</x:dataTable>
		</h:panelGrid>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>

