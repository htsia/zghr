<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addOrg(){
             if (document.all("form1:superId").value==null || document.all("form1:superId").value==""){
                 alert("请选择机构!");
                 return false;
             }
             window.showModalDialog("/train/TrainOrgEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:315px; dialogHeight:415px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/train/TrainOrgEdit.jsf?orgID="+id, "", "dialogWidth:315px; dialogHeight:415px; status:0;resizable:yes");
            return true;
        }
    </script>

<x:saveState value="#{train_orglistbb}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{train_orglistbb.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{train_orglistbb.superId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{train_orglistbb.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            
            <h:panelGroup>
                <h:outputText value="记录数:#{train_orglistbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{train_orglistbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{train_orglistbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{train_orglistbb.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{train_orglistbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{train_orglistbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{train_orglistbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{train_orglistbb.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="增加" onclick="return addOrg();" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{train_orglistbb.orgList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" id="dateList">
        <h:column>
            <c:facet name="header"><h:outputText value="培训机构名称"/></c:facet>
            <h:outputText value="#{list.orgName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="联系人"/></c:facet>
            <h:outputText value="#{list.contactPerson}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="联系电话"/></c:facet>
            <h:outputText value="#{list.contactTel}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="联系地址"/></c:facet>
            <h:outputText value="#{list.contactAddress}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="传真"/></c:facet>
            <h:outputText value="#{list.fax}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="邮政编码"/></c:facet>
            <h:outputText value="#{list.postcode}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="网址"/></c:facet>
            <h:outputText value="#{list.website}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="eMail"/></c:facet>
            <h:outputText value="#{list.contactEMail}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="应用范围"/></c:facet>
            <h:outputText value="#{list.orgScope}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="操作"/></c:facet>
            <h:commandButton value="编辑" onclick="return modify('#{list.orgID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="删除" onclick="return confirm('确定要删除吗?');" action="#{train_orglistbb.delete}" styleClass="button01">
                  <x:updateActionListener property="#{train_orglistbb.orgID}" value="#{list.orgID}"/>
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
