<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%@ include file="/pages/include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function forCheck() {
        // 生效时间
        if (document.all('form1:text1').value==null || document.all('form1:text1').value=="") {
            alert("请录入级别名称!");
            return false;
        }
        if (isNaN(document.all('form1:text1').value)){
            alert("级别名称必须为两位数字!");
            return false;
        }
        return true;
    }
    function forSave() {
        if (forCheck()) {
            return forsubmit(document.forms(0));
        }
        return false;
    }
</script>
    <x:saveState value="#{sys_selflevelEditBB}"/>
    <h:form id="form1" enctype="multipart/form-data">
 	  <h:inputHidden value="#{sys_selflevelEditBB.pageInit}" />
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
       <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <f:verbatim>
                <%=LanguageSupport.getResource("XTGL-0900","系统管理  ")%> -> 
                <%=LanguageSupport.getResource("XTGL-1262","自助权限管理")%> 
            </f:verbatim>
            </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>

        <table border="0"  align="center" cellspacing="2"    class="table03" cellpadding="10"	>
			<tr>
                <td class="td_form01">
                            <%=LanguageSupport.getResource("XTGL-1267","级别名称(两位数字)")%>
                 </td>
                <td class="td_form02" colspan=3>
        </f:verbatim>
                <h:inputText id="text1" styleClass="input" value="#{sys_selflevelEditBB.sbo.itemName}"  maxlength="2"/>
        <f:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">
                      <%=LanguageSupport.getResource("XTGL-1266","级别描述")%> 
                </td>
                <td class="td_form02" colspan=3>
         </f:verbatim>
                <h:inputTextarea id="textarea" rows="8" cols="55" value="#{sys_selflevelEditBB.sbo.itemDes}" />
         <f:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">
                     <%=LanguageSupport.getResource("XTGL-1264","是否允许跨单位发消息")%> 
                </td>
                <td class="td_form02" colspan=3>
          </f:verbatim>
                    <h:selectOneMenu value="#{sys_selflevelEditBB.sbo.sendToOther}">
                        <c:selectItem itemValue="0" itemLabel="不允许"></c:selectItem>
                        <c:selectItem itemValue="1" itemLabel="允许"></c:selectItem>
                    </h:selectOneMenu>
         <f:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">
                    <%=LanguageSupport.getResource("XTGL-1263","是否允许群功能")%> 
                </td>
                <td class="td_form02" colspan=3>
          </f:verbatim>
                    <h:selectOneMenu value="#{sys_selflevelEditBB.sbo.useGroup}">
                        <c:selectItem itemValue="0" itemLabel="不允许"></c:selectItem>
                        <c:selectItem itemValue="1" itemLabel="允许"></c:selectItem>
                    </h:selectOneMenu>
 <f:verbatim>
                </td>
            </tr>

		</table>
			<br>
		</f:verbatim>

        <h:panelGrid border="0" columns="2" cellpadding="8" align="right">
			<h:panelGroup>
                <h:commandButton value="确定" action="#{sys_selflevelEditBB.Save}" styleClass="button01" onclick="return forSave();"/>
                <h:commandButton value="返回" type="button" onclick="window.close()" styleClass="button01" />
            </h:panelGroup>
        </h:panelGrid>
	</h:form>


