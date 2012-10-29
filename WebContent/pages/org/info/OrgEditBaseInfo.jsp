<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String flag = (String) request.getAttribute("flag");
    String changeFlag = CommonFuns.filterNull(request.getParameter("changeFlag"));
    String cancel = request.getParameter("cancel");
    TableVO table = (TableVO) request.getAttribute("table");
    if (table != null) {
        int tableright = table.getPermission();
        if (tableright == TableVO.PERMISSON_REFUSE) {
            //�ܾ���Ȩ��
            out.println("<font color=#0033CC>�Բ�����û��Ȩ�޲鿴��ָ�꼯��</font>");
            return;
        }
    }
%>

<script type="text/javascript">
var info = "";
var xmlHttp;
//����XMLHttpRequest����
function createXMLHttpRequest() {
    if (window.ActiveXObject) {
        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");

    } else if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
    }
}

//У��Ҫ���õ��¼�
function doPost() {
    var queryString = createQueryString();
    createXMLHttpRequest();
    xmlHttp.open("POST", "/pages/ajax/Check.jsp", false);
    xmlHttp.onreadystatechange = handleStateChange;
    xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
    xmlHttp.send(queryString.replace("form1:*", ""));
}
//����������
function createQueryString() {
    var queryString = "";
    var name = "";
    var svalue = "";
    for (i = 0; i < document.forms(0).length; i++) {
        obj = document.forms(0).elements[i];
        name = obj.name;
        if (obj.dict == "yes") {
            svalue = obj.code;
        } else {
            svalue = obj.value;
        }
        if (name != '')
            queryString += name + "=" + svalue + "&";
    }
    queryString += "setId=B001";
    //alert(queryString);
    return queryString;
}
//XMLHttpRequest״̬�ı�ʱҪִ�еĺ���
function handleStateChange() {
    if (xmlHttp.readyState == 4) {
        if (xmlHttp.status == 200) {
            //������xml�ļ��õ��Ľ��,��̬����
            parseResults();
        }
    }
}

//������xml�ļ��õ��Ľ��
function parseResults() {
    var results = xmlHttp.responseXML;
    var orgs = null;
    var trees = results.getElementsByTagName("message");
    for (var i = 0; i < trees.length; i++) {
        orgs = trees[i];
        info = orgs.getElementsByTagName("info")[0].firstChild.nodeValue;
    }
}
//У��
function ajaxCheck() {
    doPost();
    if (info != null && info != "" && info != "no") {
        alert(info);
        return false;
    } else {
        return true;
    }
}


function isnumber(str){
    var number_chars = "1234567890";
    var i;
    for (i = 0; i < str.length; i++)
    {
        if (number_chars.indexOf(str.charAt(i)) == -1) return false;
    }
    return true;
}

function forSelect(form1, rootId) {
    if (rootId == null) {
        rootId = "";
    }
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    if (checkAll(form1)) {
        retval = window.showModalDialog("/employee/SelBackTreePerson.jsf?rootId=" + rootId + "&rightFlag=2", "", "dialogWidth:800px; dialogHeight:700px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
        pageCodeExchange(form1);
        document.all("form1:selPerson").click();
    }
}

function forPer() {
    if (document.all("per").style.display == "none") {
        document.all("per").style.display = "";
        document.forms(0).bper.value = "����ѡ����Ա";
    } else {
        document.all("per").style.display = "none";
        document.forms(0).bper.value = "�鿴ѡ����Ա";
    }
}

function forCheck() {
    return true;
    var B001235 = document.all("form1:B001235").value;
    //ҵ��Ӫ��Χ
    var B001225 = document.all("form1:B001225").value;
    //Ӫҵ��ַ
    var B001240 = document.all("form1:B001240").value;
    //��������
    var B001245 = document.all("form1:B001245").value;
    //ͨѶ��ַ
    var B001249 = document.all("form1:B001249").value;
    //�绰����
    var B001255 = document.all("form1:B001255").value;
    //����������
    var B001230 = document.all("form1:B001230").value;
    //��������
    var orgType = document.all("form1:B001075").code;
    //�������
    var B001205 = document.all("form1:B001205").value;
    var B001265 = document.all("form1:B001265").value;
    var B001201 = document.all("form1:B001201").value;

    if (B001235.trim().length > 500) {
        alert("������Ӫ��Χ�ĳ��Ȳ��ܳ���500");
        return false;
    }
    if (B001240 != null && B001240 != "" && B001240.trim() != "") {
        if (!isnumber(B001240)) {
            alert("�����������Ϊ��λ����");
            return false;
        }
    }
    return true;
}
function forSave() {
    if (ajaxCheck() && forCheck()) {
        document.forms(0).saveFlag.value="1";
        return forsubmit(document.forms(0));
    }

    return false;
}
function forSave1() {
    if (ajaxCheck() && forCheck()) {
        if (document.all("form1:B705701").value == "") {
            alert("�䶯���Ϊ��!")
            return false;
        }
        if (document.all("form1:B705725").value == "") {
            alert("�䶯ʱ�䲻Ϊ��!")
            return false;
        }
        if (document.all("form1:B705720").value == "") {
            alert("�䶯ԭ��Ϊ��!")
            return false;
        }
        if (document.all("form1:B705730").value == "") {
            alert("��׼�ĺŲ�Ϊ��!")
            return false;
        }
        if (document.all("form1:B705733").value == "") {
            alert("��׼��λ��Ϊ��!")
            return false;
        }
        document.forms(0).saveFlag.value="1";
        return forsubmit(document.forms(0));
    }
    return false;
}
</script>

<x:saveState value="#{org_orgEditBaseBB}"/>
<h:form id="form1">
    <f:verbatim>
    <input type="hidden" name="changeFlag" value="<%=changeFlag%>"/>
    <input type="hidden" name="resumeFlag"/>
    <input type="hidden" name="flag" value="1"/>
    <input type="hidden" name="saveFlag"/>
     </f:verbatim>

    <h:inputHidden value="#{org_orgEditBaseBB.dataInit}"/>
    <h:inputHidden id="editRefresh" value="#{org_orgEditBaseBB.editRefresh}"/>
    <h:inputHidden id="orgId" value="#{org_orgEditBaseBB.orgvo.orgId}"/>
    <h:inputHidden value="#{org_orgEditBaseBB.orgchangevo.orgId}"/>
    <h:commandButton id="selPerson" action="#{org_orgEditBaseBB.selPerson}" style="display:none"/>
    <f:verbatim>
    <table width=95% align=center border=0 cellpadding=0 cellspacing=0 class=table03>
    <tr>
        <td height="20" colspan="1" align="left">
            <%=LanguageSupport.getResource("JGGL-1107"," ����������Ϣ ")%>  
         </td>
        <td colspan="3" align="right"> <%=LanguageSupport.getResource("JGGL-1001"," ��������")%>  
    </f:verbatim>
            <h:inputText styleClass="input" id="B001010" readonly="#{!org_orgEditBaseBB.editFlag}" value="#{org_orgEditBaseBB.orgvo.orgCode}" alt="��������|1|s|9||"/>
    <f:verbatim>
        </td>
    </tr>

    <tr nowrap>
        <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1002"," ��������")%></td>
        <td class=td_form02>
    </f:verbatim>
            <h:inputText styleClass="input" id="B001005" readonly="#{!org_orgEditBaseBB.editFlag}" value="#{org_orgEditBaseBB.orgvo.orgName}" alt="��������|0|s|20||"/>
     <f:verbatim>
        </td>
        <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1003"," �������")%></td>
        <td class=td_form02>
     </f:verbatim>
            <h:inputText styleClass="input" id="B001075" code="" dict="yes" dict_num="0891"
                         readonly="true" value="#{org_orgEditBaseBB.orgvo.orgType}" alt="�������|0|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001075')" rendered="#{org_orgEditBaseBB.editFlag}" />
   <f:verbatim>
        </td>
    </tr>

    <tr nowrap>
        <td class="td_form01 "><%=LanguageSupport.getResource("JGGL-1074"," ��������")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001050" code="" dict="yes" dict_num="0895"
                         readonly="true" value="#{org_orgEditBaseBB.orgvo.orgClass}"
                         alt="��������|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001050')" rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
       </td>

        <td class="td_form01 "><%=LanguageSupport.getResource("JGGL-1108"," ע���ַ")%></td>
        <td class=td_form02>
</f:verbatim>
              <h:inputText styleClass="input" id="B001081" readonly="#{!org_orgEditBaseBB.editFlag}" value="#{org_orgEditBaseBB.orgvo.orgRegAddress}" alt="ע���ַ|1|s|20||"/>
<f:verbatim>
        </td>
    </tr>

    <tr nowrap>
        <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1004"," ���ܻ���")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001002" code="" dict="yes" dict_num="OU"
                         readonly="true" value="#{org_orgEditBaseBB.orgvo.superId}"
                         alt="���ܻ���|0|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpOrgDlg('form1:B001002',2,'')"  rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
          </td>

    <td class=td_form01><%=LanguageSupport.getResource("JGGL-1109"," ��������")%></td>
    <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001804" code="" dict="yes" dict_num="0240"
                         readonly="true" value="#{org_orgEditBaseBB.orgvo.orgScale}" alt="��������|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001804')"  rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
    </td>
    </tr>

    <tr nowrap>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1069"," ҵ��Ӫ��Χ")%></td>
        <td class=td_form02 colspan="3">
</f:verbatim>
            <h:inputTextarea rows="3" id="B001084" cols="80" readonly="#{!org_orgEditBaseBB.editFlag}" value="#{org_orgEditBaseBB.orgvo.range}"/>
<f:verbatim>
        </td>
    </tr>

    <tr nowrap>
        <td class="td_form01 "><%=LanguageSupport.getResource("JGGL-1065"," �������ڵ�")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001040" code="" dict="yes" dict_num="0105"
                         readonly="true" value="#{org_orgEditBaseBB.orgvo.orgAddress}" alt="�������ڵ�|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001040')"  rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1066"," ͨ�ŵ�ַ")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001020" value="#{org_orgEditBaseBB.orgvo.postAddress}"   readonly="#{!org_orgEditBaseBB.editFlag}"
                         alt="ͨ�ŵ�ַ|1|s|30||"/>
<f:verbatim>
        </td>
    </tr>
    <tr nowrap>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1110"," ��λ�籣����")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001701" value="#{org_orgEditBaseBB.orgvo.insuraceID}"    readonly="#{!org_orgEditBaseBB.editFlag}"
                         alt="��λ�籣����|1|s|30||"/>
<f:verbatim>
        </td>

        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1111"," ˰��ǼǺ�")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001700" value="#{org_orgEditBaseBB.orgvo.taxID}"   readonly="#{!org_orgEditBaseBB.editFlag}"
                         alt="˰��ǼǺ�|1|s|30||"/>
<f:verbatim>
        </td>

    </tr>
    <tr nowrap>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1067"," ��������")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001015" value="#{org_orgEditBaseBB.orgvo.postCode}" alt="��������|1|s|6||" readonly="#{!org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1068"," �绰����")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001025" value="#{org_orgEditBaseBB.orgvo.phone}" alt="�绰����|1|s|20||" readonly="#{!org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
    </tr>
    <tr nowrap>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1063"," ����������")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001080" value="#{org_orgEditBaseBB.orgvo.manager}" alt="����������|1|s|20||" readonly="#{!org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1064"," ����֯�������")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001083" code="" dict="yes" dict_num="0700" readonly="true"
                         value="#{org_orgEditBaseBB.orgvo.partySetup}" alt="����֯�������|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001083')" rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
    </tr>
    <tr nowrap>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1112"," ���˴���")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001703" value="#{org_orgEditBaseBB.orgvo.lawID}" alt="���˴���|1|s|20||" readonly="#{!org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1113"," �Ǽ�ע�����")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001704" code="" dict="yes" dict_num="0435" readonly="true"
                         value="#{org_orgEditBaseBB.orgvo.registType}" alt="�Ǽ�ע�����|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001704')" rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
    </tr>
    <tr nowrap>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1114"," ��ҵ���")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001705" code="" dict="yes" dict_num="0900" readonly="true"
                         value="#{org_orgEditBaseBB.orgvo.vocation}" alt="��ҵ���|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001705')" rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-0118"," ������ϵ")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001706" code="" dict="yes" dict_num="0420" readonly="true"
                         value="#{org_orgEditBaseBB.orgvo.subordinate}" alt="������ϵ|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001706')" rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
    </tr>
    <tr nowrap>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1115"," ����ƶ����")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001707" code="" dict="yes" dict_num="0710" readonly="true"
                         value="#{org_orgEditBaseBB.orgvo.account}" alt="����ƶ����|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001707')" rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1116"," �ع����")%></td>
        <td class=td_form02>
</f:verbatim>
            <h:inputText styleClass="input" id="B001708" code="" dict="yes" dict_num="0429" readonly="true"
                         value="#{org_orgEditBaseBB.orgvo.control}" alt="�ع����|1|s|50||"/>
            <h:commandButton type="button" styleClass="button_select" onclick="PopUpCodeDlgOneControl('form1:B001708')" rendered="#{org_orgEditBaseBB.editFlag}"/>
<f:verbatim>
        </td>
    </tr>

    <tr nowrap height=170>
        <td class=td_form01><%=LanguageSupport.getResource("JGGL-1117"," ��λ����")%></td>
        <td class=td_form02 colspan="3">
</f:verbatim>
            <h:inputHidden id="orgPhoto" value="#{org_orgEditBaseBB.orgvo.orgPhoto}"/>
<f:verbatim>
            <table width=100%>
                <tr><td>
                    <div id=seryFilterDiv style="display:block" height=140>
                        <img id=showZP  width=110 height=140 alt="��Ƭ">
                    </div>
                    <script type="text/javascript">
                        if (document.all('form1:orgPhoto').value!=''){
                            document.all('seryFilterDiv').style.display="block";
                            document.all('showZP').src="/file/tmp/"+document.all('form1:orgPhoto').value+".JPG";
                        }
                        else{
                           document.all('seryFilterDiv').style.display="none";
                        }
                    </script>
                </td></tr>
                <tr>
                    <td>
                        <iframe name=uploadPhoto frameBorder=0 width=280 height=40 scrolling=no     src='/common/UploadPhoto.jsf?imageItemId=B001082'></iframe>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </table>

    <table width=95% border=0 align=center cellpadding=0 cellspacing=0 whdth='100%'>
        <tr>
            <td align="right">
                <div id="bsave" align="right">
</f:verbatim>
                <h:commandButton id="save" styleClass="button01" value="����" action="#{org_orgEditBaseBB.saveOrgBaseInfo}"  rendered="#{org_orgEditBaseBB.editFlag}" onclick="return forSave()"/>
<f:verbatim>
                </div>
            </td>
       </tr>
    </table>

    <div id="show" <%if ("show".equals(flag)) {%>
         style="display:block" <%} else {%> style="display:none"<%}%>>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0 class=table03>

            <tr nowrap>
                <td width="90" class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1014"," �䶯���")%></td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="B705701" dict="yes" code="" dict_num="0890"
                                 readonly="true" value="#{org_orgEditBaseBB.orgchangevo.changeType}"
                                 alt="�䶯���|1|s|50||"/>
<f:verbatim>
                <input type="button" class="button_select" onclick="PopUpCodeDlgOneControl('form1:B705701')"></td>
                <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1015"," �䶯ʱ��")%></td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="B705725" value="#{org_orgEditBaseBB.orgchangevo.changeTime}"
                                 alt="�䶯ʱ��|1|s|50||"/>
<f:verbatim>
                    <input type="button" class="button_select"  onclick="PopUpCalendarDlg_OnlyMonth('form1:B705725')"></td>

            </tr>
            <tr nowrap>
                <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1118"," �䶯ԭ��")%></td>
                <td class=td_form02 colspan="3">
</f:verbatim>
                    <h:inputText styleClass="input" id="B705720" value="#{org_orgEditBaseBB.orgchangevo.changeResult}"
                                 alt="�䶯ԭ��|1|s|60||"/>
<f:verbatim>
                </td>
            </tr>
            <tr nowrap>
                <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1017"," ��׼�ĺ�")%></td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="B705730" value="#{org_orgEditBaseBB.orgchangevo.changeNo}"
                                 alt="��׼�ĺ�|1|s|50||"/>
<f:verbatim>
                </td>
                <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("JGGL-1018"," ��׼��λ")%></td>
                <td class=td_form02>
</f:verbatim>
                    <h:inputText styleClass="input" id="B705733" value="#{org_orgEditBaseBB.orgchangevo.agreeUnit}"
                                 alt="��׼��λ|1|s|50||"/></td>
<f:verbatim>
            </tr>
        </table>
    </div>
    <br>
</f:verbatim>
</h:form>

<f:verbatim>
<script type="text/javascript">
    interpret(document.forms(0));
    if (document.all("form1:editRefresh").value == "1") {
        if (parent.document.all("show")!=null){
            parent.document.all("show").innerText = document.all("form1:B001005").value;
        }
        var flag = parent.opener.document.all("refreshFlag").value;
        if(flag == "1"){
             var superId = parent.opener.document.all("refreshId").value;
             parent.opener.parent.main.location.href =" /org/info/OrgInfoQuery.jsf?flag=1&pageFlag=2&superId="+superId;
        }else{
        parent.opener.document.all("form1:queryOrg").click();
       }
    }
</script>
</f:verbatim>