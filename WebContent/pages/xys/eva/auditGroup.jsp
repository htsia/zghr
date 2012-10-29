<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
       function add() {
            window.showModalDialog("/xys/eva/auditGroupEdit.jsf?superId=new", null, "dialogWidth:400px;dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function modify(id) {
            window.showModalDialog("/xys/eva/auditGroupEdit.jsf?groupId="+id, null, "dialogWidth:400px;dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function mgrPost(id){
            window.showModalDialog("/xys/eva/auditGroupPost.jsf?groupId="+id, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
      
    </script>

<x:saveState value="#{xys_evaGroupMgrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaGroupMgrBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                  ��Ч���� ->������ά��
           </td>
        </tr>
    </table>
       <table height=100% width=100% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��¼��:#{xys_evaGroupMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{xys_evaGroupMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{xys_evaGroupMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{xys_evaGroupMgrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{xys_evaGroupMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaGroupMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaGroupMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{xys_evaGroupMgrBB.last}" styleClass="button01"></h:commandButton>
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
    <x:dataTable value="#{xys_evaGroupMgrBB.groupList}" var="list" align="center" id="dateList"  rowIndexVar="index"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.groupName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.createOrg}"/>
        </h:column>
      
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�޸�" onclick="return modify('#{list.groupId}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="ɾ��" action="#{xys_evaGroupMgrBB.delete}" onclick="return confirm('ȷ��Ҫɾ��ѡ����������');"
                   styleClass="button01">
                  <x:updateActionListener property="#{xys_evaGroupMgrBB.groupId}" value="#{list.groupId}"/>
            </h:commandButton>
            <h:commandButton value="��λά��" onclick="mgrPost('#{list.groupId}')" styleClass="button01"></h:commandButton>
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
