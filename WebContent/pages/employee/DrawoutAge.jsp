<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<h:form id="form1">
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
         <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-0300","人员管理 ")%> ->
              <%=LanguageSupport.getResource("RYGL-0326","更新年龄工龄等参数")%>  
            </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>
<f:verbatim>
    <table  border="0" width="800" align="center">
        <tr>
            <td colspan="3" align="left">
            <br>
            <strong><%=LanguageSupport.getResource("RYGL-2411","相关数据")%> ：</strong><br>
</f:verbatim>
            <h:selectManyCheckbox value="#{emp_DrawoutAgeBB.fields}" layout="pageDirection">
                <c:selectItem itemValue="A796706" itemLabel="年龄(A796706) 来源于 出生日期(A001011)"></c:selectItem>
                <c:selectItem itemValue="A796705" itemLabel="工龄(A796705) 来源于 参加工作时间(A001041)"></c:selectItem>
                <c:selectItem itemValue="A796707" itemLabel="本单位工龄(A796707) 来源于 进入本单位时间(A001044)"></c:selectItem>
                <c:selectItem itemValue="A796708" itemLabel="本系统工龄(A796708) 来源于 进入本系统时间(A001781)"></c:selectItem>
                <c:selectItem itemValue="A796710" itemLabel="任现职年限(A796710) 来源于 任现职时间(A705722)"></c:selectItem>
                <c:selectItem itemValue="A796711" itemLabel="转正年限(A796711) 来源于 转正时间(A020700)"></c:selectItem>
            </h:selectManyCheckbox>
<f:verbatim>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="left"><strong><%=LanguageSupport.getResource("RYGL-2412","计算方法 ")%></strong><br>
</f:verbatim>
               <h:selectOneRadio value="#{emp_DrawoutAgeBB.method}">
                   <c:selectItem itemValue="0" itemLabel="从时间计算"></c:selectItem>
                   <c:selectItem itemValue="1" itemLabel="原数据加1"></c:selectItem>
               </h:selectOneRadio>
<f:verbatim>
            </td>
        </tr>
        <tr>
            <td colspan="3" align="left">
             <br>
            <strong><%=LanguageSupport.getResource("RYGL-2413","计算精度 ")%></strong><br><br>
</f:verbatim>
                 <h:selectOneRadio value="#{emp_DrawoutAgeBB.precise}">
                     <c:selectItem itemValue="0" itemLabel="计算年数据"></c:selectItem>
                     <c:selectItem itemValue="1" itemLabel="计算月数据"></c:selectItem>
                 </h:selectOneRadio>
<f:verbatim>
            </td>
        </tr>

        <tr>
            <td colspan="3" align="left">
             <br>
            <strong><%=LanguageSupport.getResource("RYGL-2414","不足一年时的处理规则 ")%>：</strong><br><br>
</f:verbatim>
                 <h:selectOneRadio value="#{emp_DrawoutAgeBB.mode}">
                     <c:selectItem itemValue="0" itemLabel="不足一年忽略"></c:selectItem>
                     <c:selectItem itemValue="1" itemLabel="四舍五入"></c:selectItem>
                     <c:selectItem itemValue="2" itemLabel="不足一年按一年计"></c:selectItem>
                 </h:selectOneRadio>
<f:verbatim>
            </td>
        </tr>

        <tr class="td_middle">
            <br>
            <td><strong><%=LanguageSupport.getResource("RYGL-2290","所属机构")%></strong>
</f:verbatim>
                <h:inputText id="orgId" value="#{emp_DrawoutAgeBB.orgId}" readonly = "true"
                                  size="30" styleClass="input" code="" dict="yes" dict_num="OU" />
                <h:commandButton onclick="PopUpOrgDlg('form1:orgId',2,'')" styleClass="button_select"  type="button"/>
<f:verbatim>
            </td>

            <td><strong>基准时间</strong>
</f:verbatim>
    <h:inputText styleClass="input" id="baseTime" value="#{emp_DrawoutAgeBB.baseTime}"
                 readonly="true" alt="基准时间|1|d|50||"/>
    <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:baseTime')"/>

<f:verbatim>
            </td>

            <td>
</f:verbatim>
                <h:commandButton  styleClass="button01" value="开始计算" onclick = "disPlayProcessBar();return forsubmit(document.forms(0))" action ="#{emp_DrawoutAgeBB.saveDrawout}"/>
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

