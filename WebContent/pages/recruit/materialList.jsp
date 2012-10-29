<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function addMaterial(){
        window.showModalDialog("/recruit/materialEdit.jsf", "","dialogWidth:500px; dialogHeight:300px; status:0;resizable:yes");
        return true;
    }
   function modify(id){
       window.showModalDialog("/recruit/materialEdit.jsf?materiallID="+id, "", "dialogWidth:500px; dialogHeight:300px; status:0;resizable:yes");
       return true;
   }
   function viewAtt(id){
  	 window.open('/pages/recruit/download.jsp?attachmentId='+id, "", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=yes,width='+0.9*screen.width+',height='+0.9*screen.height+',left='+0.05*screen.width+', top='+0.05*screen.height);
  }
    </script>

<x:saveState value="#{recruit_materialBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{recruit_materialBB.initPage}"></h:inputHidden>
        <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{recruit_materialBB.userOrgname}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
           
            <h:panelGroup>
                <h:outputText value="��¼��:#{recruit_materialBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{recruit_materialBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{recruit_materialBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{recruit_materialBB.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{recruit_materialBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recruit_materialBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recruit_materialBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{recruit_materialBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>  
               <h:commandButton value="����" onclick="return addMaterial();" styleClass="button01"></h:commandButton>        
          </h:panelGrid>
    </h:panelGrid>
      <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{recruit_materialBB.materialList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="���Բ�������"/></c:facet>
            <h:outputText value="#{list.materiallName}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.description}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="��" rendered="#{list.isHaveAtt=='0'}"/>
            <h:commandLink value="����"  rendered="#{list.isHaveAtt=='1'}" onclick="viewAtt('#{list.planAtt}')">
   			</h:commandLink>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.createOrg}"/>
        </h:column>
        
		<h:column>
            <c:facet name="header"><h:outputText value="Ӧ�÷�Χ"/></c:facet>
            <h:outputText value="#{list.orgID}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�༭" styleClass="button01" onclick="return modify('#{list.materiallID}')"></h:commandButton>
            <h:commandButton value="ɾ��" styleClass="button01"  onclick="return confirm('ȷ��Ҫɾ����?');" action="#{recruit_materialBB.delete}">
                  <x:updateActionListener property="#{recruit_materialBB.materiallID}" value="#{list.materiallID}"/>
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
