<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ include file="../../include/taglib.jsp" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    // Ա�����
    String A001054=request.getParameter("A001054");
    // Ա�����
    String A001031=request.getParameter("A001031");
    // ��Ա���
    String A016010=request.getParameter("A016010");
%>
<base target="_self">
<script type="text/javascript">
function forCheck() {
    return true;
    var party = document.all("form1:A001009").code;
    //������ò
    var ccp = document.all("form1:A001708").code;
    //��������֯
    var birth = document.all("form1:A001011").value;
    //��������
    var status = document.all("form1:A001725").code;
    //��ǰ״̬
    var homeTown = document.all("form1:A001014").value;
    //����
    var postType = document.all("form1:A001712").code;
    //��λ���
    var birthTowm = document.all("form1:A001017").value;
    //������
    var folk = document.all("form1:A001021").value;
    //����
    var idCard = document.all("form1:A001077").value;
    //���֤��
    var residence = document.all("form1:A001071").value;
    //�������ڵ�
    var personType = document.all("form1:A001054").code;
    //Ա�����
    var partyTime = document.all("form1:A001718").value;
    //�μӵ���ʱ��
    var workTime = document.all("form1:A001041").value;
    //�μӹ���ʱ��
    var sysTime = document.all("form1:A001044").value;
    //����ϵͳʱ��
    var unitTime = document.all("form1:A001781").value;
    var addTime = document.all("form1:A016020").value;
    //��Աʱ��

    var dt = new Date();

    if (idCard.trim() != "") {
        if (!(idCard.trim().length == 15 || idCard.trim().length == 18)) {
            alert("���֤��ӦΪ15λ����18λ!");
            return false;
        }
    }

    if (idCard.trim() != "") {
        var tmpCard ;
        if (idCard.length == 15) {
            tmpCard = "19" + idCard.substring(6, 12);
        }
        if (idCard.length == 18) {
            tmpCard = idCard.substring(6, 14);
        }
        var tmpBirth = birth.replace(/\-/g, "");
        if (tmpCard != tmpBirth) {
            alert("���֤�źͳ������ڲ�ƥ��!");
        }
    }
    return true;
}

function forSave() {
    if (forCheck()) {
        return forsubmit(document.forms(0));
    }
    return false;
}

function selSysTime() {
    PopUpCalendarDlg_OnlyMonth("form1:A001044");
    document.all("form1:A016020").value = document.all("form1:A001044").value;
}
</script>


<body>
<x:saveState value="#{emp_personAddBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden   value="#{emp_personAddBB.pageInit}"></h:inputHidden>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 
                                      
         <%=LanguageSupport.getResource("RYGL-2404","�����û� ") %>
               </td>
            <td class="td_title" align="right">
                <%
                    if ("1".equals(Constants.AUTO_CACL_BIRTH)) out.println(LanguageSupport.getResource("RYGL-2328","�������֤�����Ա�/��������:���� "));
                    else out.println(LanguageSupport.getResource("RYGL-2329","�������֤�����Ա�/��������:�ر�"));
                %>
                &nbsp;&nbsp;
                <font color="red">
                <%
                    if ("1".equals(Constants.EMP_ADD_AFTER_APPROVE)) out.println(LanguageSupport.getResource("XTGL-1035","ע�⣺������Ա�����������Ч"));
                %>
                </font>
                
            </td>
        </tr>
    </table>
    <br>

    <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
        <tr nowrap>
            <td align="left">
                <%=LanguageSupport.getResource("RYGL-2405","��½��") %>
                <h:inputText styleClass="input" id="A001735" value="#{emp_personAddBB.personvo.personCode}" alt="Ա�����|1|s|50||"/>
            </td>
            <td align="right">
                <h:commandButton value=" ���� " onclick="javascript:return forSave()" styleClass="button01"   action="#{emp_personAddBB.createUser}"/>
                <h:commandButton value=" ȡ�� " styleClass="button01"   type="button" onclick="window.close();"  ></h:commandButton>
            </td>
        </tr>
    </table>

    <table width=95% align=center border=0 cellpadding=0 cellspacing=0 class="table03">
    <tr nowrap>
        <td class="td_form01 td_form_required" width="120"><%=LanguageSupport.getResource("MSG-0010","����") %></td>
        <td class="td_form02">
            <h:inputText styleClass="input" id="A001001" value="#{emp_personAddBB.personvo.name}" alt="����|0|s|50||"/>
        </td>
        <td width="15%" class="td_form01 "><%=LanguageSupport.getResource("MSG-0012","�Ա�") %></td>
        <td class=td_form02 width="30%">
            <h:inputText styleClass="input" id="A001007" code="" dict="yes" dict_num="0100"
                         readonly="true" value="#{emp_personAddBB.personvo.sex}"
                         alt="�Ա�|1|s|50||"/>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001007')">
        </td>
    </tr>

       <tr nowrap>
            <td class=td_form01><%=LanguageSupport.getResource("RYGL-1015","���֤��") %></td>
            <td class=td_form02>
                <h:inputText styleClass="input" id="A001077"  size="22"
                             value="#{emp_personAddBB.personvo.idNum}"
                             alt="���֤��|1|s|50||"/>
            </td>
           <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2063","���ڲ���") %></td>
           <td class=td_form02>
             <h:inputText styleClass="input" id="A001705" code="" dict="yes" dict_num="OU"
                          readonly="true" value="#{emp_personAddBB.personvo.deptId}"
                          alt="���ڲ���|0|s|50||"/>
             <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A001705',2)">
            </td>
        </tr>

    <tr nowrap>
        <td class="td_form01 "><%=LanguageSupport.getResource("MSG-0013","��������") %></td>
        <td class=td_form02>
            <h:inputText styleClass="input" id="A001011" value="#{emp_personAddBB.personvo.birth}"
                         readonly="true" alt="��������|1|d|50||"/>
            <input type="button" class="button_select" onclick="PopUpCalendarDialog('form1:A001011')">
        </td>
        <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("XTGL-1044","Ա�����") %></td>
        <td class=td_form02>
            <h:inputText styleClass="input" id="A001054" code="" dict="yes" dict_num="0135"
                         readonly="true" value="#{emp_personAddBB.personvo.personType}"
                         alt="Ա�����|0|s|50||"/>
            <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:A001054')">
        </td>
    </tr>
    </table>

</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>
</body>

