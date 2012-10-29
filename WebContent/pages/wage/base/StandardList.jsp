<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function confirmDel(str) {
            if (checkMutilSelect(form1.selectItem)) {
                if (confirm(str))
                    return true;
            }
            return false;
        }
        function showProcessBar() {
           x = document.body.clientWidth / 2 - 150;
           y = document.body.clientHeight / 2;
           document.all('processbar').style.top = y;
           document.all('processbar').style.left = x;
           document.all('processbar').style.display = "";
           return true;
        }

    </script>

<x:saveState value="#{wage_standardBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_standardBB.pageInit}"/>
    <h:inputHidden id="unitId" value="#{wage_standardBB.standard.unitId}"/>
    <h:panelGrid width="95%" align="center">
        <h:panelGrid columns="2" width="100%">
            <h:outputText value="发薪单位：#{wage_standardBB.unitName}"/>
            <h:panelGrid align="right" columns="4" cellspacing="2">
                <h:commandButton styleClass="button01" value="新建标准表" rendered="#{wage_standardBB.operRight}"
                                 action="#{wage_standardBB.step1_create}"/>
                <h:commandButton styleClass="button01" value="删除标准表" rendered="#{wage_standardBB.operRight}"
                                 action="#{wage_standardBB.delete}"
                                 onclick="return confirmDel('确定要删除吗?');"/>
            </h:panelGrid>
        </h:panelGrid>
        <h:dataTable value="#{wage_standardBB.stdList}" var="list"  id="dateList"
                     headerClass="td_top"
                     columnClasses="td_middle_center,td_middle_center,td_middle,td_middle_center,td_middle_center,td_middle_center"
                     styleClass="table03" width="100%">
            <h:column rendered="#{wage_standardBB.operRight}">
                <c:facet name="header">
                    <c:verbatim escape="false">
                        <input type="checkbox" name="chkAll" onclick="selectAll(document.form1.chkAll,document.form1.selectItem)">全选
                    </c:verbatim>
                </c:facet>
                <c:verbatim escape="false">
                    <input type="checkbox" name="selectItem" </c:verbatim ><c:verbatim ><h:outputText value="#{list[1]}"/></c:verbatim>
                    <c:verbatim > value="</c:verbatim><h:outputText value="#{list[0].stdId}"/><c:verbatim>">
            </c:verbatim>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="名称"/></c:facet>
                <h:outputText value="#{list[0].name}"/>
            </h:column>

            <h:column>
                <c:facet name="header"><h:outputText value="描述"/></c:facet>
                <h:outputText value="#{list[0].desc}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="是否公共标准"/></c:facet>
                <h:outputText value="#{list[0].publicFlag}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="更新时间"/></c:facet>
                <h:outputText value="#{list[0].createDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"><h:outputText value="操作"/></c:facet>
                <h:commandButton styleClass="button01" action="#{wage_standardBB.view}" value="查看">
                    <x:updateActionListener property="#{wage_standardBB.standard.stdId}" value="#{list[0].stdId}"/>
                </h:commandButton>
                <h:outputText value=" "/>

                <h:commandButton styleClass="button01" action="#{wage_standardBB.step1_setItem}" value="修改"
                                 rendered="#{wage_standardBB.operRight}">
                    <x:updateActionListener property="#{wage_standardBB.standard.stdId}" value="#{list[0].stdId}"/>
                </h:commandButton>
                <h:commandButton styleClass="button01" action="#{wage_standardBB.saveCopy}" onclick="return showProcessBar();" value="另存副本">
                    <x:updateActionListener property="#{wage_standardBB.standard.stdId}" value="#{list[0].stdId}"/>
                </h:commandButton>
                <h:commandButton styleClass="button01" action="#{wage_standardBB.send}" onclick="return showProcessBar();" value="发送">
                    <x:updateActionListener property="#{wage_standardBB.standard.stdId}" value="#{list[0].stdId}"/>
                </h:commandButton>
            </h:column>
        </h:dataTable>
    </h:panelGrid>
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
    
</h:form>
<script type="text/javascript" language="javascript">
    setDataTableOver("form1:dateList");
</script>