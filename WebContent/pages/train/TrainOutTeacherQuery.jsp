<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function doOK() {
      	var str=" |";
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
                        if (i==0){
                            str+=chk[i].value;
                        }
                        else{
                            str+=","+chk[i].value;
                        }
                    }
                }
            }
           	window.returnValue=str;
            window.close();
        }
        else{
            alert("请选择要加入的人员!");
        }
    }
        
    </script>

<x:saveState value="#{trainClassOutterTeacherBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{trainClassOutterTeacherBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{trainClassOutterTeacherBB.superId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{trainClassOutterTeacherBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="记录数:#{trainClassOutterTeacherBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{trainClassOutterTeacherBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{trainClassOutterTeacherBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{trainClassOutterTeacherBB.mypage.currentPage}页"></h:outputText>
           		<h:commandButton value="首页" action="#{trainClassOutterTeacherBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{trainClassOutterTeacherBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{trainClassOutterTeacherBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{trainClassOutterTeacherBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="确定" onclick="doOK();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{trainClassOutterTeacherBB.teacherList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox"  name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.teacherID}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
                    </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="教师名称"/></c:facet>
            <h:outputText value="#{list.teacherName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="教师生日"/></c:facet>
            <h:outputText value="#{list.teacherBirthday}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="教师性别"/></c:facet>
            <h:outputText value="#{list.teacherSex}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="教师学历"/></c:facet>
            <h:outputText value="#{list.teacherDegree}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="教师专业"/></c:facet>
            <h:outputText value="#{list.teacherMajor}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="毕业院校"/></c:facet>
            <h:outputText value="#{list.teacherColleage}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="联系电话"/></c:facet>
            <h:outputText value="#{list.teacherTel}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="手机"/></c:facet>
            <h:outputText value="#{list.teacherMobile}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="Email"/></c:facet>
            <h:outputText value="#{list.teacherEmail}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="工作经历"/></c:facet>
            <h:outputText value="#{list.teacherWork}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="应用范围"/></c:facet>
            <h:outputText value="#{list.teacherOrg}"/>
        </h:column>
       	<h:column>
            <c:facet name="header"><h:outputText value="备注"/></c:facet>
            <h:outputText value="#{list.teacherMemo}"/>
        </h:column>
        
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
