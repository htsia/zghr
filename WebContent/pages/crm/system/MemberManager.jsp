<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<x:saveState value="#{groupBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{groupBB.memberInit}"></h:inputHidden>
<f:verbatim>
<table width="98%" border="0" align="center">
  <tr>
    <td align="right">
</f:verbatim> 
  <h:panelGroup>
            <f:verbatim>&nbsp;</f:verbatim>
            <h:commandButton value="ѡ����Ա"  onclick="return fPopUpBackPerTreeDlg('');"  styleClass="button01"></h:commandButton>
        </h:panelGroup>
<f:verbatim>  

    </td>
  </tr>
  <tr>
    <td>
 </f:verbatim>    
  <x:dataTable value="#{groupBB.groupList}" id="dateList"
					headerClass="td_top" rowIndexVar="index" var="list"
					styleClass="table03" border="1" width="100%" align="center"
					columnClasses="td_middle_center">

 <h:column>
            <f:facet name="header">
                <f:verbatim escape="false"> <input type="checkbox" name="all"  onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"
                </f:verbatim>

            </f:facet>
            <f:verbatim escape="false">
             <div align="center">
              <input type="checkbox" name="selectItem" value="</f:verbatim>
            <h:outputText value="#{list.person_id}"/>
            <f:verbatim escape="false">"/></div></f:verbatim>
        </h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:outputText value="#{list.person_name }" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ա�" />
						</c:facet>
						<h:outputText value="#{list.sex}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="��ϵ�绰" />
						</c:facet>
						<h:outputText value="#{list.mobile}" />
					</h:column>
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="����" />
						</f:facet>
						<h:commandButton styleClass="button01" onclick="return confirm('ȷ��Ҫɾ����');"   action="#{groupBB.delGroupMember}" value="ɾ��" >
							<x:updateActionListener value="#{list.person_id}" property="#{groupBB.groupItem.personId}"></x:updateActionListener>
						</h:commandButton> 
					</h:column>
				</x:dataTable>
 <f:verbatim>
    </td>
  </tr>
</table>
</f:verbatim>
 </h:form>

<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    