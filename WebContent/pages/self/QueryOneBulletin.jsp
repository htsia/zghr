<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@ include file="/pages/include/taglib.jsp" %>
<script type="text/javascript">
    function doLinkOper(operID){
        window.opener.LinkOper(operID);
        window.close();
    }
</script>

<x:saveState value="#{self_selfbulletinbb}"/>
<h:form id="form1">
    <c:verbatim><br></c:verbatim>
    <h:inputHidden value="#{self_selfbulletinbb.initQueryOneBulletin}"/>
    <c:verbatim>
        <table width=100%>
            <tr><td align="right">
    </c:verbatim>
               <h:commandButton value="关闭窗口" type="button" onclick="window.close();"  styleClass="button01" />
    <c:verbatim>
            </td></tr>
        </table>
    </c:verbatim>

    <h:panelGrid width="98%" columns="1" border="1" align="center"
        styleClass="table03" rowClasses="td_form01,td_form02,td_form02,td_form02"
        cellpadding="4" >

        <h:panelGrid columns="1" align="center">
            <h:outputText value="#{self_selfbulletinbb.topic}" style="font-size:18px;font-weight:bold;align:center" />

            <h:outputText value="发布时间：#{self_selfbulletinbb.startDate}" />

            <f:verbatim>
                <HR color=#cccccc size="1" width="99%" align="center">
            </f:verbatim>
        </h:panelGrid>

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>关联操作:<br></strong>"  />
            <h:commandLink onclick="doLinkOper('#{self_selfbulletinbb.linkOp}')" value="#{self_selfbulletinbb.linkOpName}"></h:commandLink>
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>正文:<br></strong>"  />
            <h:outputText escape="false" value="#{self_selfbulletinbb.content}" />
        </h:panelGroup>

        <h:panelGroup>
            <h:outputText escape="false" value="<strong>附件:<br></strong>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfbulletinbb.attFile1}'>#{self_selfbulletinbb.attTitle1}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfbulletinbb.attFile2}'>#{self_selfbulletinbb.attTitle2}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfbulletinbb.attFile3}'>#{self_selfbulletinbb.attTitle3}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfbulletinbb.attFile4}'>#{self_selfbulletinbb.attTitle4}</a><br>"  />
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target='_blank' href='#{self_selfbulletinbb.attFile5}'>#{self_selfbulletinbb.attTitle5}</a><br>"  />
        </h:panelGroup>
   </h:panelGrid>

<c:verbatim>
    <table width=100%>
        <tr><td align="right">
</c:verbatim>
           <h:commandButton value="关闭窗口" type="button" onclick="window.close();"  styleClass="button01" />
<c:verbatim>
        </td></tr>
    </table>
    <script type="text/javascript">
    </script>
</c:verbatim>
</h:form>

<script type="text/javascript">
    document.onselectstart=function(){return   false;};
    document.oncontextmenu=function(){return   false;};
    document.onselect=function(){document.selection.empty();};
    document.oncopy=function(){document.selection.empty();};
    document.onmouseup=function(){document.selection.empty();};
    document.onbeforecopy=function(){document.selection.empty();};
    document.onkeydown=function(){if(event.ctrlKey) return false;};
</script>
