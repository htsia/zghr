<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    
    <script type="text/javascript">
        function selectPost(){
          fPopUpMutiPostDlg('form1:postID','form1:postName','');
          if (document.all('form1:postID').value=='')
              return false;
          else
              return true;
        }
                
        function foradd() {
            window.showModalDialog("/wage/set/BankEdit.jsf?moduleID="+document.all("form1:moduleID").value+"&setID="+document.all("form1:setID").value, null, "dialogWidth:450px; dialogHeight:440px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function forModify(bankid) {
            window.showModalDialog("/wage/set/BankEdit.jsf?moduleID="+document.all("form1:moduleID").value+"&setID="+document.all("form1:setID").value+"&bankID="+bankid, null, "dialogWidth:450px; dialogHeight:440px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
        function doModifyDate(bankid){
            window.showModalDialog("/wage/set/BankItemList.jsf?moduleID="+document.all("form1:moduleID").value+"&setID="+document.all("form1:setID").value+"&bankID="+bankid, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:no;");
            return true;
        }
    </script>

<x:saveState value="#{wage_setBB}"/>
<h:form id="form1">
    <h:inputHidden id="setID" value="#{wage_setBB.copySet}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" 账套管理 ->  关联岗位设置"/>
        </h:panelGroup>
    </h:panelGrid>

       <c:verbatim><table width=100%><tr><td align=right></c:verbatim>
            <h:inputHidden id="postID" value="#{wage_setBB.postIDs}"></h:inputHidden>
            <h:inputHidden id="postName"></h:inputHidden>
            <h:commandButton styleClass="button01" value="增加岗位" onclick="return selectPost();" action="#{wage_setBB.savePostLink}"/>
       <c:verbatim></td></tr><tr><td></c:verbatim>
        <h:dataTable value="#{wage_setBB.postLinkList}" var="list" align="center"  id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="90%" >
            <h:column>
                <c:facet name="header"><h:outputText value="名称"/></c:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText value="#{list.postName}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton value="删除" styleClass="button01" action="#{wage_setBB.deletePostLink}">
                     <x:updateActionListener property="#{wage_setBB.linkID}" value="#{list.linkID}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
       <c:verbatim></td></tr></table></c:verbatim>

</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
