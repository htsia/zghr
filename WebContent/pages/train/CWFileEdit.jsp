<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <c:verbatim><base target="_self"></c:verbatim>
    <script type="text/javascript">
        function AddAttech() {
            if (document.all('form1:excelFile').value==""){
                alert("��ѡ���ļ�");
                return false;
            }
            return true;
         }
         function doCheck(){
            if (document.all('form1:title').value==""){
                alert("��¼�����!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{train_courceeditbb}"/>
<h:form id="form1" enctype="multipart/form-data">
        <h:inputHidden id="pageInit" value="#{train_courceeditbb.initFile}"/>
<c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td class="td_form01">���</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputHidden value="#{train_courceeditbb.filebo.typeID}" />
                    <h:inputText readonly="true" value="#{train_courceeditbb.filebo.typeName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
            <td class="td_form01">��ʾ��λ��Χ</td>
            <td class="td_form02" >
 </c:verbatim>
                <h:panelGroup>
                    <h:selectOneMenu id="orgID" value="#{train_courceeditbb.filebo.orgID}">
                        <c:selectItems value="#{train_courceeditbb.orgList}"></c:selectItems>
                    </h:selectOneMenu>
                </h:panelGroup>
<c:verbatim>
            </td>

            <tr>
                <td class="td_form01">����</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="title" value="#{train_courceeditbb.filebo.title}"></h:inputText>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">��Чʱ��</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText id="startDate" readonly="true" value="#{train_courceeditbb.filebo.startDate}"></h:inputText>
                    <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:startDate')"/>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01"><img src="/images/common/new.gif" >��ʾ����ʱ��</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="newEndDate" value="#{train_courceeditbb.filebo.newEndDate}"></h:inputText>
                    <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:newEndDate')"/>
<c:verbatim>
                </td>
           </tr>
            <tr>
                <td class="td_form01">����ʱ��</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="endDate" value="#{train_courceeditbb.filebo.endDate}"></h:inputText>
                    <h:commandButton value="" styleClass="button_date" type="button" onclick="PopUpCalendarDialog('form1:endDate')"/>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">�μ��ļ�</td>
                <td class="td_form02" align="left">
</c:verbatim>
                    <h:inputText  style="width:300px" readonly="true" value="#{train_courceeditbb.filebo.fileName}"></h:inputText>
                    <c:verbatim><br></c:verbatim>
                    <x:inputFileUpload id="excelFile"   styleClass="input" value="#{train_courceeditbb.excelFile}"  storage="file" size="25" />
                    <h:commandButton   styleClass="button02" value="�ϴ�" onclick="return AddAttech();" action="#{train_courceeditbb.uploadFile}"/>
<c:verbatim>
                </td>
            </tr>
            <tr>
                 <td class="td_form01">�ۿ���ʽ</td>
                 <td class="td_form02">
</c:verbatim>
                     <h:selectOneMenu value="#{train_courceeditbb.filebo.action}">
                         <c:selectItem itemValue="1" itemLabel="����"></c:selectItem>
                         <c:selectItem itemValue="2" itemLabel="����"></c:selectItem>
                     </h:selectOneMenu>
<c:verbatim>
                 </td>
            </tr>
            <tr>
                 <td class="td_form01">�Ƿ񹫹�</td>
                 <td class="td_form02">
</c:verbatim>
                     <h:selectOneMenu value="#{train_courceeditbb.filebo.publicFlag}">
                         <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
                         <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
                     </h:selectOneMenu>
<c:verbatim>
                 </td>
            </tr>
        </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="����" onclick="return doCheck();" action="#{train_courceeditbb.SaveFile}" styleClass="button01" />
                <h:commandButton value="����"  type="button" onclick="window.close()" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
