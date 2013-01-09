<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function forView(form, id, type) {
            windowOpen("/employee/info/PersonEditInfo.jsf?pk=" + id, "aa", "", "800", "700", "no");
        }
        function forSel() {
               if(PopUpMutilCodeDlgForSubmit('form1:personType', 'form1:personTypeValue', "0135","")){
                  document.forms(0).all('form1:queryPerson').click();
           }
        }
         function forAdQry(){
             doAdvanceQuery("A","ORG","111","Y","","A001.A001730='00900'","Y","<%=Constants.DEFAULT_QUERY_PERSON%>","Y","1");
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
                var reval = window.showModalDialog("/custom/ins/BaseRateInputEdit2.jsf?act=init&PerStr="+str, null, "dialogWidth:"+screen.width*0.85+"px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            } else {
                alert("请选择人员");
                return false;
            }
            return true;
        }
        function forUploadFile() {
	        var arg = "moduleid=BXGL"
	        reval = window.showModalDialog("/employee/import/PerDataUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
	        if (reval != null) {
	            return true;
	        } else {
	            return false;
	        }
	    }
        function forExport() {
            window.open('/pages/common/ExportToExcel.jsp?sessionKey=<%=Constants.OBJECT%>');
            return null;
        }
        function forEdit(form, id, right) {
            var arg = "id=" + id;
            window.open("/pages/insurace/base/PersonInfoFrame.jsp?" + arg, null, "left="+screen.width*0.05+",top="+screen.height*0.01+",height="+screen.height*0.9+",width="+screen.width*0.9+",status=yes,toolbar=no,menubar=no,location=no,status=no,scroll=yes,resizable=yes");
            window.status = "";
        }
    </script>
    <x:saveState value="#{ins_dataBB}"></x:saveState>
    <h:inputHidden value="#{ins_dataBB.pageInit2}"/>
    <h:form id="form1">
        <f:verbatim>
        <table id=t1 width="100%" height="98%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td height=10 class="td_page" colspan=3>
                    <input name="simple1" type="button" id=15 next=20 class="button01" value="选择人员类别"
                           onclick="forSel()">
           </f:verbatim>
                    <h:inputHidden id="personType" value="#{ins_dataBB.personType}"/>
                    <h:inputHidden id="personTypeValue" value="#{ins_dataBB.personTypeValue}"/>
                    <h:outputText value="#{ins_dataBB.personTypeDesc}"></h:outputText>
    <f:verbatim>
                </td>
            </tr>
            <tr>
                <td height=10 class="td_page">
     </f:verbatim>
                    <h:outputText value="姓名/员工编号/简拼"></h:outputText>
                    <h:inputText id="nameStr" value="#{ins_dataBB.nameStr}"
                                    size="10" styleClass="input" onkeypress ="enterKeyDown('form1:doQuery2')" />
                    <h:commandButton value=" 查询 " id="queryPerson"  styleClass="button01"
                                     action="#{ins_dataBB.doQuery2}"/>
                                     
                    <h:outputText value=" "/>
                    <h:commandButton value="自定义查询" onclick="javascript:return forAdQry();" styleClass="button01" />
                    <h:outputText value=" "/>
                    <h:commandButton styleClass="button01" value="导出Excel" type="button" onclick="return forExport();"/>
      <f:verbatim>
                </td>
                <td height=10 class="td_page">
      </f:verbatim>
                    <h:commandButton value="基数变动" type="button" styleClass="button01" onclick="return doSelectInfoInput();"/>
                    <h:outputText value="  "/>
                    <h:commandButton styleClass="button01" value="数据导入" type="button" onclick="return forUploadFile()"/>
      <f:verbatim>
                </td>
            </tr>
            <tr>
                <td colspan=2>
                    <jsp:include page="/pages/common/activepage/ActiveList.jsp">
                        <jsp:param name="hasOperSign" value="true"/>
			            <jsp:param name="operSignType" value="checkbox"/>
			            <jsp:param name="hasEdit" value="true"/>
			            <jsp:param name="isForward" value="true"/>
			            <jsp:param name="rowFuncName" value="forEdit"/>
			            <jsp:param name="isEditList" value="false"/>
			            <jsp:param name="isCheckRight" value="false"/>
                    </jsp:include>
                </td>
            </tr>
        </table>
       </f:verbatim>        
    </h:form>
    <form id="form2">
        <input type="hidden" name="perids"/>
    </form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>

<script type="text/javascript">
    interpret(document.forms(0));
</script>
