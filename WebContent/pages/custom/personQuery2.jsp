<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));
%>
<<script type="text/javascript" src="/js/jquery.js"></script>

    <script type="text/javascript">
        function forSel() {
           if(PopUpMutilCodeDlgNoLayerForSubmit('form1:personType', 'form1:personTypeValue', "0135",'')){
                  document.forms(0).all('form1:queryPerson').click();
           }
        }

        function checkFilter(){
            if (document.getElementById("form1:qryID").value == "-1"){
                alert("请选择过滤条件！");
                return false;
            }
            return true;
        }
         function selPerson() {
        	var obj = $(":radio:checked");
        	if(obj.length!=0){
        		var ids="";
        		obj.each(function(e){
        			ids+=$(this).val()+",";
        		});
				window.returnValue=ids;
				this.close();
        	}else {
                alert("请选择人员！")
            }
        }
    </script>

    <x:saveState value="#{emp_selBackPersonBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_selBackPersonBB.pageInit}"/>
        <c:verbatim>
        <input type="hidden" name="rightFlag" value=<%=rightFlag%>/> 
        <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" height="98%">
            <tr>
                <td class="td_title"  height=8>选择人员</td>
                <td class="td_title" align="right"  height=8>
</c:verbatim>
                    <h:commandButton value="选择" onclick="javascript:return selPerson()"
                                                                styleClass="button01"/>

<c:verbatim>
                </td>
            </tr>
       <tr><td height=8 colspan="2"></td></tr>
       <tr><td height=8 colspan="2">
           <input name="simple1" type="button" id=15 next=20 class="button01" value="选择人员类别"
                  onclick="forSel();">
</c:verbatim>
                    <h:inputHidden id="personType" value="#{emp_selBackPersonBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{emp_selBackPersonBB.personTypeValue}"/>
                    <h:outputText value="#{emp_selBackPersonBB.personTypeDesc}"></h:outputText>
<c:verbatim>

       </td></tr>

       <tr><td height=8 colspan="2"></td></tr>
    
       <tr><td height=8 colspan="2">
           输入姓名或员工编号
</c:verbatim>
           <h:inputText id="name" value="#{emp_selBackPersonBB.name}"
                           size="10" styleClass="input"  onkeypress ="enterKeyDown('form1:queryPerson')" />
           <h:commandButton value="查询" id="queryPerson" onclick="javascript:return true;" styleClass="button01"
                            action="#{emp_selBackPersonBB.queryPerson}"/>
           <h:selectOneMenu value="#{emp_selBackPersonBB.qryID}" id="qryID">
               <c:selectItems value="#{emp_selBackPersonBB.conList}"></c:selectItems>
           </h:selectOneMenu>
           <h:commandButton value="过滤" id="filter"  styleClass="button01"  onclick="return checkFilter();"
                         action="#{emp_selBackPersonBB.queryPerson}"/>

<c:verbatim>
       </td></tr>

       <tr> <td height=8 colspan="2"></td></tr>
    
       <tr>
            <td valign="top" colspan=2>
                <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                    <jsp:param name="hasOperSign" value="true"/>
                    <jsp:param name="operSignType" value="radio"/>
                    <jsp:param name="hasEdit" value="false"/>
                    <jsp:param name="isEditList" value="false"/>
                    <jsp:param name="isCheckRight" value="true"/>
                    <jsp:param name="isForward" value="true"/>
                    <jsp:param name="isRow" value="true"/>
                    <jsp:param name="rowFuncName" value="forView"/>
                    <jsp:param name="isPage" value="true"/>
                </jsp:include>
            </td>
       </tr>
     </table>
</c:verbatim>
    </h:form>

