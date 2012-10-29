<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

  <script type="text/javascript">
        function doReply(id){
            window.showModalDialog("/system/SendMessage.jsf?RecID="+id, null, "dialogWidth:500px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        function doLinkOper(url,OperID){
            if (window.opener.document.all('checkNew').value=="true"){  // 自动打开
                if (window.opener.parent.document.all('busimain')!=null && window.opener.parent.document.all('busimain').value=="true"){  // 业务的主页面
                    window.opener.parent.LinkOper(OperID);
                }
                else{
                    window.opener.parent.parent.LinkOper(url);
                }
            }
            window.close();
        }
  </script>

  <x:saveState value="#{sys_smListBackingBean}"/>
  <h:form id="form1">
      <h:inputHidden value="#{sys_smListBackingBean.readMessage}"></h:inputHidden>
      <br>
      <h:panelGrid align="center" width="95%">
         <h:panelGrid columns="2" width="98%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1303", "接收人")%>:
			</f:verbatim> 
          <h:outputText id="recname" value="#{sys_smListBackingBean.sbo.receiveName}" />

           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1304", "发送人")%>:
			</f:verbatim> 
          <h:outputText id="sendname" value="#{sys_smListBackingBean.sbo.sendName}" />

           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1365", "发送时间")%>:
			</f:verbatim>
          <h:outputText id="time" value="#{sys_smListBackingBean.sbo.sendTime}" />
          
		    <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1320", "附件")%>:
			</f:verbatim>
		  <h:outputLink id="link" value="/file/shortmessage/#{sys_smListBackingBean.sbo.att_file}" target="blank">
			<h:outputText id="att_file" value="#{sys_smListBackingBean.sbo.att_file}"></h:outputText>
		  </h:outputLink>
		  
           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1156", "关联操作")%>:
			</f:verbatim>
          <h:panelGroup>
              <h:commandLink onclick="doLinkOper('#{sys_smListBackingBean.url}','#{sys_smListBackingBean.sbo.linkOperate}');" value="#{sys_smListBackingBean.sbo.linkOperName}"></h:commandLink>
          </h:panelGroup>

           <f:verbatim>
		        <%=LanguageSupport.getResource("XTGL-1111", "内容")%>:
			</f:verbatim>
          <h:outputText id="content" escape="false" value="#{sys_smListBackingBean.sbo.content}" />
      </h:panelGrid>

      <h:panelGrid columns="2" align="right" cellspacing="2">
          <h:commandButton styleClass="button01" value="回复" type="button" onclick="doReply('#{sys_smListBackingBean.sbo.sendID}');"/>
          <h:commandButton styleClass="button01" value="关闭" onclick="window.close();"/>
      </h:panelGrid>

    </h:panelGrid>
  </h:form>
