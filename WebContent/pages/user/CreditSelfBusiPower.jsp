<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

 <c:verbatim><script language="javascript" src="<%=request.getContextPath()%>/js/tree2.js"></script></c:verbatim>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function selNode(){
        var item = document.forms(0).selectItem;
        if(item==null) return false;
        var selRoleId="";
        var i;
        if(item.length==null){
            if(item.value!=null)
                selRoleId=item.value;
        } else{
                for(i=0;i<item.length;i++){
                    if(item[i].checked){
                        if(selRoleId==""){
                            selRoleId+=item[i].value;
                        }else{
                            selRoleId+=","+item[i].value;
                        }
                     }
                }
            }
        document.all('formRoleList:newOper').value = selRoleId;
        return true;
    }

</script>

<x:saveState value="#{user_selRoleListBB}"/>
<h:form id="formRoleList">
    <h:inputHidden id="pageInit" value="#{user_selRoleListBB.roleSelfAssign}"/>
    <h:inputHidden id="newOper" value="#{user_selRoleListBB.newOper}"/>
    <h:inputHidden id="roleID" value="#{user_selRoleListBB.roleID}"/>
    <c:verbatim>
    <table width=98% height=98%>
        <tr><td height=8 align="right">
   </c:verbatim>
            <h:commandButton value="确 定" onclick="return selNode();" action="#{user_selRoleListBB.saveRoleSelfPower}"  styleClass="button01"/>
 <c:verbatim>
        </td></tr>

        <tr><td>
            <div style='width:100%;height:100%;overflow:auto' id=datatable >
 </c:verbatim>
                <h:dataTable value="#{user_selRoleListBB.roleinfos}" var="list" width="97%"  id="dateList"
                             headerClass="td_top tr_fixrow" columnClasses="td_middle"
                             styleClass="table03"  border="0">
                    <h:column>
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox" name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" </f:verbatim><h:outputText value="#{list.isHave}"/><f:verbatim>  value="</f:verbatim>
                        <h:outputText value="#{list.operateId}"/>
                        <f:verbatim escape="false">"/></div></f:verbatim>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="功能名称"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.operateName}"/>
                    </h:column>
                </h:dataTable>
 <c:verbatim>
            </div>
       </td></tr> 
    </table>
 </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("formRoleList:dateList");
</script>

