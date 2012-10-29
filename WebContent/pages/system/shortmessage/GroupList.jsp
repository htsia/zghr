<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function foradd() {
            window.showModalDialog("/system/GroupEdit.jsf", null, "dialogWidth:330px; dialogHeight:150px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModify(ID) {
            window.showModalDialog("/system/GroupEdit.jsf?groupID="+ID, null, "dialogWidth:300px; dialogHeight:150px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModifyData(groupID,groupName) {
            window.showModalDialog("/system/GroupItemList.jsf?groupID="+groupID+"&groupName="+groupName, null, "dialogWidth:"+screen.width*4/5+"px; dialogHeight"+screen.height*4/5+":px;center:center;resizable:no;status:no;scroll:no;");
            return false;
        }
    </script>

<x:saveState value="#{sys_smGroupBB}"/>
<h:form id="form1">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1363", "群管理 ")%>:
			</f:verbatim> 
        </h:panelGroup>

        <h:panelGrid align="right" columns="1" cellspacing="2" width="30%">
            <h:commandButton styleClass="button01" value="新建" onclick="foradd()" />
        </h:panelGrid>
    </h:panelGrid>


    <h:panelGrid  width="95%" border="0" cellpadding="0" cellspacing="6" columns="1">
    <x:dataTable id="bookListTable" value="#{sys_smGroupBB.groupList}" var="list" align="center"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="rowdex">

        <h:column>
            <c:facet name="header">
            <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1029", "序号 ")%> 
            </f:verbatim>
            </c:facet>
            <h:outputText value="#{rowdex+1}"/>
        </h:column>

        <h:column>
            <c:facet name="header">
             <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1015", "描述 ")%> 
            </f:verbatim>
             </c:facet>
            <h:outputText value="#{list.groupName}"/>
        </h:column>


        <h:column>
            <c:facet name="header">
             <f:verbatim>
                   <%=LanguageSupport.getResource("YXGL-1026", "操作 ")%> 
            </f:verbatim>
            </c:facet>
            <h:panelGrid columns="5" align="center" cellspacing="2">
                <h:commandButton value="删除" styleClass="button01"
                                 action="#{sys_smGroupBB.Delete}" rendered="#{list.canOper}" onclick="return confirm('确认删除？')">
                    <x:updateActionListener property="#{sys_smGroupBB.groupID}" value="#{list.groupID}"/>
                </h:commandButton>
                <h:commandButton value="修改属性" styleClass="button01"  rendered="#{list.canOper}"
                                  onclick="return forModify('#{list.groupID}')">
                </h:commandButton>
                <h:commandButton value="修改数据" type="button" styleClass="button01" rendered="#{list.canOper}"
                                  onclick="return forModifyData('#{list.groupID}','#{list.groupName}');">
                </h:commandButton>
                <h:commandButton value="查看数据" type="button" styleClass="button01" rendered="#{!list.canOper}"
                                  onclick="return forModifyData('#{list.groupID}','#{list.groupName}');">
                </h:commandButton>

            </h:panelGrid>
        </h:column>
    </x:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:bookListTable");
</script>