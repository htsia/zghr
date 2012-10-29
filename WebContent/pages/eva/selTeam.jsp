<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function doOK() {
        var str="|";
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
            alert("请选择要加入的团队!");
        }
    }
    function doCancel() {
        window.returnValue="";
        window.close();
    }     
    </script>

<x:saveState value="#{evaTeamSetBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{evaTeamSetBB.itemAddInite}"></h:inputHidden>
     <c:verbatim>
       <table height=98% width=98% align="center">
       	<tr height=8>
            <td class="td_title"><img src="/images/tips.gif"> 绩效管理-> 团队考核设置</td>
        </tr>
       <tr><td height=8 align="right"> 
       	</c:verbatim>
       		<h:commandButton value="确定" styleClass="button01" type="button" onclick="doOK();"></h:commandButton>
       		<h:commandButton value="取消" styleClass="button01" type="button" onclick="doCancel();"></h:commandButton>
       	<c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <x:dataTable value="#{evaTeamSetBB.teamList}" var="list"  align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox"  name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.teamId}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
                    </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="团队名称"/></c:facet>
            <h:outputText value="#{list.teamName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="创建机构"/></c:facet>
            <h:outputText value="#{list.createOrg}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="创建时间"/></c:facet>
            <h:outputText value="#{list.createTime}"/>
        </h:column>
    </x:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
