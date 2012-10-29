<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<script type="text/javascript">
        function doCheck(){
            if (document.all("form1:A016030").value==""){
                alert("请选择接收部门!")
                return false;
            }
            if (document.all("form1:A016010").value==""){
                alert("请选择增员类别!")
                return false;
            }
            return forsubmit(document.forms(0));
        }
        function selPost(){
            var deptId=document.all("form1:A016030").code;
            PopUpPostDlgByDept(document.all("form1:toPostId"),null,deptId);
        }
        function selTime() {
            <%
               InfoItemBO workTime=SysCacheTool.findInfoItem("","A016020");
               if (InfoItemBO.DATA_TYPE_DATE6.equals(workTime.getItemDataType())){
            %>
                PopUpCalendarDlg_OnlyMonth("form1:A016020");
            <%
               }
               else{
             %>
                 PopUpCalendarDialog("form1:A016020");
            <%
             }
            %>
        }

    </script>

    <x:saveState value="#{emp_reApplyBB}"/>
    <h:form id="form1">
       <h:inputHidden value="#{emp_reApplyBB.pageInit}"/>
       <c:verbatim>
        <table width="98%" align="center">
           <tr>
               <td align="left">
</c:verbatim>
                   <h:outputText escape="false" value="重新提交以下人员：<br>"></h:outputText>
                   <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;#{emp_reApplyBB.names}"></h:outputText>
<c:verbatim>
               </td>
           </tr>

            <tr>
                <td align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="重新提交"  action="#{emp_reApplyBB.reApply}" />
                    <h:commandButton type="button" styleClass="button01" value="关闭" onclick="window.close()"/>
<c:verbatim>
                </td>
            </tr>
        </table>
</c:verbatim>
    </h:form>
