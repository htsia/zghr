<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forPerson() {
            var reval = window.showModalDialog("/wage/base/QueryNotePerson.jsf?act=forQuery", null, "dialogWidth:700px; dialogHeight:400px;dialogLeft:250px; dialogTop:250px;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                document.all('form1:ids').value = reval.split("||")[0];
                document.all('form1:name').value = reval.split("||")[1];
            }
            return false;
        }
        function forsave(){
            if(checkMutilSelect(form1.all('form1:userSelect'))){
                if(forsubmit(form1)){
                    if(confirm("确定要保存吗？"))
                        return true;
                    else
                        return false;
                }else{
                    return false;
                }
            }else{
                alert('必须选择相关账套');
                return false;
            }
            return false;
        }
        function chkType(){
            var type = document.getElementsByName('form1:type');
            if(type[1].checked==true){
               document.all('form1:selPer').disabled =false;
               document.all('form1:name').alt ="姓名|0|s";
            }else {
               document.all('form1:selPer').disabled =true;
               document.all('form1:name').alt="姓名|1|s";
               document.all('form1:ids').value="";
            }
        }
    </script>

<x:saveState value="#{wage_noteBB}"/>

<h:form id="form1">
    <h:inputHidden value="#{wage_noteBB.pageInit}"/>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value="薪酬管理 -> 员工薪资变动"/>
       </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="2" width="80%" align="center"  columnClasses="td_form01,td_form02" styleClass="table03">
        <h:outputText value="发薪单位"/>
        <h:outputText value="#{wage_noteBB.unitName}"/>

        <h:outputText value="变动日期"/>
        <h:panelGroup>
            <h:inputText id="date" value="#{wage_noteBB.note.date}" alt="变动日期|0|d"/>
            <h:outputText value=" "/>
            <h:commandButton type="button" styleClass="button_date" onclick="PopUpCalendarDialog(form1.all('form1:date'))"/>
        </h:panelGroup>

        <h:outputText value="操作方式"/>
        <h:panelGroup>
            <h:selectOneRadio id="type" value="#{wage_noteBB.opType}" onclick="chkType();">
                <c:selectItem itemValue="0" itemLabel="部分人员"/>
                <c:selectItem itemValue="1" itemLabel="全部人员"/>
            </h:selectOneRadio>
        </h:panelGroup>
        <h:outputText value="姓名"/>
        <h:panelGroup>
            <h:inputHidden id="ids" value="#{wage_noteBB.note.personId}"/>
            <h:inputText alt="姓名|0|s" readonly="true" id="name" value="#{wage_noteBB.note.personName}" size="30" code="" dict="yes" dict_num="PE"/>
            <h:commandButton styleClass="button01" value="选择人员" id="selPer"
                             onclick="forPerson();return false;"/>
        </h:panelGroup>
        <h:outputText value="变动事由"/>
        <h:inputText value="#{wage_noteBB.note.cause}" size="60"/>

        <h:outputText value="变动依据"/>
        <h:inputText value="#{wage_noteBB.note.desc}" size="60"/>

        <h:outputText value="相关账套"/>
        <h:selectManyCheckbox value="#{wage_noteBB.userSelect}" layout="pageDirection" id="userSelect" >
            <c:selectItems value="#{wage_noteBB.setList}"/>
        </h:selectManyCheckbox>
    </h:panelGrid>
    <c:verbatim><br></c:verbatim>
    <h:panelGrid columns="2" align="center" cellspacing="2">
        <h:commandButton value="确 定" action="#{wage_noteBB.save}" styleClass="button01" onclick="return forsave();"/>
        <h:commandButton value="取 消" action="#{wage_noteBB.list}" styleClass="button01"/>
    </h:panelGrid>
</h:form>
<script type="text/javascript">
    var type = document.getElementsByName('form1:type');
        if(type[1].checked==true){
           document.all('form1:selPer').disabled =false;
           document.all('form1:name').alt ="姓名|0|s";
        }else {
           document.all('form1:selPer').disabled =true;
           document.all('form1:name').alt="姓名|1|s";
            document.all('form1:ids').value="";
        }
</script>
