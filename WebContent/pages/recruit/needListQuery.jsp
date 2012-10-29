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
            alert("请选择要加入的岗位!");
        }
    }

    function doCancel() {
        window.returnValue="";
        window.close();
    }
    function forViewPost(id) {
        windowOpen("/post/info/PostEditInfo.jsf?pk="+id+"&type=0","aa","","900","600","no","10","100","yes");
    }
</script>
<h:form id="form1">
    <h:inputHidden value="#{recuNeedQueryBB.pageInit}"></h:inputHidden>
    <c:verbatim>
        <table height=97% width=98% align="center">
        <tr><td height=8>
        </td></tr>

        <tr><td height=8 align="left">
    
        </td></tr>

        <tr><td height=8 align="right">
    </c:verbatim>
            <h:outputText value="共#{recuNeedQueryBB.mypage.totalPage}页"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="每页有#{recuNeedQueryBB.mypage.pageSize}"></h:outputText>
            <h:outputText value="  "></h:outputText>
            <h:outputText value="当前为第#{recuNeedQueryBB.mypage.currentPage}页"></h:outputText>
            <h:commandButton value="首页" action="#{recuNeedQueryBB.first}" styleClass="button01"></h:commandButton>
            <h:commandButton value="上页" action="#{recuNeedQueryBB.pre}" styleClass="button01"></h:commandButton>
            <h:commandButton value="下页" action="#{recuNeedQueryBB.next}" styleClass="button01"></h:commandButton>
            <h:commandButton value="尾页" action="#{recuNeedQueryBB.last}" styleClass="button01"></h:commandButton>
            <h:outputText value="  "></h:outputText>
           <h:commandButton value="确定" styleClass="button01" type="button" onclick="doOK();"></h:commandButton>
           <h:commandButton value="取消" styleClass="button01" type="button" onclick="doCancel();"></h:commandButton>
    <c:verbatim>
        </td></tr>

        <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
    </c:verbatim>
        <h:dataTable value="#{recuNeedQueryBB.recuNeedList}" var="list" width="100%" id="dateList"
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
                            <h:outputText value="岗位名称"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.postName}"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="填报时间"/>
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
