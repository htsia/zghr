<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"  %>

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
            alert("��ѡ��Ҫ�������Ա!");
        }
    }

    function doCancel() {
        window.returnValue="";
        window.close();
    }
    function check(){
        if(document.all('form1:codValue').value==""){
            alert("��ѯ����Ϊ��ʱ��ѯȫ��");
        }
    }
    function forViewPost(id) {
        windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=0","aa","","900","600","no","10","100","yes");
    }
</script>
<x:saveState value="#{emptitleapplyAduitBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{emptitleapplyAduitBB.initAdd}"></h:inputHidden>
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td height=8>
        </td></tr>
        <tr><td height=8 align="left">
        </td></tr>

        <tr><td height=8 align="right">
    </c:verbatim>
    		<h:outputText value="������Ա�����"></h:outputText>
            <h:inputText id="codValue" value="#{emptitleapplyAduitBB.codValue}"></h:inputText>
            <h:outputText value="  "></h:outputText>
            <h:commandButton value="��ѯ" onclick="check()" action="#{emptitleapplyAduitBB.QueryAddPerson2}" styleClass="button01"></h:commandButton>
            <h:outputText value="��#{emptitleapplyAduitBB.mypage.totalPage}ҳ"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="ÿҳ��#{emptitleapplyAduitBB.mypage.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="��ǰΪ��#{emptitleapplyAduitBB.mypage.currentPage}ҳ"></h:outputText>
            <h:commandButton value="��ҳ" action="#{emptitleapplyAduitBB.addfirst}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{emptitleapplyAduitBB.addpre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="��ҳ" action="#{emptitleapplyAduitBB.addnext}" styleClass="button01"></h:commandButton>
            <h:commandButton value="βҳ" action="#{emptitleapplyAduitBB.addlast}" styleClass="button01"></h:commandButton>
            <h:outputText value="  "></h:outputText>
           <h:commandButton value="ȷ��" styleClass="button01" type="button" onclick="doOK();"></h:commandButton>
           <h:commandButton value="ȡ��" styleClass="button01" type="button" onclick="doCancel();"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <h:dataTable value="#{emptitleapplyAduitBB.addPersonList}" var="list" width="100%" id="dateList"
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
                        <h:outputText value="#{list.personId}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="Ա������"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personCode}"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.name}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.orgId}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="����"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.deptId}"/>
                    </h:column>
                     <h:column>
                    <f:facet name="header">
                        <h:outputText value="��λ"/>
                    </f:facet>
                    <h:commandLink value="#{list.postType}" onclick="forViewPost('#{list.postId}')"></h:commandLink>
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
