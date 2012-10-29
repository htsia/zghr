<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function doAddBulletin(){
        window.showModalDialog("/eLearn/BulletinEdit.jsf", null, "dialogWidth:700px; dialogHeight:520px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function doModifyBulletin(id){
        window.showModalDialog("/eLearn/BulletinEdit.jsf?itemId="+id, null, "dialogWidth:700px; dialogHeight:520px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
</script>

<x:saveState value="#{eLearn_bulletinBB}"/>
	<h:form id="form1">
       <h:panelGrid styleClass="td_title" width="98%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2" align="center">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value=" ����ѧϰ ->  ѧϰ����"/>
            </h:panelGroup>

           <h:panelGrid columns="1"  align="right">
               <h:panelGroup>
                   <h:commandButton value="����" onclick="return doAddBulletin();" styleClass="button01" />
               </h:panelGroup>
           </h:panelGrid>

       </h:panelGrid>

        <f:verbatim>
			<br>
		</f:verbatim>

		<h:dataTable value="#{eLearn_bulletinBB.bulletinList}" var="bulist" id="dateList"
                     columnClasses="td_middle_center,td_middle,td_middle_left,td_middle,td_middle,td_middle_center"
                     width="98%"  headerClass="td_top"
                     styleClass="table03"  align="center">

			<h:column>
				<f:facet name="header">
					<h:outputText value="�������" />
				</f:facet>
				<h:outputText style="width:180px" value="#{bulist.blltnTopic}" />
			</h:column>

			<h:column>
				<f:facet name="header">
					<h:outputText value="��Чʱ��" />
				</f:facet>				
					<h:outputText style="width:80px" value="#{bulist.startDate}" />
			</h:column>

            <h:column>
                <f:facet name="header">
                    <h:panelGroup>
                        <h:graphicImage value="/images/common/new.gif"></h:graphicImage>
                        <h:outputText value="��ʾʧЧʱ��" />
                    </h:panelGroup>
                </f:facet>
                <h:outputText style="width:110px" value="#{bulist.newEndDate}" />
            </h:column>

            <h:column>
				<f:facet name="header">
					<h:outputText value="ʧЧʱ��" />
				</f:facet>
				<h:outputText style="width:80px" value="#{bulist.endDate}" />
			</h:column>

            <h:column>
                <f:facet name="header">
                    <h:outputText style="width:40px" value="����" />
                </f:facet>
                <h:commandButton action="#{eLearn_bulletinBB.Delete}" styleClass="button01" value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?')" >
                <x:updateActionListener property="#{eLearn_bulletinBB.currentID}" value="#{bulist.blltnId}"/>
             </h:commandButton>
             <h:commandButton styleClass="button01" value="�޸�"  onclick="return doModifyBulletin('#{bulist.blltnId}');" />
            </h:column>

        </h:dataTable>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
