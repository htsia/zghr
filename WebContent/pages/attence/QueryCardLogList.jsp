<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
function doWork() {
    window.showModalDialog("/attence/RollbookRegistrationList.jsf", null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
    return true;
}

function checkDateAndDelete(){
    var endDate = document.all("form1:endTime").value;
    var startDate = document.all("form1:beginTime").value;
    var name = document.all("form1:name").value;
    if(startDate==null||startDate==""||endDate==null||endDate==""){
        alert("������ɾ���Ŀ�ʼʱ������ʱ��");
        return false;
    }else if(startDate>endDate){
        alert("ɾ���Ŀ�ʼʱ�����ڽ���ʱ��");
        return false;
    }
    var names="";
    if(name!=null && name!=""){
       names="[������Ա�����Ϊ��"+name+"] ";
    }
    if(confirm('ȷ��Ҫɾ��'+names+'['+startDate+'~'+endDate+']֮���������?')){
        return true;
    }else{
        return false;
    }
    return true;
 }

    function checkDate(){
    var endDate = document.all("form1:endTime").value;
    var startDate = document.all("form1:beginTime").value;
    if(startDate==null||startDate==""||endDate==null||endDate==""){
        alert("�����뿪ʼʱ��ͽ���ʱ��");
        return false;
    }else if(startDate>endDate){
        alert("��ʼʱ�����ڽ���ʱ��");
        return false;
    }
    return true;
 }

    function forSel() {
        if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135","")){
           document.forms(0).all('form1:queryPerson').click();
        }
    }
</script>
<x:saveState value="#{querycardlogBB}"/>
    <h:form id="form1">
        <h:inputHidden id="pageInit" value="#{querycardlogBB.pageInit}"/>
        <h:inputHidden id="personList" value="#{querycardlogBB.personList}"/>
        <h:inputHidden id="superId" value="#{querycardlogBB.superId}"/>
        <h:inputHidden id="personType" value="#{querycardlogBB.personType}"/>
        <h:inputHidden id="personTypeValue" value="#{querycardlogBB.personTypeValue}"/>
     <f:verbatim>
        <input type="hidden" name="sessionFlag" value="2">
        <table id=t1 height=98% width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td class="td_page" height=8>
                <input name="simple1" type="button" id=15 next=20 class="button01" value="ѡ����Ա���" onclick="forSel()">
                </f:verbatim>
                <h:outputText value="#{querycardlogBB.personTypeDesc}"></h:outputText>
                <f:verbatim>
              </td>
            </tr>
            <tr>
                <td class="td_page" height=8>
       </f:verbatim>
                    <h:outputText value="������Ա����ţ�"></h:outputText>
                    <h:inputText id="name" value="#{querycardlogBB.name}"
                                    size="10" styleClass="input" onkeypress ="enterKeyDown('form1:queryPerson')" />
                   						<h:outputText value="��ʼ���ڣ�" />
						<h:inputText styleClass="input" id="beginTime" size="12"
							alt="��ʼʱ��|0|d" value="#{querycardlogBB.beginTime}"
							readonly="true" />
						<f:verbatim>
							<input type="button" class="button_select"
								onclick="PopUpCalendarDialog('form1:beginTime')">
						</f:verbatim> 
                    	<h:outputText value="--" />
						<h:inputText styleClass="input" id="endTime" alt="����ʱ��|0|d"
							size="12" value="#{querycardlogBB.endTime}" readonly="true" />
						<f:verbatim>
							<input type="button" class="button_select"
								onclick="PopUpCalendarDialog('form1:endTime');">
						</f:verbatim>
                        <h:outputText value="��λ���ƣ�" />
						<h:inputText value="#{querycardlogBB.popuppostid}"></h:inputText>
                        <h:outputText value="�����ͣ�"/>
                        <h:selectOneMenu value="#{querycardlogBB.cardtype}">
                            <c:selectItem itemLabel="ȫ��" itemValue="NO"></c:selectItem>
                            <c:selectItem itemLabel="����" itemValue="00900"></c:selectItem>
                            <c:selectItem itemLabel="����" itemValue="00901"></c:selectItem>
                        </h:selectOneMenu>
                    <h:commandButton value="��ѯ" id="queryPerson"  styleClass="button01" onclick="return checkDate();" action="#{querycardlogBB.queryPerson}"/>
                    <h:commandButton value="ɾ��" styleClass="button01" onclick="return checkDateAndDelete();" action="#{querycardlogBB.delete}"/>
                    <h:commandButton value="����" styleClass="button01" onclick="return doWork();"/>
       <f:verbatim>
                </td>

                <td class="td_page" height=8></td>
            </tr>

            <tr><td colspan=2>
                <jsp:include page="../common/activepage/ActiveList.jsp">
                    <jsp:param name="hasOperSign" value="true"/>
                    <jsp:param name="operSignType" value="checkbox"/>
                    <jsp:param name="hasEdit" value="true"/>
                    <jsp:param name="isEditList" value="false"/>
                    <jsp:param name="isCheckRight" value="true"/>
                    <jsp:param name="isForward" value="true"/>
                    <jsp:param name="isRow" value="false"/>
                    <jsp:param name="isPage" value="true"/>
                </jsp:include>
            </td></tr>
        </table>
       </f:verbatim>
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>