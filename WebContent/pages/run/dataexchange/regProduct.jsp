<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function add() {
    window.showModalDialog("/run/dataexchange/productEdit.jsf?new=true", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function modify(id){
	window.showModalDialog("/run/dataexchange/productEdit.jsf?proId="+id, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
</script>

<x:saveState value="#{regProductMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{regProductMgrBB.pageInit}"/>
    <h:inputHidden id="personStr" value=""/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <h:outputText value=" ���ݽ���ƽ̨ -> ��Ʒ�Ǽ�"/>
     <f:verbatim>
               </td>
               <td align="right" class=td_title >
               </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8>
        <table width="95%"  >
            <tr><td align="right">       
            </td>
            <td align="right">
</f:verbatim>
				<h:panelGroup>
                <h:outputText value="��¼��:#{regProductMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{regProductMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{regProductMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{regProductMgrBB.mypage.currentPage}ҳ"></h:outputText>
	            <h:commandButton value="��ҳ" action="#{regProductMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{regProductMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{regProductMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{regProductMgrBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����"  styleClass="button01" onclick="return add()"/>
            </h:panelGroup>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <x:dataTable value="#{regProductMgrBB.productList}" var="list" align="center"  id="dateList" rowIndexVar="index"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            
            <h:column>
                <c:facet name="header"><h:outputText value="���"/></c:facet>
                <h:outputText value="#{index+1}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="��Ʒ���"/></c:facet>
                <h:outputText value="#{list.proId}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="��Ʒ����"/></c:facet>
                <h:outputText value="#{list.proName}"/>
            </h:column>

			<h:column>
                <c:facet name="header"><h:outputText value="��Ʒ����"/></c:facet>
                <h:outputText value="#{list.typeDes}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="֪ͨ��������Ϣ"/></c:facet>
                <h:outputText value="#{list.sendMsg}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="SQLģʽԴϵͳ"/></c:facet>
                <h:outputText value="#{list.sqlSource}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:commandButton value="�޸�" styleClass="button01" onclick="return modify('#{list.proId}');"/>
                <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{regProductMgrBB.delete}" styleClass="button01">
                  <x:updateActionListener property="#{regProductMgrBB.proId}" value="#{list.proId}"/>
            	</h:commandButton>
            </h:column>
        </x:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>