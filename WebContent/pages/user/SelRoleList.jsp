<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css"/>
    <script language="javascript" src="<%=request.getContextPath()%>/js/tree2.js"></script>
    <script language="javascript" src="<%=request.getContextPath()%>/js/Appclient.js"></script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function selNode(){
       // debugger;
        var item = document.forms(0).selectItem;
        if(item==null) return false;
        var selRoleId="";
        var i;
        if(item.length==null){
            if(item.value!=null)
                selRoleId=item.value+":"+item.sysOper;
        } else{
                for(i=0;i<item.length;i++){
                    if(item[i].checked)
                    {
                        if(item[i].sysOper=="1" && selRoleId!=""){
                            alert("选择的角色中不允许同时含有管理员角色和其他角色,请重新选择。")
                            return false;
                        }
                        if(selRoleId==""){
                            selRoleId+=item[i].value+":"+item[i].sysOper;
                        }else{
                            selRoleId+=","+item[i].value+":"+item[i].sysOper;
                        }
                     }
                }
            }
        if(selRoleId==""){
            alert('请选择角色！');
            return false
        }
        window.returnValue = selRoleId;
        window.close();
        return false;

    }
    function winClose(){
        window.returnValue="";
        window.close();
        return false;
    }
</script>

<x:saveState value="#{user_selRoleListBB}"/>
<f:view>
<h:form id="formRoleList">
<h:inputHidden id="pageInit" value="#{user_selRoleListBB.pageInit}"/>
<f:verbatim>
    <div class='table03' style="width:100%;height:90%;overflow:auto" >
</f:verbatim>

<h:panelGrid columns="1" width="97%" cellpadding="0" align="center"  cellspacing="0" border="0" >
<h:dataTable value="#{user_selRoleListBB.roleinfos}" var="list" width="97%"
             headerClass="td_top" rowClasses="td_middle"
             styleClass="table03"  border="1">
    <h:column>
        <f:facet name="header">
            <f:verbatim escape="false">
                <input type="checkbox" name="all"
                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
            </f:verbatim>
        </f:facet>
        <f:verbatim escape="false">
            <div align="center"> <input type="checkbox" name="selectItem" sysOper="</f:verbatim><h:outputText value="#{list.sysOper}"/><f:verbatim>" value="</f:verbatim>
        <h:outputText value="#{list.roleId}"/>
        <f:verbatim escape="false">"/></div></f:verbatim>
    </h:column>

    <h:column>
        <f:facet name="header">
            <h:outputText value="角色名称"/>
        </f:facet>
        <h:outputText escape="false" value="#{list.roleName}"/>
    </h:column>
</h:dataTable>
</h:panelGrid>

    <f:verbatim>
      </div>
    </f:verbatim>

    <h:panelGrid columns="1" width="100%" cellpadding="0"  align="center" border="0">
        <h:panelGrid align="right" columns="2">
            <h:commandButton value="确 定" onclick="return selNode()"  styleClass="button01"/>
            <h:commandButton value="取 消" onclick="return winClose()" styleClass="button01"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>

</f:view>
