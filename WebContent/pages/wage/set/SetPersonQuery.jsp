<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
    function doQueryManyPerson(){
        var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
        if (reval != null && reval !="") {
            document.all('form1:ManyPerson').value = reval;
            return true;
        } else {
            return false;
        }
    }

    function forAddPerson() {
        if (checkMutilSelect(form1.chk)) {
            revalue = "";
            count = form1.chk.length;
            if (count != null) {
                for (i = 0; i < count; i++) {
                    if (form1.chk[i].checked)
                        revalue += form1.chk[i].value + ",";
                }
            } else
                revalue = form1.chk.value;
            window.returnValue = revalue;
            window.close();
        } else {
            alert("��ѡ����Ա��");
        }
        return false;
    }
    function setValue(){
    	var clipText = window.clipboardData.getData('Text');
    	clipRows = clipText.split(String.fromCharCode(13));
    	var v="";
    	for (i=0; i<clipRows.length; i++) {
    		v+=clipRows[i].split(String.fromCharCode(9))+",";
    	}
    	v=v.substring(0, v.length-1);
    	document.getElementById("username").value=v;
    	return false;
    }
</script>


<x:saveState value="#{wage_personQueryBB}"/>
<h:form id="form1">
    <c:verbatim escape="false"><br></c:verbatim>
    <h:inputHidden id="pageInit" value="#{wage_personQueryBB.pageInit}"/>
    <h:inputHidden id="setId" value="#{wage_personQueryBB.setId}"/>
    <c:verbatim>
    <table height=98% width=98% >
    <tr><td height=8>
    </c:verbatim>
        <h:panelGrid columns="1" width="98%" styleClass="table03" align="center" columnClasses="td_middle">
            <h:panelGrid columns="2" width="100%" >
                <h:panelGrid width="100%"><h:outputText escape="false" value="<strong>��н��λ:</strong>#{wage_personQueryBB.unitName}"/></h:panelGrid>
                <h:panelGrid width="100%"><h:outputText escape="false" value="<strong>��������:</strong>#{wage_personQueryBB.setName}"/></h:panelGrid>
            </h:panelGrid>
            <h:panelGrid align="left" columns="10" cellspacing="0">
                <h:outputText escape="false" value="<strong>������Ա�����</strong>"/>
                <c:verbatim><input id="username" type="text" size="50" alt="����|0" name="form1:nameStr" onkeypress ="enterKeyDown('form1:queryPerson');"></c:verbatim>
                <h:commandButton styleClass="button01" value="ճ��excel����" onclick="return setValue();"/>
                <h:commandButton id="queryPerson" styleClass="button01" value="��ѯ" action="#{wage_personQueryBB.queryPersonByName}" onclick="return forsubmit(form1);"/>
                <h:commandButton styleClass="button01" value="�Զ����ѯ"
                                 action="#{wage_personQueryBB.queryAdvance}"
                                 onclick="return doAdvanceQuery('A','ORG','011','Y','TABLEOBJECT','','N','','Y')"/>
                <h:inputHidden id="ManyPerson" value="#{wage_personQueryBB.nameStrs}"></h:inputHidden>
                <h:commandButton value="���˲�ѯ" id="queryPerson2" onclick="return doQueryManyPerson()" styleClass="button01"
                                 action="#{wage_personQueryBB.queryMultPerson}"/>
                <h:commandButton styleClass="button01" value="δ����������Ա" action="#{wage_personQueryBB.queryNotInWageSetPerson}"/>
                <h:commandButton styleClass="button01" value="����������Ա" rendered="false" action="#{wage_personQueryBB.queryAgentWagePerson}"/>
                <h:commandButton styleClass="button01" value="���ɱ��ո�����Ա" rendered="false" action="#{wage_personQueryBB.queryAgentBenefitPerson}"/>
                <h:commandButton styleClass="button01" value="��ͷ������Ա" rendered="false" action="#{wage_personQueryBB.queryManyHeadPerson}" />
                <h:commandButton styleClass="button01" type="button" value="��������" onclick="return forAddPerson();"/>
            </h:panelGrid>
        </h:panelGrid>
    <c:verbatim>    
    </td>
    </tr>
        
    <tr><td>
    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
        <jsp:param name="hasOperSign" value="true"/>
        <jsp:param name="operSignType" value="checkbox"/>
        <jsp:param name="hasEdit" value="false"/>
        <jsp:param name="isEditList" value="false"/>
        <jsp:param name="isCheckRight" value="false"/>
    </jsp:include>
    </td></tr>
    </table>
    </c:verbatim>
</h:form>
