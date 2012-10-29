<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Contsrol", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    User user = (User)session.getAttribute(Constants.USER_INFO);
%>
      <script type="text/javascript">
          function colEditHere(){
              colEdit();
          }
          function doShowItem() {
              var arg = "setId=" + form1.all("form1:setId").value+"&operateID="+form1.all("form1:operateID").value;
              window.showModalDialog("/employee/info/ShowItemEdit.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
              disPlayProcessBar();
              return true;
          }
          function  doBatch(){
              var setId = form1.all("form1:setId").value;
              var arg="setId="+setId;
              window.showModalDialog("/employee/info/batchUpdate.jsf?" + arg, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
              return false;
          }
        function forDel() {
            if (checkMutilSelect(form1.chk)) {
                if (confirm("确认删除？")) {
                    return true;
                }
            } else {
                alert("请选择需要删除的记录！")
            }
            return false;
        }
          function forEdit() {
              var pk=selectOnlyOne(form1.chk);
              if (pk!=null) {
                  window.showModalDialog("/employee/info/busiModiData.jsf?setId="+document.all('form1:setId').value+"&pk="+pk+"&flag=2", null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
                  return true;
              }
          }

        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }

            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ORGUID="+document.all('form1:orguid').value+"&ID="+document.all('form1:beginTime').value+"&Parameter="+document.all('form1:endTime').value;
            window.open(url);
            return false;
        }
        function beginGroup(){
            if (document.all("form1:beginTime").value==""){
                alert("请先汇总时间");
                return false;
            }

            if (document.all("form1:sortList").value=="-1") {
                alert("没有选择汇总信息项");
                return false;
            }
            else{
               window.showModalDialog("/employee/info/ShowGroup.jsf?deptID="+document.all('form1:deptID').value+"&timeField="+document.all("form1:timeField").value+"&beginTime="+document.all("form1:beginTime").value+"&endTime="+document.all("form1:beginTime").value+"&setId=" + form1.all("form1:setId").value+"&groupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            }
            return false;
        }
        function forUploadFile() {
            if (document.all("form1:beginTime").value=="" ){
                alert("请先选择业务时间！");
                return false;
            }

            reval = window.showModalDialog("/employee/import/PerDataUploadBySet.jsf?TimeValue="+document.all("form1:endTime").value+"&TimeField="+document.all("form1:timeField").value+"&setID="+document.all('form1:setId').value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            document.all('form1:query').click();
        }
        function batchAdd(){
            if (document.all('form1:beginTime').value==""){
                alert("请选择开始时间!");
                return false;
            }
            var msg='确定要增加'+document.all('form1:beginTime').value+'数据吗?';
            if (confirm(msg)){
                return disPlayProcessBar();
            }
            return false;
        }
          function doSelectInfoInput() {
              var allCount=120;
              if (checkMutilSelect(form1.chk)) {
                  count = form1.chk.length;
                  var str = "";
                  if (count != null) {
                      var num = 0;
                      for (i = 0; i < count; i++)
                          if (form1.chk[i].checked) {
                              str += form1.chk[i].value.replace("#","~") + ",";
                              num++;
                          }
                      if (num > allCount) {
                          alert("最多只能选择"+allCount+"个人员");
                          return false;
                      }
                  } else
                      str = form1.chk.value.replace("#","~");
                  var setId = form1.all("form1:setId").value;
                  var arg = "operateID="+form1.all("form1:operateID").value+"&setID=" + setId + "&pkIDs=" + str;
                  var reval = window.showModalDialog("/employee/info/busiInputSelect.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
              } else {
                  alert("请选择人员");
                  return false;
              }
          }
          function doOrgInput(){
              PopUpOrgOnlyDlgTwoControl('form1:orguid','form1:orgName',2);
              document.all("form1:deptID").value="";
              document.all("form1:A001705").value="";
              document.all("form1:A001705").code="";
              document.all('form1:query').click();
          }
          function doDeptInput(){
                PopUpOrgDlg('form1:A001705',2,document.all('form1:orguid').value);
                document.all("form1:deptID").value=document.all("form1:A001705").code;
                disPlayProcessBar();
                document.all('form1:filterDept').click();
          }
    </script>

  <x:saveState value="#{emp_busiprocessBB}"/>
  <h:form id="form1">
      <h:inputHidden value="#{emp_busiprocessBB.pageInit}"></h:inputHidden>
      <h:inputHidden id="orguid" value="#{emp_busiprocessBB.orguid}"></h:inputHidden>
      <h:inputHidden id="setId" value="#{emp_busiprocessBB.setId}"></h:inputHidden>
      <h:inputHidden value="#{emp_busiprocessBB.setName}"></h:inputHidden>
      <h:inputHidden id="timeField" value="#{emp_busiprocessBB.timeField}"></h:inputHidden>
      <h:inputHidden id="operateID" value="#{emp_busiprocessBB.operateID}"></h:inputHidden>

      <f:verbatim>
      <table  border="0"  height=98% width=98% align="center" cellSpacing=0 id=main>
          <tr >
             <td class="td_title" height=2 colspan=2>
       </f:verbatim>
                 <h:graphicImage value="/images/tips.gif" />
                 <h:outputText value="#{emp_busiprocessBB.setName}"/>
                 <h:outputText value="      "></h:outputText>
                 <h:outputText escape="false" value="<strong>当前单位:</strong>"></h:outputText>
                  <h:inputText readonly="true" id="orgName" value="#{emp_busiprocessBB.orgName}"></h:inputText>
                 <h:commandButton value="切换单位" styleClass="button01" type="button" rendered="#{emp_busiprocessBB.canSelect}" onclick="doOrgInput();"></h:commandButton>
<f:verbatim>
             </td>
         </tr>

          <tr>
              <td height=2>
</f:verbatim>
                   <f:verbatim>
		        	<%=LanguageSupport.getResource("RYGL-2193","姓名或编号")%>
		        </f:verbatim>    
                  <h:inputText  id="nameStr" value="#{emp_busiprocessBB.nameStr}" style="width:140px"/>
                   <f:verbatim>
		        	<%=LanguageSupport.getResource("RYGL-2278","开始时间")%>
		        </f:verbatim>  
                  <h:inputText styleClass="input" id="beginTime" size="12" alt="开始时间|0|d" value="#{emp_busiprocessBB.beginTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:beginTime')"></f:verbatim>
                  <f:verbatim>
		        	<%=LanguageSupport.getResource("RYGL-2279","结束时间")%>
		        </f:verbatim>
                  <h:inputText styleClass="input" id="endTime" alt="结束时间|0|d" size="12" value="#{emp_busiprocessBB.endTime}" readonly="true"/>
                  <f:verbatim><input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:endTime')"></f:verbatim>

                 <h:commandButton value="开始查询" id="query"  onclick="return disPlayProcessBar();" styleClass="button01" action="#{emp_busiprocessBB.doQuery}" />

                 <h:commandButton value="导出excel" type="button" styleClass="button01" onclick="doExport();" />
      <f:verbatim>
              </td>
              <td>
</f:verbatim>
                  <h:commandButton styleClass="button01" value="删除"  action="#{emp_busiprocessBB.deleteData}"  onclick="return forDel();" />
                  <h:commandButton value="选择修改" onclick="return doSelectInfoInput();"  styleClass="button01" action="#{emp_busiprocessBB.doQuery}"/>
                  <h:commandButton value="按列修改" onclick="return colEdit();" action="#{emp_busiprocessBB.doQuery}" styleClass="button01" />
                  <h:commandButton styleClass="button01" value="单个修改"    action="#{emp_busiprocessBB.doQuery}" onclick="return forEdit();" />
                  <h:commandButton value="批量修改"   styleClass="button01" onclick="return doBatch();" action="#{emp_busiprocessBB.doQuery}"/>
                  <h:commandButton value="批量增加"   styleClass="button01" onclick="return batchAdd();" action="#{emp_busiprocessBB.doBatchAdd}" rendered="#{emp_busiprocessBB.canBatchAdd}"/>

<f:verbatim>
              </td>
          </tr>

          <tr>
          <td height=2 colspan=2>
                      选择部门
</f:verbatim>
                      <h:inputText id="A001705" code="" readonly="true"></h:inputText>
                      <h:inputHidden id="deptID" value="#{emp_busiprocessBB.deptId}"></h:inputHidden>
                      <f:verbatim>
                         <input  class="button_select" type="button"  onclick="doDeptInput();">
                      </f:verbatim>

                      <h:commandButton styleClass="button01" id="filterDept" value="过滤部门" style="display:none" action="#{emp_busiprocessBB.doQueryByDept}"/>
                      <h:commandButton styleClass="button01" value="数据导入" type="button"   onclick="return forUploadFile()"/>

                      <h:commandButton value="计算"  styleClass="button01" action="#{emp_busiprocessBB.setCacl}" onclick="return disPlayProcessBar();"/>
                      <h:commandButton value="设置显示项"  styleClass="button01" action="#{emp_busiprocessBB.doQuery}" onclick="return doShowItem();"/>
                      <h:outputText value="     "></h:outputText>
                      <h:selectOneMenu id="sortList" value="#{emp_busiprocessBB.sortField}">
                         <c:selectItems value="#{emp_busiprocessBB.sortList}"></c:selectItems>
                      </h:selectOneMenu>
                      <h:commandButton value="汇总" type="button" id="group"  styleClass="button01" onclick="beginGroup();" />

                      <h:outputText value="  "></h:outputText>
                      <h:selectOneMenu id="ReportID" style="width:190px">
                          <c:selectItems value="#{emp_busiprocessBB.reportList}"/>
                      </h:selectOneMenu>
                      <h:commandButton value="Excel显示" type="button" styleClass="button01" onclick="return OpenRpt();"></h:commandButton>
<f:verbatim>
              </td>
          </tr>
          <tr><td colspan=2 height=8></td></tr>
          <tr><td colspan=2 valign="top">
              <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                  <jsp:param name="hasOperSign" value="true"/>
                  <jsp:param name="operSignType" value="checkbox"/>
                  <jsp:param name="hasEdit" value="false"/>
                  <jsp:param name="isEditList" value="false"/>
                  <jsp:param name="isCheckRight" value="false"/>
                  <jsp:param name="keyName" value="SUBID"/>
              </jsp:include></td>
          </tr>
      </table>
</f:verbatim>      
  </h:form>
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
