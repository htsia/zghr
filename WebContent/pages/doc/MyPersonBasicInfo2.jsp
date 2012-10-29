<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>

<style type="text/css">
.style1{
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
.style2 TH {
	FONT-SIZE: 9pt;
	COLOR: #555555;
	font-family: "宋体";
	background-color: #F3F3F3;
	font-weight: normal;
}
.style2 TR {
	FONT-SIZE: 9pt; COLOR: #555555;
}
.style2 TD {
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
        	window.open('/doc/MyPersonBasicInfo.jsf?print=1&fk='+perId,'newwindow','top=0,left=0,toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,location=no,status=no');
        }
        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            doShowPersonTable(document.all("form1:ReportID").value,document.all('form1:personId').value);
            return false;
        }

    </script>

<x:saveState value="#{doc_DocBrowseBackingBean}" />
<h:form id="form1">
	<h:inputHidden value="#{doc_DocBrowseBackingBean.pageInit}" />
	<h:inputHidden id = "personId" value="#{doc_DocBrowseBackingBean.personId}"/>
    <c:verbatim><input type="hidden" name="content" value=""></c:verbatim>
    <h:panelGrid width="98%">
            <h:panelGrid align="right" columns="3" cellspacing="3">
                <h:commandButton value="打印" rendered="#{doc_DocBrowseBackingBean.showPrint}"
                    onclick="openPersonDoc();"   id="print"
                    styleClass="button01" />

                <h:selectOneMenu id="ReportID" style="width:190px" rendered="#{doc_DocBrowseBackingBean.showReport}">
                    <c:selectItems value="#{doc_DocBrowseBackingBean.regTableList}"/>
                </h:selectOneMenu>
                <h:commandButton styleClass="button01" id="export" rendered="#{doc_DocBrowseBackingBean.showReport}" type="button" value="导出" onclick="OpenRpt();"></h:commandButton>

            </h:panelGrid>
	</h:panelGrid>

	<h:panelGrid width="98%" align="center">
			<h:outputText escape="false" value="#{doc_DocBrowseBackingBean.title}" 	style="font-size:22px;text-align:center;width:100%" />
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
	    				<h:outputText escape="false" style="text-align:center;width:100%"		value="#{doc_DocBrowseBackingBean.personVO.name}" />
    <f:verbatim>
	  			   </td>
					<td class="table_rlbt" align="center" width="70" style="border:1px solid #555555;">
    </f:verbatim>
						<h:outputText escape="false" style="align:center"						value="性    别" />
    <f:verbatim>
					</td>
					<td class="table_rlbt" style="border:1px solid #555555;"  align="center" width="75">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"						value="#{doc_DocBrowseBackingBean.personVO.sex}" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center" width="85" style="border:1px solid #555555;">
     </f:verbatim>
						<h:outputText escape="false" value="出生日期" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" style="border:1px solid #555555;" align="center" width="90">
     </f:verbatim>
						<h:outputText escape="false"				value="#{doc_DocBrowseBackingBean.personVO.birth}" />
     <f:verbatim>
					</td>
					<td  styleClass="table_rlbt" rowspan="4" align="center" width="120" style="border:1px solid #555555;">
     </f:verbatim>
					<h:graphicImage height="160" width="120" style="text-align:center;" 	value="/file/tmp/#{doc_DocBrowseBackingBean.personVO.photo}.JPG" />
    <f:verbatim>
					</td>
				</tr>
				<tr>
					<td height="40" styleClass="table_rlbt"  align="center" style="border:1px solid #555555;">
     </f:verbatim>
						<h:outputText value="籍    贯" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" style="border:1px solid #555555;" align="center">
    </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.homeTown}#{doc_DocBrowseBackingBean.personVO.homeTownDes}" />
     <f:verbatim>
					</td>
					<td  styleClass="table_rlbt" align="center" style="border:1px solid #555555;">
     </f:verbatim>
						<h:outputText escape="false" value="出生地" />
<f:verbatim>
					</td>
					<td class="table_rlbt" style="border:1px solid #555555;" align="center">
     </f:verbatim>
						<h:outputText escape="false"		value="#{doc_DocBrowseBackingBean.personVO.homePlace}#{doc_DocBrowseBackingBean.personVO.homePlaceDes}" />
<f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText value="民    族" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"					value="#{doc_DocBrowseBackingBean.personVO.folk}" />
     <f:verbatim>
					</td>
				</tr>

         <tr>
             <td height="40" class="table_rlbt"  align="center" style="border:1px solid #555555;">
</f:verbatim>
                 <h:outputText value="身    高" />
<f:verbatim>
             </td>
             <td class="table_rlbt" style="border:1px solid #555555;" align="center">
</f:verbatim>
                 <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.stature}CM" />
<f:verbatim>
             </td>
             <td  styleClass="table_rlbt" align="center" style="border:1px solid #555555;">
</f:verbatim>
                 <h:outputText value="体    重" />
<f:verbatim>
             </td>
             <td class="table_rlbt" style="border:1px solid #555555;" align="center">
</f:verbatim>
                 <h:outputText escape="false" style="text-align:center;width:100%"					value="#{doc_DocBrowseBackingBean.personVO.avoirdupois}公斤" />
<f:verbatim>
             </td>
             <td class="table_rlbt" align="center">
</f:verbatim>
                 <h:outputText value="身体情况" />
<f:verbatim>
             </td>
             <td class="table_rlbt" align="center">
</f:verbatim>
                 <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.health}" />
<f:verbatim>
             </td>
         </tr>


    <tr>
        <td height="40" class="table_rlbt"  align="center" style="border:1px solid #555555;">
   </f:verbatim>
            <h:outputText value="政治面貌" />
   <f:verbatim>
        </td>
        <td class="table_rlbt" style="border:1px solid #555555;" align="center">
   </f:verbatim>
            <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.partyFigure}" />
   <f:verbatim>
        </td>
        <td  styleClass="table_rlbt" align="center" style="border:1px solid #555555;">
   </f:verbatim>
            <h:outputText value="婚姻状况" />
   <f:verbatim>
        </td>
        <td class="table_rlbt" style="border:1px solid #555555;" align="center">
   </f:verbatim>
            <h:outputText escape="false" style="text-align:center;width:100%"					value="#{doc_DocBrowseBackingBean.personVO.marriage}" />
   <f:verbatim>
        </td>
        <td class="table_rlbt" align="center">
   </f:verbatim>
            <h:outputText value="工作岗位" />
   <f:verbatim>
        </td>
        <td class="table_rlbt" align="center">
   </f:verbatim>
            <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.postId}" />
   <f:verbatim>
        </td>
    </tr>

       <tr>
           <td height="40" class="table_rlbt"  align="center" style="border:1px solid #555555;">
      </f:verbatim>
               <h:outputText value="技术职称" />
      <f:verbatim>
           </td>
          <td class="table_rlbt" colspan="2" style="border:1px solid #555555;" align="center">
     </f:verbatim>
              <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.proTechnic}" />
     <f:verbatim>
          </td>
         <td height="40" class="table_rlbt"  align="center" style="border:1px solid #555555;">
    </f:verbatim>
             <h:outputText value="专业技能" />
    <f:verbatim>
         </td>
        <td class="table_rlbt" style="border:1px solid #555555;" align="center">
   </f:verbatim>
            <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.jobTechnic}" />
   <f:verbatim>
        </td>
       <td height="40" class="table_rlbt"  align="center" style="border:1px solid #555555;">
  </f:verbatim>
           <h:outputText value="参加工作时间" />
  <f:verbatim>
       </td>
      <td class="table_rlbt" style="border:1px solid #555555;" align="center">
 </f:verbatim>
          <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.workTime}" />
 <f:verbatim>
      </td>
      </tr>


                 <tr>
					<td height="40" align="center" class="table_rlbt">
     </f:verbatim>
						<h:outputText escape="false" value="学历" />
     <f:verbatim>
					</td>
					<td class="table_rlbt"  align="center">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.studyRecord}" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" align="center">
     </f:verbatim>
						<h:outputText escape="false" value="学位" />
     <f:verbatim>
					</td>
					<td class="table_rlbt"  align="center">
     </f:verbatim>
						<h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.degree}" />
     <f:verbatim>
					</td>
         <td class="table_rlbt" align="center">
</f:verbatim>
             <h:outputText escape="false" value="eMail" />
<f:verbatim>
         </td>
         <td class="table_rlbt"  colspan="2" align="center">
</f:verbatim>
             <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.addressvo.email}" />
<f:verbatim>
         </td>
				</tr>

       <tr>
       <td height="40" colspan="2" align="center" class="table_rlbt">
</f:verbatim>
           <h:outputText escape="false" value="身份证号码" />
<f:verbatim>
       </td>
       <td class="table_rlbt"  colspan="3" align="center">
</f:verbatim>
           <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.idNum}" />
<f:verbatim>
       </td>
    <td height="40"  align="center" class="table_rlbt">
 </f:verbatim>
        <h:outputText escape="false" value="联系电话" />
 <f:verbatim>
    </td>
    <td class="table_rlbt"  align="center">
 </f:verbatim>
        <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.addressvo.mobile}" />
 <f:verbatim>
    </td>
       </tr>

     <tr>
     <td height="40"  align="center" class="table_rlbt">
  </f:verbatim>
         <h:outputText escape="false" value="家庭住址" />
  <f:verbatim>
     </td>
     <td class="table_rlbt"  colspan="4" align="center">
  </f:verbatim>
         <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.addressvo.homeAddress}" />
  <f:verbatim>
     </td>
  <td height="40"  align="center" class="table_rlbt">
   </f:verbatim>
      <h:outputText escape="false" value="邮编" />
   <f:verbatim>
  </td>
  <td class="table_rlbt"  align="center">
   </f:verbatim>
      <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.addressvo.zip}" />
   <f:verbatim>
  </td>
     </tr>

       <tr>
       <td height="40"  align="center" class="table_rlbt">
    </f:verbatim>
           <h:outputText escape="false" value="户口所在地" />
    <f:verbatim>
       </td>
       <td class="table_rlbt"  colspan="4" align="center">
    </f:verbatim>
           <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.rpr}" />
    <f:verbatim>
       </td>
    <td height="40"  align="center" class="table_rlbt">
     </f:verbatim>
        <h:outputText escape="false" value="邮编" />
     <f:verbatim>
    </td>
    <td class="table_rlbt"  align="center">
     </f:verbatim>
        <h:outputText escape="false" style="text-align:center;width:100%"				value="#{doc_DocBrowseBackingBean.personVO.rprZip}" />
     <f:verbatim>
    </td>
       </tr>

                <tr>
					<td height="200" align="center" class="table_rlbt">
     </f:verbatim>
						<h:outputText escape="false"
							value="<pre>家庭主<br>要成员<br>和重要<br>社会关<br>系</pre>" />
     <f:verbatim>
					</td>
					<td class="table_rlbt" colspan="6" valign="top" cellpadding="0">
                    <br>
     </f:verbatim>
							<h:dataTable align="center" border="0" width="100%"
								columnClasses="center,center,center,center,center,center"
								value="#{doc_DocBrowseBackingBean.personVO.familyList}"
								var="fList" styleClass="style2">
								<h:column>
									<f:facet name="header">
										<h:outputText escape="false" value="<b>称 谓</b>" />
									</f:facet>
									<h:outputText style="text-align:center;width:100%" value="#{fList.familyRelation}" />
								</h:column>
								<h:column>
									<f:facet name="header">
										<h:outputText escape="false" value="<b>姓 名</b>" />
									</f:facet>
									<h:outputText style="text-align:center;width:100%" value="#{fList.familyName}" />
								</h:column>
								<h:column>
									<f:facet name="header">
										<h:outputText escape="false" value="<b>性 别</b>" />
									</f:facet>
									<h:outputText style="text-align:center;width:100%" value="#{fList.familySex}" />
								</h:column>
								<h:column>
									<f:facet name="header">
										<h:outputText escape="false" value="<b>出生日期</b>" />
									</f:facet>
									<h:outputText style="text-align:center;width:100%" value="#{fList.familyBirth}" />
								</h:column>
								<h:column>
									<f:facet name="header">
										<h:outputText escape="false" style="text-align:center;width:100%" value="<b>工作单位及职务</b>" />
									</f:facet>
									<h:outputText  style="text-align:center;width:100%" value="#{fList.familyWorkInfo}" />
								</h:column>
                                <h:column>
                                    <f:facet name="header">
                                        <h:outputText escape="false" style="text-align:center;width:100%" value="<b>联系电话</b>" />
                                    </f:facet>
                                    <h:outputText style="text-align:center;width:100%" value="#{fList.familyTel}" />
                                </h:column>

                            </h:dataTable>
     <f:verbatim>
					</td>
				</tr>

         <tr>
         <td height="40"  colspan="7" align="center" class="table_rlbt">
      </f:verbatim>
             <h:outputText escape="false" value="<strong>主要工作经历</strong>" />
      <f:verbatim>
         </td>
          </tr>

          <tr>
              <td height="280" colspan="7" align="center" valign="top" >
              <br>
   </f:verbatim>
    <h:dataTable align="center" border="0" width="100%"
        columnClasses="center,center,center,center,center,center"
        value="#{doc_DocBrowseBackingBean.personVO.resumeList}"
        var="resumeList" styleClass="style2">
        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>开始时间</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{resumeList.resumeBeginDate}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>结束时间</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{resumeList.resumeEndDate}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>工作单位</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{resumeList.resumeUnit}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>职务/工种</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{resumeList.resumeDuty}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>证明人</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{resumeList.witness}" />
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" style="text-align:center;width:100%" value="<b>联系电话</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{resumeList.witnessTel}" />
        </h:column>
    </h:dataTable>
   <f:verbatim>
              </td>
         </tr>

       <tr>
       <td height="40"  colspan="7" align="center" class="table_rlbt">
    </f:verbatim>
           <h:outputText escape="false" value="<strong>教育背景</strong>" />
    <f:verbatim>
       </td>
        </tr>

        <tr>
              <td height="200" colspan="7" align="center" valign="top" >
              <br>
   </f:verbatim>
    <h:dataTable align="center" border="0" width="100%"
        columnClasses="center,center,center,center,center,center"
        value="#{doc_DocBrowseBackingBean.personVO.educationList}"
        var="educationList" styleClass="style2">
        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>开始时间</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{educationList.studyStartDate}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>结束时间</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{educationList.studyGraduateDate}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>毕业院校</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{educationList.studySchool}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>所学专业</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{educationList.studyMajor}" />
        </h:column>

        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" value="<b>学历</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{educationList.studyDegree}" />
        </h:column>
        <h:column>
            <f:facet name="header">
                <h:outputText escape="false" style="text-align:center;width:100%" value="<b>学习形式</b>" />
            </f:facet>
            <h:outputText style="text-align:center;width:100%" value="#{educationList.studyMode}" />
        </h:column>
    </h:dataTable>
   <f:verbatim>
              </td>
         </tr>


                <tr>
                <td height="40"  colspan="7" align="left" class="table_rlbt">
             </f:verbatim>
                    <h:outputText escape="false" value="&nbsp;&nbsp;表中所有信息已经本人认真核对无误，并保证它的真实性和完整性。如有虚假，本人愿承担法律责任。" />
             <f:verbatim>
                </td>
                 </tr>
                
            </table>
            <br><br>
     </f:verbatim>                     
</h:form>
<script type="text/javascript">
<%
    if ("1".equals(request.getParameter("print"))){
       out.println("document.all('form1:print').style.display='none';");
       out.println("document.all('form1:export').style.display='none';");
       out.println("document.all('form1:ReportID').style.display='none';");
       out.println("window.print();");
    }
    if (request.getAttribute("exportFile")!=null){
        out.println("window.open('/pages/common/ShowExcel.jsp');");
        request.removeAttribute("exportFile");
    }
    
%>
</script>
