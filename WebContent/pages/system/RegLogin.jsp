<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<script type="text/javascript">
    function selectTypeFun(){
       PopUpCodeDlgOneControl('form1:A016010','0200110001');
    }
    function checkLogin(){
        var idCard = document.all("form1:loginName").value;
        if (idCard.trim() == "") {
            alert("���������֤��!");
            return false;
        }
        if (idCard.trim() != "") {
            if (!(idCard.trim().length == 15 || idCard.trim().length == 18)) {
                alert("���֤��ӦΪ15λ����18λ!");
                return false;
            }
        }
        if (document.all('form1:password').value==''){
            alert("���������룡")
            return false;
        }
        return true;
    }
    function checkReg(){
        var idCard = document.all("form1:loginName").value;
        if (idCard.trim() == "") {
            alert("���������֤��!");
            return false;
        }
        if (idCard.trim() != "") {
            if (!(idCard.trim().length == 15 || idCard.trim().length == 18)) {
                alert("���֤��ӦΪ15λ����18λ!");
                return false;
            }
        }
        if (document.all('form1:password').value==''){
            alert("���������룡")
            return false;
        }
        if (document.all('form1:password').value!=document.all('form1:repassword').value){
            alert("�����������벻��ͬ��")
            return false;
        }

        return forsubmit(document.forms(0));
    }
</script>
<x:saveState value="#{user_regInfoBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{user_regInfoBB.pageInit}"></h:inputHidden>
<f:verbatim>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" background="/images/maininterface/hd_top.jpg" style="backgroud:#1F93B8">
    <tr>
        <td width="40" height="58">&nbsp;</td>
        <td  ><img src="/images/maininterface/logo.jpg" align="left" alt="">
            <span style="font-size:30px; color:#ffffff; line-height:43px; font-weight:bold; padding-left:0px; padding-top:15px; height:43px; width:320px;"><%=Constants.TITLE_NAME%></span>
       </td>
  </tr>
  </table>
   
    <table align="center"  width='500' cellspacing=0 cellpadding=0 border=0>
    <tr><td colspan="2" height=30></td></tr>
    <tr><td colspan="2">
      <%=LanguageSupport.getResource("XTGL-1252", "��������Ҫ������Ա����ְ��")%><br>
      <%=LanguageSupport.getResource("XTGL-1253", "ע��������ͨ���󣬼���ʹ�����֤�������¼")%><br>
      <%=Constants.SYSTEM_NAME%><br>
      <%=LanguageSupport.getResource("XTGL-1254", "����鿴���Բ�ѯ��ǰ״̬")%><br>
    </td></tr>
    <tr><td colspan="2" height=20><hr></td></tr>

    <tr>
    <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;
          <%=LanguageSupport.getResource("XTGL-1043", "���֤")%><br>
     </font></td>
        <td>
</f:verbatim>
            <h:inputText id="loginName" styleClass="inputDark" alt="���֤|0|s|50"
                         value="#{user_regInfoBB.infobo.cardID}" size="22" tabindex="1"/>
             
                  <f:verbatim>
                         <%=LanguageSupport.getResource("XTGL-1255", "<-�������������֤��")%>:
                  </f:verbatim>         
<f:verbatim>
        </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;
                                <%=LanguageSupport.getResource("XTGL-1256", "�ܡ���")%>:
           </font></td>
        <td>
</f:verbatim>
        <h:inputSecret id="password" styleClass="inputDark" alt="����|0|s|50"     value="#{user_regInfoBB.infobo.passwd}" size="22" tabindex="2"/>
        <f:verbatim>
              <%=LanguageSupport.getResource("XTGL-1257", "<-��������������")%>:
        </f:verbatim>       
        <h:commandButton  onclick="return checkLogin();" styleClass="button01" value="�鿴"
                    action="#{user_regInfoBB.login}" tabindex="3"/>
<f:verbatim>
       </td>
    </tr>

    <tr ><td colspan="2" height=20></td></tr>
    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;
                 <%=LanguageSupport.getResource("XTGL-1051", "״  ̬")%>:
        </font></td>
        <td>
</f:verbatim>
       <h:outputText value="#{user_regInfoBB.infobo.statusDes}"></h:outputText> 
        <f:verbatim>
              <%=LanguageSupport.getResource("XTGL-1258", "<-��ʼ�� �ȴ���� ���ͨ�������Ե�¼ϵͳ ���δͨ������Ч����")%>:
        </f:verbatim>       
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;
           <%=LanguageSupport.getResource("XTGL-1259", "˵  ��")%>:
        </font></td>
        <td>
</f:verbatim>
       <h:outputText value="#{user_regInfoBB.infobo.auditMemo}"></h:outputText> 
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>&nbsp;
         <%=LanguageSupport.getResource("MSG-0010", "   ��  ��")%>:
              </font></td>
        <td>
</f:verbatim>
        <h:inputText id="name" styleClass="inputDark" alt="����|0|s|50"     value="#{user_regInfoBB.infobo.name}" size="22" tabindex="2"/>
      
      
        <h:outputText value="<-�������ע�ᣬ��������������"></h:outputText>
<f:verbatim>
       </td>
    </tr>


    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>�������룺</font></td>
        <td>
</f:verbatim>
        <h:inputSecret id="repassword" styleClass="inputDark" alt="����|0|s|50"     value="#{user_regInfoBB.repassword}" size="22" tabindex="2"/>
        <h:outputText value="<-�������ע�ᣬ���ٴ�������������"></h:outputText>
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>���ڲ��ţ�</font></td>
        <td>
</f:verbatim>
        <h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
                     readonly="true" value="#{user_regInfoBB.infobo.deptid}"
                     alt="���ڲ���|0|s|50||"/>
        <h:commandButton type="button" styleClass="button_select" onclick="PopUpOrgDlg('form1:A001705',0)"/>
        <h:outputText value="<-�������ע�ᣬ��ѡ���������ڲ���"></h:outputText>
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>����ʱ�䣺</font></td>
        <td>
</f:verbatim>
        <h:inputText styleClass="input" id="A016020" value="#{user_regInfoBB.infobo.enterTime}"  readonly="true" alt="����ʱ��|0|d|50||"/>
        <h:commandButton type="button" styleClass="button_select" onclick="PopUpCalendarDialog('form1:A016020');"/>

        <h:outputText value="<-�������ע�ᣬ��¼�뱨��ʱ��"></h:outputText>
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>Ա�����</font></td>
        <td>
</f:verbatim>
       <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                 readonly="true" value="#{user_regInfoBB.infobo.personType}"
                 alt="Ա�����|0|s|50||"/>

        <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')"/>
         <f:verbatim>
              <%=LanguageSupport.getResource("XTGL-1260", "<-�������ע�ᣬ��¼��Ա�����")%>:
        </f:verbatim>    
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td align="right"><font color=<%=Constants.LOGIN_FONT_COLOR%>>
         <%=LanguageSupport.getResource("XTGL-1047", "��Ա���")%>:
                        </font></td>
        <td>
</f:verbatim>
    <h:inputText styleClass="input" id="A016010" code="" dict="yes" dict_num="0200"
                 readonly="true" value="#{user_regInfoBB.infobo.addType}"
                 alt="��Ա���|0|s|50||"/>
    <h:commandButton type="button" styleClass="button_select"  id="selectType" onclick="selectTypeFun();" />
        
          <f:verbatim>
              <%=LanguageSupport.getResource("XTGL-1261", "<-�������ע�ᣬ��¼����Ա���")%>:
        </f:verbatim>    
<f:verbatim>
       </td>
    </tr>

    <tr>
        <td colspan="3" align="right">
</f:verbatim>
           <h:commandButton  onclick="return checkReg();" styleClass="button01" value="��ע��"
            action="#{user_regInfoBB.newreg}" tabindex="3"/>

<f:verbatim>
        </td>
    </tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>

