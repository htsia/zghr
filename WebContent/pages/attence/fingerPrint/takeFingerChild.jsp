<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
      function onTake(){
          document.all("form1:template").value=document.all('FingerPrint').GetFingerPrint();
          if (document.all("form1:template").value==""){
              alert("�ɼ�ʧ��!");
              return false;
          }
          return true;
      }
      function onCheck(id){
         window.showModalDialog("/attence/checkFinger.jsf?PersonID=" + id, null, "dialogWidth:500px; dialogHeight:380px;center:center;resizable:yes;status:no;scroll:yes;");
         return false;
      }
</script>
<x:saveState value="#{sys_fingerBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{sys_fingerBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="template" value="#{sys_fingerBB.template}"></h:inputHidden>
    <f:verbatim>
    <OBJECT id="FingerPrint" style="Z-INDEX: 101; LEFT: -88px; POSITION: absolute; TOP: -32px"  width="0" height="0"
        classid="clsid:85A22EF6-F089-424D-9956-2C835E1FB99B" VIEWASTEXT>
    </OBJECT>

    <table height=96% width=100%>
     <tr><td height=8>
     
    </f:verbatim>
        <h:outputText escape="false" value="<strong>��ǰ��λ��</strong>#{sys_fingerBB.orgName}"></h:outputText>
     <f:verbatim>
     
     </f:verbatim>
     	<h:outputText escape="false" value="<strong>����������</strong>" ></h:outputText>
     <f:verbatim>
     
     <h:commandButton value="�ϴ���Ա" styleClass="button01" action="#{sys_kq.print}"></h:commandButton>
     
     <h:commandButton value="��ȡָ��" styleClass="button01" rendered="#{sys_fingerBB.queryMode=='0'}" onclick="return onTake();" action="#{sys_fingerBB.savePrint}">
                   <x:updateActionListener property="#{sys_fingerBB.personID}" value="#{list.personId}"/>
     </h:commandButton>
     
     <h:commandButton value="�ַ�" styleClass="button01" rendered="#{sys_fingerBB.queryMode=='0'}" onclick="return onTake();" action="#{sys_fingerBB.savePrint}">
                   <x:updateActionListener property="#{sys_fingerBB.personID}" value="#{list.personId}"/>
     </h:commandButton>
     
     </td>
     <td align="right">
    </f:verbatim>
        <h:selectOneRadio value="#{sys_fingerBB.queryMode}" onclick="disPlayProcessBar();submit();" valueChangeListener="#{sys_fingerBB.changeMode}">
            <c:selectItem itemValue="0" itemLabel="δ��ָ��"></c:selectItem>
            <c:selectItem itemValue="1" itemLabel="�Ѳ�ָ��"></c:selectItem>
        </h:selectOneRadio>
    <f:verbatim>
     </td>
     </tr>

     <tr><td colspan=2 align="right" height=8>
    </f:verbatim>
         <h:panelGroup>
             <h:outputText value="��¼��:#{sys_fingerBB.pagevo.totalRecord}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ҳ��:#{sys_fingerBB.pagevo.totalPage}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="ÿҳ��#{sys_fingerBB.pagevo.pageSize}"></h:outputText>
             <h:outputText value="  "></h:outputText>
             <h:outputText value="��ǰΪ��#{sys_fingerBB.pagevo.currentPage}ҳ"></h:outputText>
             <h:commandButton id="first" value="��ҳ" action="#{sys_fingerBB.first}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{sys_fingerBB.pre}" styleClass="button01"></h:commandButton>
             <h:commandButton value="��ҳ" action="#{sys_fingerBB.next}" styleClass="button01"></h:commandButton>
             <h:commandButton value="βҳ" action="#{sys_fingerBB.last}" styleClass="button01"></h:commandButton>
         </h:panelGroup>
<f:verbatim>
     </td></tr>

    <tr><td colspan=2>
       <div style='width:100%;height:100%;overflow:auto' id=datatable>
   </f:verbatim>
       <h:dataTable value="#{sys_fingerBB.personList}" var="list" align="center"  id="dateList"
                    headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                    styleClass="table03" width="100%" >
           <h:column>
               <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
               <h:outputText value="#{list.personCode}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="���ڵ�λ"/></c:facet>
               <h:outputText value="#{list.orgName}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="���ڲ���"/></c:facet>
               <h:outputText value="#{list.deptName}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="����"/></c:facet>
               <h:outputText value="#{list.name}"/>
           </h:column>

           <h:column>
               <c:facet name="header"><h:outputText value="����"/></c:facet>
               <h:commandButton value="�ɼ�" styleClass="button01" rendered="#{sys_fingerBB.queryMode=='0'}" onclick="return onTake();" action="#{sys_fingerBB.savePrint}">
                   <x:updateActionListener property="#{sys_fingerBB.personID}" value="#{list.personId}"/>
               </h:commandButton>
               
               
               <h:commandButton value="�ϴ�" styleClass="button01" rendered="#{sys_fingerBB.queryMode=='0'}" onclick="return onTake();" action="#{sys_fingerBB.savePrint}">
                   <x:updateActionListener property="#{sys_fingerBB.personID}" value="#{list.personId}"/>
               </h:commandButton>
               <h:commandButton value="�ɼ�" styleClass="button01" rendered="#{sys_fingerBB.queryMode=='0'}" onclick="return onTake();" action="#{sys_fingerBB.savePrint}">
                   <x:updateActionListener property="#{sys_fingerBB.personID}" value="#{list.personId}"/>
               </h:commandButton>
               <h:commandButton value="�ַ�" styleClass="button01" rendered="#{sys_fingerBB.queryMode=='0'}" onclick="return onTake();" action="#{sys_fingerBB.savePrint}">
                   <x:updateActionListener property="#{sys_fingerBB.personID}" value="#{list.personId}"/>
               </h:commandButton>
               
               
               <h:commandButton value="�˶�" styleClass="button01" rendered="#{sys_fingerBB.queryMode=='1'}" onclick="return onCheck('#{list.personId}');" type="button">
               </h:commandButton>
           </h:column>
       </h:dataTable>
   <f:verbatim>
       </div>
   </td></tr>
   </table>
   </f:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
