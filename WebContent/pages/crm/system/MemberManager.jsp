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
            <h:commandButton value="选择人员"  onclick="return fPopUpBackPerTreeDlg('');"  styleClass="button01"></h:commandButton>
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
							<h:outputText value="姓名" />
						</c:facet>
						<h:outputText value="#{list.person_name }" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="性别" />
						</c:facet>
						<h:outputText value="#{list.sex}" />
					</h:column>
					
					<h:column>
						<c:facet name="header">
							<h:outputText value="联系电话" />
						</c:facet>
						<h:outputText value="#{list.mobile}" />
					</h:column>
					
					<h:column>
						<f:facet name="header">
							<h:outputText value="操作" />
						</f:facet>
						<h:commandButton styleClass="button01" onclick="return confirm('确定要删除吗？');"   action="#{groupBB.delGroupMember}" value="删除" >
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


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    