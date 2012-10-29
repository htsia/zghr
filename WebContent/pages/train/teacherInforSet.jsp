<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<style type="text/css">
.style1
{
    font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
	border:2px solid #555555;
}
.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style1 TR {
	FONT-SIZE: 9pt; COLOR: #555555; 
}
.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";

}
.style2
{
    font-family: verdana;
	font-size: 9pt;
	cursor: default;
	border-collapse: collapse;
}
.style1 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style1 TR {
	FONT-SIZE: 9pt; COLOR: #555555; 
}
.style1 TD {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
}
.table_rlbt{
border:1px solid #555555;
}
</style>
<script type="text/javascript">
        function queryPerson() {
        	var obj11 = document.all("form1:input1Name");
        	//alert(obj11.value);
            retval = window.showModalDialog("/doc/QueryPersonResult.jsf?personName= " + obj11.value, "", "dialogWidth:800px; dialogHeight:600px; center:yes; status:1;");
		    if (retval)
		        return true;
		    else
		        return false;
        }
        function openPersonDoc(){
        	var perId = document.all("form1:personId").value;
        	window.open('/pages/train/teacherInforSet.jsf?print=1&teacherID='+perId,'newwindow','top=0,left=0,toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,location=no,status=no');
        }
    </script>

<x:saveState value="#{train_teacherBrowerbb}" />
<h:form id="form1">
	<h:inputHidden value="#{train_teacherBrowerbb.pageInit}" />
	<h:inputHidden id = "personId" value="#{train_teacherBrowerbb.teacherId}"/>

    <h:panelGrid width="98%">
            <h:panelGrid align="right" columns="3" cellspacing="3">
                <h:commandButton value="打印"
                    onclick="openPersonDoc();"   id="print"
                    styleClass="button01" />
               
            </h:panelGrid>
	</h:panelGrid>

	<h:panelGrid width="98%" align="center">
			<h:outputText escape="false" value="讲师基本情况表" 	style="font-size:22px;text-align:center;width:100%" />
			<f:verbatim>
				<br>
			</f:verbatim>
			<h:panelGrid width="620" align="center" columns="2" cellspacing="3"			 columnClasses="right">
			    <h:panelGroup>
					<h:outputText style="text-align:right" escape="false" value="制表日期:"/>
					<h:outputText style="text-align:right" escape="false" value="#{doc_DocBrowseBackingBean.today}" />
			    </h:panelGroup>
			</h:panelGrid>
    </h:panelGrid>

    <f:verbatim>
            <table align="center" border="0" width="610" id="table1"	cellspacing="0" cellpadding="0" class="style1">
				<tr>
					<td class="table_rlbt" height="40" align="center" width="80" style="border:1px solid #555555;">
    </f:verbatim>
						<h:outputText escape="false" value="姓    名"		style="text-align:center;width:100%" />
    <f:verbatim>
					</td>
					<td class="table_rlbt" style="border:1px solid #555555;" align="center" width="90" >
    </f:verbatim>
	    				<h:outputText escape="false" style="text-align:center;width:100%"		value="#{train_teacherBrowerbb.teacherbo.teacherName}" />
    <f:verbatim>
	  			   </td>
					<td class="table_rlbt" align="center" width="70" style="border:1px solid #555555;">
    </f:verbatim>
						<h:outputText escape="false" style="align:center"						value="性    别" />
    <f:verbatim>
					</td>
					<td class="table_rlbt" style="border:1px solid #555555;"  align="center" width="75">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"						value="#{train_teacherBrowerbb.teacherbo.teacherSex}" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center" width="85" style="border:1px solid #555555;">
     </f:verbatim>
						<h:outputText escape="false" value="出生日期<br>(年月日)" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" style="border:1px solid #555555;" align="center" width="90">
     </f:verbatim>
						<h:outputText escape="false"				value="#{train_teacherBrowerbb.teacherbo.teacherBirthday}" />
     <f:verbatim>
					</td>
					<td  styleClass="table_rlbt" rowspan="4" align="center" width="120" style="border:1px solid #555555;">
     </f:verbatim>
					<h:graphicImage height="160" width="120" style="text-align:center;" 	value="/file/tmp/#{train_teacherBrowerbb.teacherbo.teacherPho}.JPG" />
    <f:verbatim>
					</td>
				</tr>
				<tr>
					<td height="40" styleClass="table_rlbt"  align="center" style="border:1px solid #555555;">
     </f:verbatim>
						<h:outputText value="所在机构" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" style="border:1px solid #555555;" align="center">
    </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"				value="#{train_teacherBrowerbb.teacherbo.createOrg}" />
     <f:verbatim>
					</td>
					<td  styleClass="table_rlbt" align="center" style="border:1px solid #555555;">
     </f:verbatim>
						<h:outputText value="专业技术职务" />
<f:verbatim>
					</td>
					<td class="table_rlbt" style="border:1px solid #555555;" align="center">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"					value="#{train_teacherBrowerbb.teacherbo.teacherCas}" />
<f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText value="学位" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"				value="#{train_teacherBrowerbb.teacherbo.teacherMajor}" />
     <f:verbatim>
					</td>
				</tr>
				<tr>
					<td class="table_rlbt" height="40" align="center">
     </f:verbatim>
						<h:outputText escape="false" value="培训费" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false"		value="#{train_teacherBrowerbb.teacherbo.teacherPric}" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" value="毕业院校" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"			value="#{train_teacherBrowerbb.teacherbo.teacherColleage}" />
      <f:verbatim>
                    </td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" value="学历" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"					value="#{train_teacherBrowerbb.teacherbo.teacherDegree}" />
     <f:verbatim>
					</td>
				</tr>
				<tr>
					<td class="table_rlbt" height="40" align="center">
     </f:verbatim>
						<h:outputText escape="false" value="机构联系方式" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false"		value="#{train_teacherBrowerbb.teacherbo.teacherTel}" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" value="讲师联系方式" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"			value="#{train_teacherBrowerbb.teacherbo.teacherMobile}" />
      <f:verbatim>
                    </td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" value="Email" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"					value="#{train_teacherBrowerbb.teacherbo.teacherEmail}" />
     <f:verbatim>
					</td>
				</tr>
				
				<tr>
					<td  align="center" height="210"	style="border:1px solid #666666">
     </f:verbatim>
						<h:outputText escape="false" value="讲<br><br>师<br><br>简<br><br>介" />
     <f:verbatim>
					</td>
					<td colspan="6"><table width="100%" cellspacing="0" cellpadding="0" height="180">
					<tr><td class="table_rlbt" align="left" width="100%" valign="top" height="10">
					
	</f:verbatim>
				<h:outputText escape="false" value="荣誉奖励情况" />
     <f:verbatim>		
					</td></tr>
					<tr>
					<td width="100%" class="table_rlbt" height="60">
     </f:verbatim>
                        <h:outputText escape="false" style="text-align:center;width:100%"
                            value="#{train_teacherBrowerbb.teacherbo.teacherGlo}" />
     <f:verbatim>
                    </td>
                    </tr>
                    <tr><td class="table_rlbt" align="left" width="100%" valign="top" height="10">
					
	</f:verbatim>
				<h:outputText escape="false" value="主讲课程" />
     <f:verbatim>		
					</td></tr>
					<tr>
					<td width="100%" class="table_rlbt" height="60">
     </f:verbatim>
                        <h:outputText escape="false" style="text-align:center;width:100%"
                            value="#{train_teacherBrowerbb.teacherbo.teacherCou}" />
     <f:verbatim>
                    </td>
                    </tr>
                    <tr><td class="table_rlbt" align="left" width="100%" valign="top" height="10">
					
	</f:verbatim>
				<h:outputText escape="false" value="曾经服务过的客户" />
     <f:verbatim>		
					</td></tr>
					<tr>
					<td width="100%" class="table_rlbt" height="60">
     </f:verbatim>
                        <h:outputText escape="false" style="text-align:center;width:100%"
                            value="#{train_teacherBrowerbb.teacherbo.teacherClie}" />
     <f:verbatim>
                    </td>
                    </tr>
                    </table>
                    </td>
				</tr>
				
				<tr>
					<td  align="center" height="180"	style="border:1px solid #666666">
     </f:verbatim>
						<h:outputText escape="false" value="备<br><br>注" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" colspan="6" style="padding-left:6px;">
     </f:verbatim>
                        <h:outputText escape="false" style="text-align:center;width:100%"
                            value="#{train_teacherBrowerbb.teacherbo.teacherMemo}" />
     <f:verbatim>
                    </td>
				</tr>
			</table>
     </f:verbatim>
</h:form>
<script type="text/javascript">
<%
    if ("1".equals(request.getParameter("print"))){
       out.println("document.all('print').style.display='none';");
       out.println("document.all('export').style.display='none';");
       out.println("window.print();");
    }
    if (request.getAttribute("exportFile")!=null){
        out.println("window.open('/pages/common/ShowExcel.jsp');");
        request.removeAttribute("exportFile");
    }
%>
</script>
