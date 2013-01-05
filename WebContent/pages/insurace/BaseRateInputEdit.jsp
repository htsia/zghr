<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script language="javascript">
       function DoSelectAll(isSelect){
            var size = document.all('form1:inputField').length;
            for (var i = 0; i < size; i++) {
                document.all('form1:inputField')[i].checked=isSelect;
            }
        }
       function forsave(){
    	   if(!checkMutilSelect(form1.all('form1:inputField'))){
    		   alert('��ѡ��������');
    		   return false;
    	   }else{
    		   return forsubmit(document.forms(0));
    	   }
       }
    </script>
<!-- BaseRateInputEditBackingBean -->
<x:saveState value="#{ins_brieBB}"/>
<h:form id="form1">
<h:inputHidden value="#{ins_brieBB.pageInit}"/>
    <c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td height=20 class="td_title"><img src="/images/tips.gif">���չ��� -> ¼�뱣�ջ���</td>
        </tr>
    </table>
    <br/>
	</c:verbatim>
    <h:panelGrid columns="3" width="95%"  styleClass="table03" align="center" columnClasses="td_top,td_top,td_top">

        <h:outputText escape="false" value="<strong>ѡ�������</strong>"/>
        <h:selectManyCheckbox value="#{ins_brieBB.selectFields}" layout="pageDirection" id="inputField">
            <c:selectItems value="#{ins_brieBB.fieldsList}"/>
        </h:selectManyCheckbox>
        <h:panelGroup>
        <h:outputText escape="false" value="<strong>�ɷѵ�λ��</strong>"/>
        <h:panelGroup>
        <h:inputText styleClass="input" id="payAddress" code="" dict="yes" dict_num="OU" value="#{ins_brieBB.payAddress}"
                      alt="�ɷѹ�����|0|s|50||"/>
        <f:verbatim>
        	<input type="button" class="button_org" onclick="PopUpOrgDlgShowGroup('form1:payAddress',null,null, '1');"/><br/>
        </f:verbatim>
        </h:panelGroup>
        <h:outputText escape="false" value="<strong>�Ƿ��Ը���</strong>"/>
        <h:panelGroup>
        <h:inputText styleClass="input" id="selfpay" code="" dict="yes" dict_num="0090" value="#{ins_brieBB.selfPay}" alt="�Ƿ��Ը�|1|s|50||"/>
        <f:verbatim>
        	<input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:selfpay')" ><br/>
        </f:verbatim>
        </h:panelGroup>
        <h:outputText escape="false" value="<strong>�������ڣ�</strong>"/>
        <h:panelGroup>
        <h:inputText styleClass="input" id="B731701" value="#{ins_brieBB.changeDate}"
                      alt="��������|0|s|50||"/>
        <f:verbatim>
        	<input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:B731701')"><br/>
        </f:verbatim>
        </h:panelGroup>
        <h:outputText escape="false" value="<strong>�������</strong>"/>
        <h:panelGroup>
        <h:inputText styleClass="input" id="B731702" code="" dict="yes" dict_num="0200"
        	value="#{ins_brieBB.changeType}"/>
        <f:verbatim>
        	<input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:B731702','02010001')" ><br/>
        </f:verbatim>
        </h:panelGroup>
        <h:outputText escape="false" value="<strong>������λ��</strong>"/>
        <h:inputText styleClass="input" value="#{ins_brieBB.depName}" alt="������λ|1|s|50||"/>
        
        </h:panelGroup>
    </h:panelGrid>

    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="2" cellspacing="3" >
        <h:outputText escape="false" value="<font color=red>ע�⣺�����ܱ������Զ�������¼���޸�ʱ�����޸Ļ�������</font>"></h:outputText>
        <h:panelGroup>
            <h:commandButton  styleClass="button01" type="button" value="ȫ��ѡ��" onclick="DoSelectAll(true);" />
            <h:commandButton  styleClass="button01" type="button" value="ȫ��ȡ��" onclick="DoSelectAll(false);" />
            <h:commandButton styleClass="button01" value="ȷ��" action="#{ins_brieBB.queryPersonInput}"
                             onclick="return forsave();"/>
            <h:commandButton styleClass="button01" type="button" value="ȡ��" onclick="window.close()"/>
        </h:panelGroup>
    </h:panelGrid>

    <c:verbatim escape="false"><br></c:verbatim>

    <h:panelGrid columns="1" cellspacing="0" align="center" width="95%" >
        <h:outputText escape="false" value="<strong>��ѡ����Ա�б�</strong>"/>
        <h:dataTable value="#{ins_brieBB.personlist}" var="list" id="dateList"
                     headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                     styleClass="table03" width="100%" >
            <h:column>
                <c:facet name="header"><h:outputText value="����"/></c:facet>
                <h:outputText value="#{list.name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="Ա�����"/></c:facet>
                <h:outputText value="#{list.personCode}"/>
            </h:column>
            
            <h:column>
                <c:facet name="header"><h:outputText value="���ڵ�λ"/></c:facet>
                <h:outputText value="#{list.orgId}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="��������"/></c:facet>
                <h:outputText value="#{list.deptName}"/>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
   interpret(document.forms(0));
   setDataTableOver("form1:dateList");
</script>