<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
    function selectTypeFun(){
       PopUpCodeDlgOneControl('form1:A016010','0200110001');
    }

    function checkReg(){
        return forsubmit(document.forms(0));
    }
</script>
<x:saveState value="#{user_regInfoBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{user_regInfoBB.initAuditEdit}"></h:inputHidden>
<f:verbatim>

    <table align="center"  width='98%' cellspacing=0 cellpadding=0 border=0>
    <tr><td colspan="2" height=30></td></tr>

    <tr>
    <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;
         <%=LanguageSupport.getResource("XTGL-1043","���֤�� ")%>   
    </font></td>
        <td>
</f:verbatim>
            <h:inputText id="loginName" styleClass="inputDark" alt="���֤|0|s|50"  readonly="true"
                         value="#{user_regInfoBB.infobo.cardID}" size="22" tabindex="1"/>
<f:verbatim>
        </td>
    </tr>


    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;
                    <%=LanguageSupport.getResource("MSG-0010"," ��  ���� ")%>
        </font></td>
        <td>
</f:verbatim>
        <h:inputText id="name" readonly="true" styleClass="inputDark" alt="����|0|s|50"     value="#{user_regInfoBB.infobo.name}" size="22" tabindex="2"/>
<f:verbatim>
       </td>
    </tr>


    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>
                    <%=LanguageSupport.getResource("XTGL-1045"," ���ڲ��ţ� ")%>   
         </font></td>
        <td>
</f:verbatim>
        <h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
                     readonly="true" value="#{user_regInfoBB.infobo.deptid}"
                     alt="���ڲ���|0|s|50||"/>
        <h:commandButton type="button" styleClass="button_select" onclick="PopUpOrgDlg('form1:A001705',0)"/>
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>
               <%=LanguageSupport.getResource("XTGL-1050"," ����ʱ�䣺")%>   
        </font></td>
        <td>
</f:verbatim>
        <h:inputText styleClass="input" id="A016020" value="#{user_regInfoBB.infobo.enterTime}"  readonly="true" alt="����ʱ��|0|d|50||"/>
        <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:A016020');"/>

<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>
               <%=LanguageSupport.getResource("XTGL-1044"," Ա�����")%>   
        </font></td>
        <td>
</f:verbatim>
       <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                 readonly="true" value="#{user_regInfoBB.infobo.personType}"
                 alt="Ա�����|0|s|50||"/>

        <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')"/>

<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>
              <%=LanguageSupport.getResource("XTGL-1047","��Ա���")%>   
         </font></td>
        <td>
</f:verbatim>
    <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                 readonly="true" value="#{user_regInfoBB.infobo.addType}"
                 alt="��Ա���|0|s|50||"/>
    <h:commandButton type="button" styleClass="button_select"  id="selectType" onclick="selectTypeFun();" />

<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>
                      <%=LanguageSupport.getResource("XTGL-1059"," ��������")%>   
        </font></td>
        <td>
</f:verbatim>
        <h:selectOneMenu value="#{user_regInfoBB.infobo.infolevel}">
            <c:selectItems value="#{user_userInfoBB.selfLevel}"></c:selectItems>
        </h:selectOneMenu>
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>
          <%=LanguageSupport.getResource("XTGL-1169"," ����˵��")%>  ��</font></td>
        <td>
</f:verbatim>
               <h:inputTextarea   value="#{user_regInfoBB.infobo.auditMemo}" rows="6" cols="30"  />
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td colspan="3" align="right">
</f:verbatim>
           <h:commandButton  onclick="return checkReg();" styleClass="button01" value="ͨ��"
            action="#{user_regInfoBB.auditOK}" tabindex="3"/>
           <h:commandButton   styleClass="button01" value="��ͨ��"
             action="#{user_regInfoBB.auditCancel}" tabindex="3"/>
<f:verbatim>
        </td>
    </tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>

