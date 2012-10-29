<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<h:form id="form1">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
         <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-0300","��Ա���� ")%> ->
              <%=LanguageSupport.getResource("RYGL-0326","�������乤��Ȳ���")%>  
            </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
<f:verbatim>
    <table  border="0" width="800" align="center">
        <tr>
            <td colspan="3" align="left">
            <br>
            <strong><%=LanguageSupport.getResource("RYGL-2411","�������")%> ��</strong><br>
</f:verbatim>
            <h:selectManyCheckbox value="#{emp_DrawoutAgeBB.fields}" layout="pageDirection">
                <c:selectItem itemValue="A796706" itemLabel="����(A796706) ��Դ�� ��������(A001011)"></c:selectItem>
                <c:selectItem itemValue="A796705" itemLabel="����(A796705) ��Դ�� �μӹ���ʱ��(A001041)"></c:selectItem>
                <c:selectItem itemValue="A796707" itemLabel="����λ����(A796707) ��Դ�� ���뱾��λʱ��(A001044)"></c:selectItem>
                <c:selectItem itemValue="A796708" itemLabel="��ϵͳ����(A796708) ��Դ�� ���뱾ϵͳʱ��(A001781)"></c:selectItem>
                <c:selectItem itemValue="A796710" itemLabel="����ְ����(A796710) ��Դ�� ����ְʱ��(A705722)"></c:selectItem>
                <c:selectItem itemValue="A796711" itemLabel="ת������(A796711) ��Դ�� ת��ʱ��(A020700)"></c:selectItem>
            </h:selectManyCheckbox>
<f:verbatim>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="left"><strong><%=LanguageSupport.getResource("RYGL-2412","���㷽�� ")%></strong><br>
</f:verbatim>
               <h:selectOneRadio value="#{emp_DrawoutAgeBB.method}">
                   <c:selectItem itemValue="0" itemLabel="��ʱ�����"></c:selectItem>
                   <c:selectItem itemValue="1" itemLabel="ԭ���ݼ�1"></c:selectItem>
               </h:selectOneRadio>
<f:verbatim>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="left">
             <br>
            <strong><%=LanguageSupport.getResource("RYGL-2413","���㾫�� ")%></strong><br><br>
</f:verbatim>
                 <h:selectOneRadio value="#{emp_DrawoutAgeBB.precise}">
                     <c:selectItem itemValue="0" itemLabel="����������"></c:selectItem>
                     <c:selectItem itemValue="1" itemLabel="����������"></c:selectItem>
                 </h:selectOneRadio>
<f:verbatim>
            </td>
        </tr>

        <tr>
            <td colspan="3" align="left">
             <br>
            <strong><%=LanguageSupport.getResource("RYGL-2414","����һ��ʱ�Ĵ������ ")%>��</strong><br><br>
</f:verbatim>
                 <h:selectOneRadio value="#{emp_DrawoutAgeBB.mode}">
                     <c:selectItem itemValue="0" itemLabel="����һ�����"></c:selectItem>
                     <c:selectItem itemValue="1" itemLabel="��������"></c:selectItem>
                     <c:selectItem itemValue="2" itemLabel="����һ�갴һ���"></c:selectItem>
                 </h:selectOneRadio>
<f:verbatim>
            </td>
        </tr>

        <tr class="td_middle">
            <br>
            <td><strong><%=LanguageSupport.getResource("RYGL-2290","��������")%></strong>
</f:verbatim>
                <h:inputText id="orgId" value="#{emp_DrawoutAgeBB.orgId}" readonly = "true"
                                  size="30" styleClass="input" code="" dict="yes" dict_num="OU" />
                <h:commandButton onclick="PopUpOrgDlg('form1:orgId',2,'')" styleClass="button_select"  type="button"/>
<f:verbatim>
            </td>

            <td><strong>��׼ʱ��</strong>
</f:verbatim>
    <h:inputText styleClass="input" id="baseTime" value="#{emp_DrawoutAgeBB.baseTime}"
                 readonly="true" alt="��׼ʱ��|1|d|50||"/>
    <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:baseTime')"/>

<f:verbatim>
            </td>

            <td>
</f:verbatim>
                <h:commandButton  styleClass="button01" value="��ʼ����" onclick = "disPlayProcessBar();return forsubmit(document.forms(0))" action ="#{emp_DrawoutAgeBB.saveDrawout}"/>
<f:verbatim>
            </td>
        </tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
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
        </tr></table>
</marquee>

