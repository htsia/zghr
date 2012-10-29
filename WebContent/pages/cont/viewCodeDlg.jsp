<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript" language="javascript">
    function docheck(){
         if (document.all("form1:startNo").value==""){
             alert("没有录入起始合同号!");
             return false;
         }
        if (document.all("form1:endNo").value==""){
            alert("没有终止合同号!");
            return false;
        }
        return true;
    }
    function getContNo(rownum){
        window.returnValue=document.all('form1:space_'+rownum+':link').innerText;
        window.close();
    }
</script>

<x:saveState value="#{cont_contNewSignBB}"/>
<h:form id="form1">
    <c:verbatim>
    <table height=98% width=98% >
        <tr>
            <td height=9>
</c:verbatim>
                <h:outputText escape="false" value="<strong>起始合同号:</strong>"></h:outputText>
                <h:inputText id="startNo" value="#{cont_contNewSignBB.startNo}"></h:inputText> <c:verbatim><br></c:verbatim>

                <h:outputText escape="false" value="<strong>终止合同号:</strong>"></h:outputText>
                <h:inputText id="endNo" value="#{cont_contNewSignBB.endNo}"></h:inputText>

                <h:commandButton value="查询" styleClass="button01"  onclick="return docheck();" action="#{cont_contNewSignBB.doGetSpaceNo}"></h:commandButton>
<c:verbatim>
            </td>
        </tr>
        <tr>
            <td>
                <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </c:verbatim>
                     <x:dataTable value="#{cont_contNewSignBB.datalist}" var="list" align="center"  rowIndexVar="index"  id="space"
                         headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                         styleClass="table03" width="95%" >
                             <h:column>
                                 <c:facet name="header"><h:outputText value="序号"/></c:facet>
                                 <h:commandLink onclick="getContNo('#{index}');" value="#{index+1}"/>
                             </h:column>

                            <h:column>
                                <c:facet name="header"><h:outputText value="空白合同号"/></c:facet>
                                <h:outputText id="link" value="#{list[0]}"/>
                           </h:column>
                    </x:dataTable>
<c:verbatim>
                </div>
            </td>
        </tr>
    </table>
</c:verbatim>    
</h:form>

