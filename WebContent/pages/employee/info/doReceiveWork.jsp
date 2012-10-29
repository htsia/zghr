<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<html>
<head>
    <base target="_self">
    <title><%=LanguageSupport.getResource("RYGL-2301","办理接收")%></title>
</head>

<body>
    <x:saveState value="#{emp_WorkImportBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_WorkImportBB.receiveEdit}"/>
        <table width="98%" align="center">
            <tr class="td_title">
                <td colspan=2 align="right">
                    <h:commandButton id="save" styleClass="button01" value="接收" onclick="return forsubmit(document.forms(0))" action="#{emp_WorkImportBB.saveReceive}" />
                    <h:commandButton type="button" styleClass="button01" value="关闭" onclick="window.close()"/>
                </td>
            </tr>
            <tr nowrap>
                <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("XTGL-1047","增员类别")%></td>
                <td class=td_form02>
                    <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                                 readonly="true" value="#{emp_WorkImportBB.personchangevo.changeType}"
                                 alt="增员类别|0|s|50||"/>
                    <h:commandButton type="button" styleClass="button_select"    onclick="PopUpCodeDlgOneControl('form1:A016010','0200110001')" />
                </td>
            </tr>
            <tr>
                <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("RYGL-2282","增员时间")%></td>
                <td class=td_form02>
                    <h:inputText styleClass="input" id="A016020" value="#{emp_WorkImportBB.personchangevo.changeDate}"
                                 readonly="true" alt="增员时间|0|d6|50||"/>
                    <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:A016020')" />
                </td>
            </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-1016","姓名")%></td>
               <td class=td_form02>
                    <h:inputText readonly="true" value="#{emp_WorkImportBB.cadbo.name}"></h:inputText>
               </td>
           </tr>

            <tr nowrap>
               <td class=td_form01><%=LanguageSupport.getResource("RYGL-1015","身份证号")%></td>
               <td class=td_form02>
                    <h:inputText readonly="true" value="#{emp_WorkImportBB.cadbo.pid}"></h:inputText>
               </td>
           </tr>

            <tr>
            <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("XTGL-1044","员工类别")%></td>
            <td class=td_form02>
                <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                             readonly="true" value="#{emp_WorkImportBB.personvo.personType}"
                             alt="员工类别|0|s|50||"/>
                <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')"/>
            </td>
             </tr>

             <tr nowrap>
                <td class=td_form01 td_form_required><%=LanguageSupport.getResource("RYGL-2019","调入部门")%></td>
                <td class=td_form02 >
                    <h:inputText styleClass="input" id="A016030" value="#{emp_WorkImportBB.personvo.deptId}" dict="yes" dict_num="OU"  code=""
                            readonly="true"    alt="调入部门|1|s|50||"/>
                    <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A016030',2)">
                </td>
            </tr>
        </table>
    </h:form>
</body>
</html>