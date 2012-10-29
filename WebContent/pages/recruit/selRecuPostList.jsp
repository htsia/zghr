<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"  %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function doOK() {
      	var str=" |";
        chk=document.forms(0).selectItem;
        if (checkMutilSelect(chk)){
            var size = chk.length;
            if (size == null) {
                if (chk.checked) {
                    str+=chk.value;
                }
            } else {
                for (var i = 0; i < size; i++) {
                    if (chk[i].checked) {
                        if (i==0){
                            str+=chk[i].value;
                        }
                        else{
                            str+=","+chk[i].value;
                        }
                    }
                }
            }
           	window.returnValue=str;
            window.close();
        }
        else{
            alert("请选择要加入的人员!");
        }
    }

    function doCancel() {
        window.returnValue="";
        window.close();
    }
</script>
<x:saveState value="#{resumeemaillistBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{resumeemaillistBB.initSel}"></h:inputHidden>
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td height=8>
        </td></tr>
        <tr><td height=8 align="left">
        </td></tr>
        <tr><td height=8 align="right">
    </c:verbatim>
           <h:commandButton value="确定" styleClass="button01" type="button" onclick="doOK();"></h:commandButton>
           <h:commandButton value="取消" styleClass="button01" type="button" onclick="doCancel();"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <h:dataTable value="#{resumeemaillistBB.postList}" var="list" width="100%" id="dateList"
                        styleClass="table03" headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center">
                    <h:column>
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox"  name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.itemId}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="所属计划"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.planName}"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="岗位"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.postName}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="发布时间"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.publishDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="需求人数"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.needCount}"/>
                    </h:column>
                     
                </h:dataTable>
    <c:verbatim>
        </div>
        </td></tr>
        </table>
    </c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
