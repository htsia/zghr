<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>

<%
    response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<c:verbatim>
	
</c:verbatim>
<script type="text/javascript">
function showProcessBar() {
    x = document.body.clientWidth / 2 - 150;
    y = document.body.clientHeight / 2;
    document.all('processbar').style.top = y;
    document.all('processbar').style.left = x;
    document.all('processbar').style.display = "";
 }
function showDetail(personId){
	window.showModalDialog("/coalsafe/showPersonAmerce.jsf?personId="+personId+"&operateTime="+document.all("form1:time1").value, null, "dialogWidth:"+screen.width*0.6+"px; dialogHeight:"+screen.height*0.6+"px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}
</script>

<x:saveState value="#{coalOverseeMgrBB}"/>
<h:form id="form1">
      <h:inputHidden value="#{coalOverseeMgrBB.initCal}"></h:inputHidden>
       <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
      		<h:panelGroup>
	        <h:graphicImage value="/images/tips.gif" />
	        <h:outputText value=" ���ִ�� -> ��ؿ۷�"/>
	        </h:panelGroup>
       </h:panelGrid>
      <h:panelGrid width="98%" columns="1" align="center">
      	  <h:panelGrid columns="2">
      	  		<h:panelGroup>
      	  			<h:outputText value="ʱ��:"></h:outputText>
      	  			<h:inputText id="time1" value="#{coalOverseeMgrBB.caclTime}" readonly="true"></h:inputText>
      	  			<h:commandButton type="button" styleClass="button_select" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM',el:'form1:time1'})"></h:commandButton>
      	  			<h:outputText value=""></h:outputText>
      	  			<h:commandButton value="����" action="#{coalOverseeMgrBB.caclItem}" styleClass="button01" onclick="showProcessBar();"></h:commandButton>
      	  			<h:outputText value=""></h:outputText>
      	  			<h:commandButton value="������Ա�Ӽ�" action="#{coalOverseeMgrBB.impHr}" styleClass="button01" onclick="showProcessBar();"></h:commandButton>
      	  		</h:panelGroup>
      	  </h:panelGrid>
		  <h:panelGrid columns="2" align="right">
		  		<h:panelGroup>
		  		<h:outputText value="��¼��:#{coalOverseeMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{coalOverseeMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{coalOverseeMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{coalOverseeMgrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{coalOverseeMgrBB.first2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{coalOverseeMgrBB.pre2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{coalOverseeMgrBB.next2}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{coalOverseeMgrBB.last2}" styleClass="button01"></h:commandButton>
                </h:panelGroup>
          </h:panelGrid>

          <x:dataTable value="#{coalOverseeMgrBB.calList}"  id="dateList"
				headerClass="td_top" rowIndexVar="index" var="briefList" 	styleClass="table03" border="1" width="98%"
                columnClasses="td_middle_center,td_middle,td_middle_center,td_middle_center">
				
				<h:column>
					<f:facet name="header">
						<h:outputText value="���" />
					</f:facet>
                    <h:outputText value="#{index+1}" ></h:outputText>
                </h:column>
				<h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.personName}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="ʱ��" />
					</f:facet>
                    <h:outputText value="#{briefList.caclTime}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="�۷�" />
					</f:facet>
                    <h:outputText value="#{briefList.score}" ></h:outputText>
                </h:column>
                <h:column>
					<f:facet name="header">
						<h:outputText value="����" />
					</f:facet>
                    <h:outputText value="#{briefList.amerce}" ></h:outputText>
                </h:column>
                <h:column>
                    <f:facet name="header">
                        <h:outputText value="����" />
                    </f:facet>
                    <h:commandButton value="��ϸ��Ϣ" onclick="showDetail('#{briefList.personId}');" styleClass="button01"></h:commandButton>
                </h:column>
			</x:dataTable>
			<f:verbatim>
				<br>
			</f:verbatim>
		</h:panelGrid>
		<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
               scrollamount="5" scrolldelay="10"
               bgcolor="#ECF2FF">
          <table cellspacing="1" cellpadding="0">
              <tr height=8>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
                  <td bgcolor=#3399FF width=8></td>
                  <td></td>
              </tr>
          </table>
      </marquee>
	</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>


