<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addChannel(){
             window.showModalDialog("/recruit/channelEdit.jsf","", "dialogWidth:315px; dialogHeight:415px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/recruit/channelEdit.jsf?chanID="+id, "", "dialogWidth:315px; dialogHeight:415px; status:0;resizable:yes");
            return true;
        }
    </script>

<x:saveState value="#{recruit_channelBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{recruit_channelBB.initPage}"></h:inputHidden>
    <h:inputHidden id="chanID" value="#{recruit_channelBB.chanID}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{recruit_channelBB.userOrgname}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
            
            <h:panelGroup>
                <h:outputText value="��¼��:#{recruit_channelBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{recruit_channelBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{recruit_channelBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{recruit_channelBB.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{recruit_channelBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recruit_channelBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{recruit_channelBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{recruit_channelBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>          
	             <h:commandButton value="����" onclick="return addChannel();" styleClass="button01"></h:commandButton>
          </h:panelGrid>
    </h:panelGrid>
      <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{recruit_channelBB.channelList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="��Ƹ��������"/></c:facet>
            <h:outputText value="#{list.chanName}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="��ϵ��1�ֻ�"/></c:facet>
            <h:outputText value="#{list.chanMobile1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="��ϵ��1����"/></c:facet>
            <h:outputText value="#{list.chanPer1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="��ϵ��1�绰"/></c:facet>
            <h:outputText value="#{list.chanTel1}"/>
        </h:column>
        
          <h:column>
            <c:facet name="header"><h:outputText value="��ϵ��2����"/></c:facet>
            <h:outputText value="#{list.chanPer2}"/>
        </h:column>
		
        <h:column>
            <c:facet name="header"><h:outputText value="��ϵ��2�ֻ�"/></c:facet>
            <h:outputText value="#{list.chanMobile2}"/>
        </h:column>
        
        
		
		<h:column>
            <c:facet name="header"><h:outputText value="��ϵ��2�绰"/></c:facet>
            <h:outputText value="#{list.chanTel2}"/>
        </h:column>
		
        <h:column>
            <c:facet name="header"><h:outputText value="��ϵ��ַ"/></c:facet>
            <h:outputText value="#{list.chanAdde}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.chanDesc}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�༭" styleClass="button01" onclick="return modify('#{list.chanID}')"></h:commandButton>
            <h:commandButton value="ɾ��" styleClass="button01"  onclick="return confirm('ȷ��Ҫɾ����?');" action="#{recruit_channelBB.delete}">
                  <x:updateActionListener property="#{recruit_channelBB.chanID}" value="#{list.chanID}"/>
            </h:commandButton>
        </h:column>
    </h:dataTable>
	<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>