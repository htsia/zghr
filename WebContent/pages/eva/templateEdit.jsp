<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <c:verbatim>
        
        <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
        <script language="javascript" src="/js/commonFuns.js"></script>
        <script language="javascript" src="/js/editor.js"></script>
        <script language="javascript" src="/js/editor_toolbar.js"></script>
    </c:verbatim>

    <script type="text/javascript">
         function doCheck(){
            if (document.all('form1:title').value==""){
                alert("��¼������!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{eva_templateBB}"/>
<h:form id="form1" >
        <h:inputHidden id="pageInit" value="#{eva_templateBB.editItem}"/>
<c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td width=100px class="td_form01" align="right">���</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputHidden value="#{eva_templateBB.templateBO.setID}" />
                    <h:inputText readonly="true" value="#{eva_templateBB.templateBO.setName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr>
            <td class="td_form01" align="right">��λ��Χ</td>
            <td class="td_form02" >
 </c:verbatim>
                <h:panelGroup>
                    <h:selectOneMenu id="orgID" value="#{eva_templateBB.templateBO.orguid}">
                        <c:selectItems value="#{eva_templateBB.orgList}"></c:selectItems>
                    </h:selectOneMenu>
                </h:panelGroup>
<c:verbatim>
            </td>
            </tr>

            <tr>
                <td class="td_form01" align="right">����</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="title" value="#{eva_templateBB.templateBO.templateName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>


    <tr>
        <td class="td_form01" align="right">�Ƿ�����</td>
        <td class="td_form02">
</c:verbatim>
             <h:selectOneRadio value="#{eva_templateBB.templateBO.isUse}" disabled="true">
                      <c:selectItem itemValue='0' itemLabel='��'></c:selectItem>
                      <c:selectItem itemValue='1' itemLabel='��'></c:selectItem>
             </h:selectOneRadio><c:verbatim>
        </td>
    </tr>

    <tr>
        <td class="td_form01" align="right">��ʾ˳��</td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText  value="#{eva_templateBB.templateBO.showSEQ}"></h:inputText>
<c:verbatim>
        </td>
    </tr>

    <tr>
        <td class="td_form01" align="right">�ܷ�</td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText  value="#{eva_templateBB.templateBO.totalscore}"></h:inputText>
<c:verbatim>
        </td>
    </tr>


    <tr>
        <td class="td_form01" align="right">����</td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText  value="#{eva_templateBB.templateBO.level}"></h:inputText>
<c:verbatim>
        </td>
    </tr>
    </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="����" onclick="return doCheck();" action="#{eva_templateBB.saveItem}" styleClass="button01" />
                <h:commandButton value="����"  type="button" onclick="window.close()" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
