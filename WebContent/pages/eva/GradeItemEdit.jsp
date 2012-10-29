<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

   
    <script type="text/javascript">
         function doCheck(){
            if (document.all('form1:name').value==""){
                alert("请录入名称!");
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{eva_gradeBB}"/>
<h:form id="form1" enctype="multipart/form-data">
        <h:inputHidden id="pageInit" value="#{eva_gradeBB.initItemEdit}"/>
        <c:verbatim>
        <br>
        <table width="98%"  align="center" class="table03">
            <tr>
                <td class="td_form01">项目名称</td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="name" value="#{eva_gradeBB.gradeitembo.itemName}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">项目描述</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputTextarea  id="des" rows="10" cols="40" value="#{eva_gradeBB.gradeitembo.itemDes}"></h:inputTextarea>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">下限</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText  id="low" value="#{eva_gradeBB.gradeitembo.lowValue}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">上限</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText  id="high" value="#{eva_gradeBB.gradeitembo.highValue}"></h:inputText>
 <c:verbatim>
                </td>
            </tr>
			 <tr>
                <td class="td_form01">符号</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText  id="flagChar" value="#{eva_gradeBB.gradeitembo.flagChar}"></h:inputText>
                    <h:commandButton onclick="selectItemFlag(document.all('form1:flagChar'))" type="button"
					styleClass="button_select"></h:commandButton>
 <c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">显示顺序</td>
                <td class="td_form02">
 </c:verbatim>
                    <h:inputText   value="#{eva_gradeBB.gradeitembo.showSeq}"></h:inputText>
 <c:verbatim>
                </td>
            </tr>
        </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="保存" onclick="return doCheck();" action="#{eva_gradeBB.SaveItem}" styleClass="button01" />
                <h:commandButton value="返回"  type="button" onclick="window.close()" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>