<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
        function doshowformularLog(id){
            window.showModalDialog("/wage/base/showFormulaChange.jsf?setId=" + id, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doshowItemLog(id){
            window.showModalDialog("/wage/base/showSetItemChange.jsf?setId=" + id, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function queryPersonChange(id){
           window.showModalDialog("/wage/payoff/showPersonChange.jsf?setId=" + id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
        }
        function queryDeptChange(id){
           window.showModalDialog("/wage/payoff/showDeptChange.jsf?setId=" + id, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
        }

    </script>

<x:saveState value="#{wage_watchsetBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_watchsetBB.pageInit}"/>
     <f:verbatim>
    <table align="center" height=98% border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF" >
        <tr>
            <td class=td_title height=8>
                <img src="/images/tips.gif" /> 薪酬管理 ->  帐套变化监控
            </td>
        </tr>
        <tr>
            <td height=5></td>
        </tr>
      <tr>
          <td>
              <div style='width:100%;height:100%;overflow:auto' id=datatable>
 </f:verbatim>
                <h:dataTable value="#{wage_watchsetBB.setList}" var="list" align="center" id="dateList"
                             headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                             styleClass="table03" width="98%" >

                    <h:column>
                        <c:facet name="header"><h:outputText value="帐套编号"/></c:facet>
                        <h:outputText value="#{list.setId}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="帐套名称"/></c:facet>
                        <h:outputText value="#{list.name}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="描述"/></c:facet>
                        <h:outputText value="#{list.desc}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="最近项目变化"/></c:facet>
                        <h:outputText value="#{list.newItemChange}"/>
                    </h:column>

                    <h:column>
                        <c:facet name="header"><h:outputText value="最近公式变化"/></c:facet>
                        <h:outputText value="#{list.newformulaChange}"/>
                    </h:column>


                    <h:column>
                        <c:facet name="header"><h:outputText value="操作"/></c:facet>
                        <h:commandButton value="查看项目变化" styleClass="button01"  onclick="return doshowItemLog('#{list.setId}');" action="#{wage_watchsetBB.popupItemChange}">
                              <x:updateActionListener property="#{wage_watchsetBB.setID}" value="#{list.setId}"/>
                        </h:commandButton>
                        <h:commandButton value="查看公式变化" styleClass="button01"  onclick="return doshowformularLog('#{list.setId}');" action="#{wage_watchsetBB.popupFormulaChange}">
                            <x:updateActionListener property="#{wage_watchsetBB.setID}" value="#{list.setId}"/>
                         </h:commandButton>
                        <h:commandButton type="button" styleClass="button01" value="查询人员增减变换" onclick="queryPersonChange('#{list.setId}');"></h:commandButton>
                        <h:commandButton type="button" styleClass="button01" value="人员薪资部门变动情况" onclick="queryDeptChange('#{list.setId}');"></h:commandButton>
                    </h:column>
                </h:dataTable>
 <f:verbatim>
              </div>    
          </td>
      </tr>
    </table>
 </f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
