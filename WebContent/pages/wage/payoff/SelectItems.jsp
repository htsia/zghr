<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
    <script language="javascript">
       function DoSelectAll(isSelect){
            var size = document.all('form1:inputField').length;
            for (var i = 0; i < size; i++) {
                document.all('form1:inputField')[i].checked=isSelect;
            }
        }
        function doOK(){
            if(!checkMutilSelect(form1.all('form1:inputField'))){
                alert('请选择输入项');
                return false;
            }else{
                var labeltext="";
                var val="";
                var size = document.all('form1:inputField').length;
                for (var i = 0; i < size; i++) {
                    if (document.all('form1:inputField')[i].tagName!="INPUT") continue;
                    if (document.all('form1:inputField')[i].checked){
                        if (labeltext==""){
                            labeltext=document.all('form1:inputField')[i].parentElement.parentElement.innerText.trim();
                            val=document.all('form1:inputField')[i].value;
                        }
                        else{
                            labeltext+=","+document.all('form1:inputField')[i].parentElement.parentElement.innerText;
                            val+=","+document.all('form1:inputField')[i].value;
                        }
                    }
                }
                window.returnValue=labeltext+"|"+val;
                window.close();
                return true;
            }
        }
       function doCancel(){
           window.returnValue="";
           window.close();
       }

    </script>

<x:saveState value="#{wage_queryBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_queryBB.initSelect}"></h:inputHidden>
    <h:panelGrid columns="1" width="98%">
        <h:panelGrid columns="4" cellspacing="3" align="right">
            <h:commandButton  styleClass="button01" type="button" value="全部选择" onclick="DoSelectAll(true);" />
            <h:commandButton  styleClass="button01" type="button" value="全部取消" onclick="DoSelectAll(false);" />
            <h:commandButton styleClass="button01" value="确认"
                             onclick="return doOK();"/>
            <h:commandButton styleClass="button01" type="button" value="取消" onclick="return doCancel();"/>
        </h:panelGrid>


        <h:panelGrid columns="2" width="98%" styleClass="table03" align="center" columnClasses="td_top,td_top">
            <h:outputText value="选择统计项："/>
            <h:selectManyCheckbox  layout="pageDirection" id="inputField">
                <c:selectItems value="#{wage_queryBB.fieldList}"/>
            </h:selectManyCheckbox>
        </h:panelGrid>

        <h:panelGrid columns="4" cellspacing="3" align="right">
            <h:commandButton  styleClass="button01" type="button" value="全部选择" onclick="DoSelectAll(true);" />
            <h:commandButton  styleClass="button01" type="button" value="全部取消" onclick="DoSelectAll(false);" />
            <h:commandButton styleClass="button01" value="确认"
                             onclick="return doOK();"/>
            <h:commandButton styleClass="button01" type="button" value="取消" onclick="return doCancel();"/>
        </h:panelGrid>
    </h:panelGrid>
</h:form>
