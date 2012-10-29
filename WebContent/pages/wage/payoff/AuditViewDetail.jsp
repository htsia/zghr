<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
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
       showProcessBar();
       return true;
   } else {
       return false;
   }
}

function showProcessBar() {
   x = document.body.clientWidth / 2 - 150;
   y = document.body.clientHeight / 2;
   document.all('processbar').style.top = y;
   document.all('processbar').style.left = x;
   document.all('processbar').style.display = "";
}

function Cancelmark(){
         count = form1.chk.length;
         var str = "";
         if (count != null) {
             var num = 0;
             for (i = 0; i < count; i++)
                 if (form1.chk[i].checked) {
                     str += form1.chk[i].value.replace("#","~") + ",";
                     num++;
                 }
             if (num > <%=Constants.ACTIVE_PAGE_SIZE%>) {
                 alert("���ֻ��ѡ��<%=Constants.ACTIVE_PAGE_SIZE%>����Ա");
                 return false;
             }
         } else
             str = form1.chk.value.replace("#","~");
         if (str==""){
             alert("��ѡ����Ա!");
             return false;
         }
         document.all("form1:str").value=str;
         return true;
     }

     function markQestion(){
        count = form1.chk.length;
        var str = "";
        if (count != null) {
            var num = 0;
            for (i = 0; i < count; i++)
                if (form1.chk[i].checked) {
                    str += form1.chk[i].value.replace("#","~") + ",";
                    num++;
                }
            if (num > <%=Constants.ACTIVE_PAGE_SIZE%>) {
                alert("���ֻ��ѡ��<%=Constants.ACTIVE_PAGE_SIZE%>����Ա");
                return false;
            }
        } else
            str = form1.chk.value.replace("#","~");
         if (str==""){
             alert("��ѡ����Ա!");
             return false;
         }

        var url="/wage/payoff/MaskQuestion.jsf?dateId="+document.all("form1:dateId").value+"&setId="+document.all("form1:setId").value
                 +"&setName="+form1.all("form1:setName").value+"&pids="+str;

        window.showModalDialog( url, null, "dialogWidth:400px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;
    }
    function OpenRptByDept(){
        var str = "";
        if (form1.chk!=null){
            count = form1.chk.length;
            if (count != null) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        str += form1.chk[i].value.replace("#","~") + ",";
                        num++;
                    }
                if (num > <%=Constants.ACTIVE_PAGE_SIZE%>) {
                    alert("���ֻ��ѡ��<%=Constants.ACTIVE_PAGE_SIZE%>����Ա");
                    return false;
                }
            } else
                str = form1.chk.value.replace("#","~");
        }
        var url="/report/DeptReportShow.jsf?unitId="+document.all("form1:unitId").value+"&setId=DATE_"+document.all("form1:dateId").value
                 +"&setName="+form1.all("form1:setName").value+"&pids="+str;
        window.showModalDialog( url, null, "dialogWidth:400px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
        return true;// ����true �Ա����½��� �Ӷ��õ�����Ȩ��session
    }

    function showPerson(){
        var ID=getFirstSelectValue(form1.chk);
        if (ID==null || ""==ID){
           alert("��ѡ����Ա��");
        }
        else{
           forViewPersonDetail(ID);
        }
        return false;
    }
    function beginClass(){
        if (document.all("form1:sortList").value=="-1") {
            alert("û��ѡ�������Ϣ��");
        }
        else{
           window.showModalDialog("/wage/payoff/AuditShowClass.jsf?dateId="+form1.all("form1:dateId").value+"&SetId=" + form1.all("form1:setId").value+"&GroupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        return false;
    }

    function beginGroup(){
        if (document.all("form1:sortList").value=="-1") {
            alert("û��ѡ�������Ϣ��");
        }
        else{
           window.showModalDialog("/wage/payoff/AuditShowGroup.jsf?dateId="+form1.all("form1:dateId").value+"&SetId=" + form1.all("form1:setId").value+"&GroupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        return false;
    }

    function forViewPerson(form, id, type){
        window.showModalDialog("/wage/payoff/wagePersonquery.jsf?setID="+form1.all("form1:setId").value+"&showCur=true&pID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
    }

    function showdiff(){
        var url="/wage/payoff/ShowDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
        window.open(url,'','toolbar=0,height=460,width=800,top=40,left=40');
        return false;
    }
    function showDeptdiff(){
        var url="/wage/payoff/ShowDeptDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
        window.open(url,'','toolbar=0,height=460,width=800,top=40,left=40');
        return false;
    }

    function doViewCard(){
        var ID=getFirstSelectValue(form1.chk);
        //debugger;
        if (ID!=null && ID!=""){
           window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value+"&ID="+ID, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        }else{
           window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
        }
        return false;
    }
    function doShowItem() {
        var arg = "setId=" + form1.all("form1:setId").value;
        var reval = window.showModalDialog("/wage/payoff/ComputeShowItemEdit.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
        if (reval != null) {
            form1.all('form1:str').value = reval;
            return true;
        } else {
            return false;
        }
    }
    function doExport() {
       window.open('/wage/payoff/SetSelectToExport.jsf');
    }
</script>

<x:saveState value="#{wage_computeBB}"/>
<x:saveState value="#{wage_dateBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_computeBB.auditView}"/>
    <h:inputHidden id="setId" value="#{wage_computeBB.setId}"/>
    <h:inputHidden id="setName" value="#{wage_computeBB.setName}"/>
    <h:inputHidden id="unitId" value="#{wage_computeBB.unitId}"/>
    <h:inputHidden id="dateId" value="#{wage_computeBB.dateId}"/>
    <h:inputHidden id="str" value=""/>
    <h:inputHidden id="ManyPerson" value="#{wage_computeBB.manyPerson}"/>

    <f:verbatim>
    <table width=98% cellspacing="0" align="center">
       <tr>
       <td class="td_title">
    </f:verbatim>
           <h:graphicImage value="/images/tips.gif" />
           <h:outputText escape="false" value="���ף�#{wage_computeBB.setName}&nbsp;&nbsp;"/>
           <h:outputText escape="false" value="��нʱ�䣺#{wage_computeBB.payoffDate}&nbsp;&nbsp;&nbsp;"/>
           <h:outputText value="��н״̬��#{wage_computeBB.stautsdes}"/>
     <f:verbatim>
       </td>

       <td class="td_title" align="right">
    </f:verbatim>
            <h:outputText escape="false" value="<font color=red>��������:#{wage_computeBB.errData}</font>"></h:outputText>
            <h:outputText escape="false" value="<font color=red>δ������������:#{wage_computeBB.notAnswererrData}</font>"></h:outputText>
            <h:commandButton value="����" type="button" onclick="window.close()" styleClass="button01" />
<f:verbatim>
       </td>
       <tr>
    </table>
    
    <table height=93% width=100%>
     <tr><td height=8>
        <table>
            <tr>
             <td>
</f:verbatim>
                 <h:outputText value="��������:" />
                 <h:inputText value="" id="nameStr" style="width:100px"/>
                 <h:commandButton value="��ѯ" action="#{wage_computeBB.queryPersonByNameStr}" styleClass="button01"/>
                 <h:commandButton value="���˲�ѯ" action="#{wage_computeBB.queryMultiPerson}" onclick="doQueryManyPerson();" styleClass="button01"/>
                 <h:commandButton value="��ӡ��ϸ" type="button" styleClass="button01" onclick="return OpenRptByDept();"></h:commandButton>
<f:verbatim>
             </td>

            <td>
</f:verbatim>
                <h:selectOneMenu id="sortList" value="#{wage_computeBB.sortField}">
                   <c:selectItems value="#{wage_computeBB.sortList}"></c:selectItems>
                </h:selectOneMenu>
                <h:outputText value="����" ></h:outputText>
                <h:selectBooleanCheckbox value="#{wage_computeBB.bysort}"></h:selectBooleanCheckbox>
                <h:commandButton value="����" type="button" styleClass="button01" onclick="return beginGroup();"/>
                <h:commandButton value="����" type="button" styleClass="button01" onclick="return beginClass();"/>
<f:verbatim>
            </td>

            <td>
</f:verbatim>
                <h:commandButton value="��Ա��Ϣ" type="button" styleClass="button01" onclick="return showPerson();"></h:commandButton>
                <h:commandButton value="��ʾ��Ƭ" type="button" styleClass="button01" onclick="return doViewCard();"></h:commandButton>
                <h:commandButton value="����Excel" type="button" onclick="doExport();" styleClass="button01"/>
<f:verbatim>
           </td>
          </tr>
        </table>
    </td> </tr>

    <tr><td height=8>        
        <table><tr>
            <td>
</f:verbatim>
                <h:selectOneMenu id="groupLevel" value="#{wage_computeBB.groupLevel}">
                    <c:selectItem itemValue="DEPT_NAME" itemLabel="��ϸ���"></c:selectItem>
                    <c:selectItem itemValue="HIGH_NAME" itemLabel="����1"></c:selectItem>
                    <c:selectItem itemValue="HIGH_NAME2" itemLabel="����2"></c:selectItem>
                    <c:selectItem itemValue="HIGH_NAME3" itemLabel="����3"></c:selectItem>
                    <c:selectItem itemValue="HIGH_NAME4" itemLabel="����4"></c:selectItem>
                </h:selectOneMenu>
                <h:commandButton value="ѡ��" styleClass="button01" action="#{wage_computeBB.changeLevel}"></h:commandButton>
                <h:selectOneMenu id="WageDept"  value="#{wage_computeBB.dept}">
                   <c:selectItems value="#{wage_computeBB.deptList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01"value="����" action="#{wage_computeBB.queryPersonByDept}" onclick="showProcessBar();"></h:commandButton>
<f:verbatim>
            </td>

            <td>
</f:verbatim>
                <h:commandButton value="ȡ�����"  styleClass="button01" onclick="return Cancelmark();" action="#{wage_computeBB.cancelMask}" rendered="#{wage_computeBB.stautsdes!='����'}"/>
                <h:commandButton value="�������"  styleClass="button01" onclick="return markQestion();" rendered="#{wage_computeBB.stautsdes!='����'}" action="#{wage_computeBB.queryPersonByDept}"/>
                <h:commandButton value="��ѯδ��������"  styleClass="button01" action="#{wage_computeBB.queryQestion}"/>
                <h:commandButton value="��ѯ��������"  styleClass="button01" action="#{wage_computeBB.queryAllQestion}"/>
<f:verbatim>
            </td>

            <td>
</f:verbatim>
            <h:commandButton value="��Ա�Ա�" rendered="#{wage_computeBB.canComputer}" styleClass="button01" type="button"
                              onclick="showdiff();return false;"/>
            <h:commandButton value="���ŶԱ�" rendered="#{wage_computeBB.canComputer}" styleClass="button01" type="button"
                              onclick="showDeptdiff();return false;"/>

                <h:selectOneMenu id="condition"  value="#{wage_computeBB.qryID}">
                   <c:selectItems value="#{wage_computeBB.displaySetList}"></c:selectItems>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" value="����" action="#{wage_computeBB.queryByCondition}"></h:commandButton>
<f:verbatim>
            </td>
        </tr>
        </table>
    </td> </tr>
        
    <tr><td>
        <jsp:include page="/pages/common/activepage/ActiveList.jsp">
            <jsp:param name="hasOperSign" value="true"/>
            <jsp:param name="operSignType" value="checkbox"/>
            <jsp:param name="hasEdit" value="true"/>
            <jsp:param name="isEditList" value="false"/>
            <jsp:param name="isCheckRight" value="true"/>
            <jsp:param name="isForward" value="true"/>
            <jsp:param name="isRow" value="true"/>
            <jsp:param name="rowFuncName" value="forViewPerson"/>
            <jsp:param name="isPage" value="true"/>
            <jsp:param name="fixcol" value="6"/>
            <jsp:param name="maskError" value="true"/>
        </jsp:include>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
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
        </tr>
    </table>
</marquee>
