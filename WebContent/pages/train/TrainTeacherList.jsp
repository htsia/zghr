<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addTeacher(){
             if (document.all("form1:superId").value==null || document.all("form1:superId").value==""){
                 alert("��ѡ�����!");
                 return false;
             }
             window.open("/train/TrainTeacherEdit.jsf?superId="+document.all("form1:superId").value, "", "height="+screen.height*0.6+", width="+screen.width*0.6+", top=100,left=200, toolbar=no, menubar=no, location=no, status=no");
             return true;
         }
        function modify(id){
            window.open("/train/TrainTeacherEdit.jsf?teacherID="+id, "", "height="+screen.height*0.6+", width="+screen.width*0.6+", top=100,left=200, toolbar=no, menubar=no, location=no, status=no");
            return true;
        }
        function browser(id){
            window.open("/train/teacherInforSet.jsf?teacherID="+id, "", "height="+screen.height*0.8+", width="+screen.width*0.6+", top=100,left=200, toolbar=no, menubar=no, location=no, status=no,resizable=yes,scrollbars=yes");
            return true;
        }
    </script>

<x:saveState value="#{train_teacherlistbb}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{train_teacherlistbb.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{train_teacherlistbb.superId}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{train_teacherlistbb.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{train_teacherlistbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{train_teacherlistbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{train_teacherlistbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{train_teacherlistbb.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{train_teacherlistbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_teacherlistbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_teacherlistbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{train_teacherlistbb.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����" onclick="return addTeacher();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>
          
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{train_teacherlistbb.teacherList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="��ʦ����"/></c:facet>
            <h:outputText value="#{list.teacherName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ʦ�Ա�"/></c:facet>
            <h:outputText value="#{list.teacherSex}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="ְ��"/></c:facet>
            <h:outputText value="#{list.teacherDegree}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�����γ�"/></c:facet>
            <h:outputText value="#{list.teacherDegree}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��ʦѧ��"/></c:facet>
            <h:outputText value="#{list.teacherDegree}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��ʦרҵ"/></c:facet>
            <h:outputText value="#{list.teacherMajor}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��ѵ��"/></c:facet>
            <h:outputText value="#{list.teacherColleage}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��ϵ�绰"/></c:facet>
            <h:outputText value="#{list.teacherTel}"/>
        </h:column>

       <h:column>
            <c:facet name="header"><h:outputText value="Email"/></c:facet>
            <h:outputText value="#{list.teacherEmail}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="������λ"/></c:facet>
            <h:outputText value="#{list.teacherWork}"/>
        </h:column>
         <h:column>
            <c:facet name="header"><h:outputText value="Ӧ�÷�Χ"/></c:facet>
            <h:outputText value="#{list.teacherOrg}"/>
        </h:column>
       	
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="Ԥ�����" onclick="return browser('#{list.teacherID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="�༭" onclick="return modify('#{list.teacherID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{train_teacherlistbb.delete}" styleClass="button01">
                  <x:updateActionListener property="#{train_teacherlistbb.teacherID}" value="#{list.teacherID}"/>
            </h:commandButton>
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
