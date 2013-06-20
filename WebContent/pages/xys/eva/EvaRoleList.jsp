<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
       function add() {
            window.showModalDialog("/xys/eva/EvaRoleEdit.jsf?superId=new", null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function modify(id) {
            window.showModalDialog("/xys/eva/EvaRoleEdit.jsf?roleId="+id, null, "dialogWidth:400px;dialogHeight:300px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function mgrPost(id){
            window.showModalDialog("/xys/eva/EvaRolePostList.jsf?roleId="+id, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function mgrSbj(id){
           window.showModalDialog("/xys/eva/EvaRoleSbjList.jsf?roleId="+id, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
      }
       function selTemplate2(id){
           document.all("form1:roleId").value=id;
           var returnValue= window.showModalDialog("/xys/eva/Sel360Template.jsf", null, "dialogWidth:"+screen.width*0.5+"px;dialogHeight:"+screen.height*0.4+"px;center:center;resizable:no;status:no;scroll:yes;");
           if(returnValue!=null){
              	document.all("form1:templateId").value=returnValue;
                return true;
           }else{
                return false;
           }
     }
    </script>

<x:saveState value="#{xys_evaRoleBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaRoleBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="roleId" value="#{xys_evaRoleBB.roleId}"></h:inputHidden>
    <h:inputHidden id="templateId" value="#{xys_evaRoleBB.templateId}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                  ��Ч���� ->��ɫ����
           </td>
        </tr>
    </table>
       <table height=100% width=100% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{xys_evaRoleBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{xys_evaRoleBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{xys_evaRoleBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{xys_evaRoleBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{xys_evaRoleBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaRoleBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaRoleBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{xys_evaRoleBB.last}" styleClass="button01"></h:commandButton>
                 <h:outputText value="  "></h:outputText>
                <h:commandButton value="����"  styleClass="button01" onclick="add()"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
      
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{xys_evaRoleBB.roleList}" var="list" align="center" id="dateList"  rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.roleName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.createOrg}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.createTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.createPid}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="ȱʡ360ģ��"/></c:facet>
            <h:outputText value="#{list.template360}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="KPIȨ��(%)"/></c:facet>
            <h:outputText value="#{list.weightKpi}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="360Ȩ��(%)"/></c:facet>
            <h:outputText value="#{list.weight360}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������(%)"/></c:facet>
            <h:outputText value="#{list.weightXspj}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�޸�" onclick="return modify('#{list.roleId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="ɾ��" action="#{xys_evaRoleBB.deleteRole}" onclick="return confirm('ȷ��Ҫɾ��ѡ�н�ɫ��');"
                   styleClass="button01">
                  <x:updateActionListener property="#{xys_evaRoleBB.roleId}" value="#{list.roleId}"/>
            </h:commandButton>
            <h:commandButton value="ѡ��360ģ��" action="#{xys_evaRoleBB.selTemplate}" styleClass="button01" 
            onclick="return selTemplate2('#{list.roleId}');" ></h:commandButton>
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
