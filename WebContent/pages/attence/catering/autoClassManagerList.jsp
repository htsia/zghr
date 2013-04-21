<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk"%>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.common.pojo.vo.User"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.attence.ucc.impl.AttenceSetUCC"%>
<%@ page import="java.util.*"%>
<%@ page import="com.hr319wg.attence.pojo.bo.AttDurationBO"%>
<%@ page import="com.hr319wg.attence.pojo.vo.AttClassGroupVO"%>
<%@ page import="com.hr319wg.attence.pojo.bo.AttClassBO"%>
<%@ page import="com.hr319wg.attence.pojo.bo.AttItemSetDetailBO"%>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<link href="/css/style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
.bg-hover{
    border: 1px solid #B1CDE3;
	font-size: 12px;
	padding: 3px 3px 3px 8px; 
   	height:60px;
	text-align: center;
    background:#66CCFF; 
    color:red;
    cursor: pointer;
   }

.td_class {
	border: 1px solid #B1CDE3;
	background: #fff;
	font-size: 12px;
	padding: 3px 3px 3px 8px;
	color: #4f6b72;
	height:100px;
	text-align: center;
}

.table_css1 {
	border: 1px solid #B1CDE3;
	padding: 0;
	margin: 0 auto;
	border-collapse: collapse;
}

.table_css {
	border-collapse: collapse;
	border-top: 1px #000000 solid;
	border-right: 1px #000000 solid;
	border-bottom: 1px #000000 solid;
	border-left: 1px #000000 solid;
}
</style>
<script type="text/javascript">
function refreshload() {
	setTimeout('myrefresh()', 1000);
}
function GetDate(id,id1)
{
  var orgValue=document.all("form1:orgValue").value;
  window.showModalDialog("/attence/catering/autoClassManagerListSelectItem.jsf?amaId="+id+"&createDay="+id1+"&orgValue="+orgValue, null, "dialogWidth:" + screen.width * 0.7 + "px; dialogHeight:" + screen.height * 0.7 + "px;center:center;resizable:yes;status:no;scroll:yes;");
  //document.all('form1:refresh').click();
}
function doDetailPopup() {
	var id=document.all("form1:arrangeId").value;
	window
			.showModalDialog(
					"/attence/catering/autoRearrangeListExistRest.jsf?arrangeId="
							+ id,
					null,
					"dialogWidth:" + screen.width * 0.8 + "px; dialogHeight:" + screen.height * 0.8 + "px;center:center;resizable:yes;status:no;scroll:yes;");
	return true;
}
function showProcessBar() {
    x = document.body.clientWidth / 2 - 150;
    y = document.body.clientHeight / 2;
    document.all('processbar').style.top = y;
    document.all('processbar').style.left = x;
    document.all('processbar').style.display = "";
}
function print1() {
    document.all('control').style.display = "none";
    document.all('a').style.display = "none";
    window.print();
    document.all('control').style.display = "";
    document.all('a').style.display = "";
}
function exportToExcel() {
    try {
        var range = document.body.createTextRange();
        range.moveToElementText(dtable);
        range.execCommand('Copy');
        excel = new ActiveXObject('Excel.Application');
        excel.Application.Visible = true;
        book = excel.Workbooks.Add;
        sheet = book.Worksheets.Add;
        sheet.Paste;
    } catch(e) {
        alert("您的电脑可能没有安装Microsoft Excel软件，或者没有将本站点设为信任站点。")
        return false;
    }
}
</script>
<f:verbatim>
	<table id="a" width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td></f:verbatim> <x:saveState value="#{autoclassmanagerlistBB}" /> <h:form
				id="form1">
				<h:commandButton id="refresh" value="刷新" style="display:none;" onclick="refreshload()"></h:commandButton>
				<h:inputHidden id="pageinit" value="#{autoclassmanagerlistBB.pageInit}" />
				<h:inputHidden id="arrangeId" value="#{autoclassmanagerlistBB.amaId}" />
		<h:panelGrid columns="8">

		</h:panelGrid>
			<h:outputText value="所属部门："></h:outputText>
			   <h:selectOneMenu id="orgValue" value="#{autoclassmanagerlistBB.orgValue}"
				valueChangeListener="#{autoclassmanagerlistBB.changeOrgValue}">
				<c:selectItems value="#{autoclassmanagerlistBB.orgValuelist}"></c:selectItems>
			</h:selectOneMenu>
			<h:commandButton value="查询" styleClass="button01" action="#{autoclassmanagerlistBB.find}" onclick="showProcessBar();"></h:commandButton>
            <h:commandButton value="排班" styleClass="button01" action="#{autoclassmanagerlistBB.arrangeClass}" rendered="#{autoclassmanagerlistBB.isExist==false}" onclick="showProcessBar();"></h:commandButton>
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
      			<h:selectOneRadio value="#{autoclassmanagerlistBB.tableType}"
				onclick="submit();">
				<f:selectItem itemValue="1" itemLabel="日历形式" />
				<f:selectItem itemValue="2" itemLabel="表格形式" />
			</h:selectOneRadio>
			</h:form> <f:verbatim></td>
		</tr>
</f:verbatim>
<h:panelGroup rendered="#{autoclassmanagerlistBB.tableType=='1'}">
<f:verbatim>		
		<%
			List lists = (List) session.getAttribute("lists");				
				String weekName= (String) session.getAttribute("lists1");
				int weekNumber=0;
				if(weekName!=null && !"".equals(weekName)){
					if("日".equals(weekName)){
						weekNumber=0;
					}else if("一".equals(weekName)){
						weekNumber=1;
					}else if("二".equals(weekName)){
						weekNumber=2;
					}else if("三".equals(weekName)){
						weekNumber=3;
					}else if("四".equals(weekName)){
						weekNumber=4;
					}else if("五".equals(weekName)){
						weekNumber=5;
					}else if("六".equals(weekName)){
						weekNumber=6;
					}
				}
				List list1=new ArrayList();
				for(int m=0;m<weekNumber;m++){
					String b = "value,empty,empty,empty";
					list1.add(b);
				}
				List list2=new ArrayList();
				list2.addAll(list1);
				list2.addAll(lists);
				
				int p = list2.size();
				if (p > 7) {
					int q = 7;
					int n = p % 7;
					int m = 7 - n;
					for (int j = 0; j < m; j++) {
						String b = "value,empty,empty,empty";
						list2.add(b);
					}
				} else {
					int m = 7 - p;
					for (int j = 0; j < m; j++) {
						String b = "value,empty,empty,empty";
						list2.add(b);
					}
				}
		%>
		<tr>
			<td>
			<table border="1" class='table_css1' width="95%">
			  <tr>
			     <td class='td_class'>日</td>
			     <td class='td_class'>一</td>
			     <td class='td_class'>二</td>
			     <td class='td_class'>三</td>
			     <td class='td_class'>四</td>
			     <td class='td_class'>五</td>
			     <td class='td_class'>六</td>
			   </tr>
				<%
					if (list2 != null && list2.size() > 0) {
							for (int i = 0; i < list2.size(); i += 7) {
								String str = (String) list2.get(i);
								String[] strs = str.split(",");
								String strs1 = strs[0];
								String strs2 = strs[1];
								String strs3 = strs[2];
								String strs4 = strs[3];
								String str1 = (String) list2.get(i + 1);
								String[] str1s = str1.split(",");
								String str1s1 = str1s[0];
								String str1s2 = str1s[1];
								String str1s3 = str1s[2];
								String str1s4 = str1s[3];
								String str2 = (String) list2.get(i + 2);
								String[] str2s = str2.split(",");
								String str2s1 = str2s[0];
								String str2s2 = str2s[1];
								String str2s3 = str2s[2];
								String str2s4 = str2s[3];
								String str3 = (String) list2.get(i + 3);
								String[] str3s = str3.split(",");
								String str3s1 = str3s[0];
								String str3s2 = str3s[1];
								String str3s3 = str3s[2];
								String str3s4 = str3s[3];
								String str4 = (String) list2.get(i + 4);
								String[] str4s = str4.split(",");
								String str4s1 = str4s[0];
								String str4s2 = str4s[1];
								String str4s3 = str4s[2];
								String str4s4 = str4s[3];
								String str5 = (String) list2.get(i + 5);
								String[] str5s = str5.split(",");
								String str5s1 = str5s[0];
								String str5s2 = str5s[1];
								String str5s3 = str5s[2];
								String str5s4 = str5s[3];
								String str6 = (String) list2.get(i + 6);
								String[] str6s = str6.split(",");
								String str6s1 = str6s[0];
								String str6s2 = str6s[1];
								String str6s3 = str6s[2];
								String str6s4 = str6s[3];
				%>
				<tr>
					<%
						if (!"value".equals(strs1)) {
										if (!"empty".equals(strs2)) {
					%>
					<td class='td_class' onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'" onclick="GetDate('<%=strs4%>','<%=strs1%>')"><b><%=strs1%></b><font color="red"><br>出勤人数:(<%=strs2 %>人)<br>休息人数:(<%=strs3 %>人)</font></td>
					<%
						} else {
					%>
					<td class='td_class'><%=strs1%></td>
					<%
						}
									} else {
					%>
					<td class='td_class'></td>
					<%
						}
					%>

					<%
						if (!"value".equals(str1s1)) {
										if (!"empty".equals(str1s2)) {
					%>
					<td class='td_class' onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'" onclick="GetDate('<%=str1s4%>','<%=str1s1%>')"><b><%=str1s1%></b><font color="red"><br>出勤人数:(<%=str1s2 %>人)<br>休息人数:(<%=str1s3 %>人)</font></td>
					<%
						} else {
					%>
					<td class='td_class'><%=str1s1%></td>
					<%
						}
									} else {
					%>
					<td class='td_class'></td>
					<%
						}
					%>

					<%
						if (!"value".equals(str2s1)) {
										if (!"empty".equals(str2s2)) {
					%>
					<td class='td_class' onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'" onclick="GetDate('<%=str2s4%>','<%=str2s1%>')"><b><%=str2s1%></b><font color="red"><br>出勤人数:(<%=str2s2 %>人)<br>休息人数:(<%=str2s3 %>人)</font></td>
					<%
						} else {
					%>
					<td class='td_class'><%=str2s1%></td>
					<%
						}
									} else {
					%>
					<td class='td_class'></td>
					<%
						}
					%>

					<%
						if (!"value".equals(str3s1)) {
										if (!"empty".equals(str3s2)) {
					%>
					<td class='td_class' onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'" onclick="GetDate('<%=str3s4%>','<%=str3s1%>')"><b><%=str3s1%></b><font color="red"><br>出勤人数:(<%=str3s2 %>人)<br>休息人数:(<%=str3s3 %>人)</font></td>
					<%
						} else {
					%>
					<td class='td_class'><%=str3s1%></td>
					<%
						}
									} else {
					%>
					<td class='td_class'></td>
					<%
						}
					%>

					<%
						if (!"value".equals(str4s1)) {
										if (!"empty".equals(str4s2)) {
					%>
					<td class='td_class' onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'" onclick="GetDate('<%=str4s4%>','<%=str4s1%>')"><b><%=str4s1%></b><font color="red"><br>出勤人数:(<%=str4s2 %>人)<br>休息人数:(<%=str4s3 %>人)</font></td>
					<%
						} else {
					%>
					<td class='td_class'><%=str4s1%></td>
					<%
						}
									} else {
					%>
					<td class='td_class'></td>
					<%
						}
					%>

					<%
						if (!"value".equals(str5s1)) {
										if (!"empty".equals(str5s2)) {
					%>
					<td class='td_class' onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'" onclick="GetDate('<%=str5s4%>','<%=str5s1%>')"><b><%=str5s1%></b><font color="red"><br>出勤人数:(<%=str5s2 %>人)<br>休息人数:(<%=str5s3 %>人)</font></td>
					<%
						} else {
					%>
					<td class='td_class'><%=str5s1%></td>
					<%
						}
									} else {
					%>
					<td class='td_class'></td>
					<%
						}
					%>

					<%
						if (!"value".equals(str6s1)) {
										if (!"empty".equals(str6s2)) {
					%>
					<td class='td_class' onmousemove="this.className='bg-hover'" onmouseout="this.className='td_class'" onclick="GetDate('<%=str6s4%>','<%=str6s1%>')"><b><%=str6s1%></b><font color="red"><br>出勤人数:(<%=str6s2 %>人)<br>休息人数:(<%=str6s3 %>人)</font></td>
					<%
						} else {
					%>
					<td class='td_class'><%=str6s1%></td>
					<%
						}
									} else {
					%>
					<td class='td_class'></td>
					<%
						}
					%>
				</tr>
				<%
					}
						}
				%>
			</table>
			</td>
		</tr>
		</f:verbatim>
</h:panelGroup>
        <f:verbatim>	
	</table>
	</f:verbatim>
	<h:panelGroup rendered="#{autoclassmanagerlistBB.tableType=='2'}">
	<f:verbatim>
	    <table width="95%" border="0" cellspacing="0" cellpadding="0" id="control" valign="top">
    <tr>
        <td align="right">
            <input type="button" class="button01" onclick="print1()" value=" 打印 ">
            <input name="b1" type="button" class="button01" value="导出到Excel" onclick="exportToExcel()">          
        </td>
    </tr>
</table>
	<table id="dtable" border="1" class='table_css1' width="100%">
	<tr>
	  			 <td class='td_class'>日期</td>
			     <td class='td_class'>星期</td>
			     <td class='td_class'>工作人员</td>
			     <td class='td_class'>休息人员</td>
	</tr>
	<%
	List lists2 = (List) session.getAttribute("lists2");
	if(lists2!=null && lists2.size()>0){
		Hashtable hashTableValuelist1 = (Hashtable) session.getAttribute("hashTableValuelist1");
		Hashtable hashTableValuelist2 = (Hashtable) session.getAttribute("hashTableValuelist2");
		Hashtable hashTableValuelist3 = (Hashtable) session.getAttribute("hashTableValuelist3");
	 for(int i=0;i<lists2.size();i++){
		 String dayvalue=(String)lists2.get(i);
		 String weeknamevalue=(String)hashTableValuelist1.get(dayvalue);
		 if(weeknamevalue==null || "".equals(weeknamevalue)){
			 weeknamevalue="-";
		 }
		 String worknamevalue=(String)hashTableValuelist2.get(dayvalue);
		 if(worknamevalue==null || "".equals(worknamevalue)){
			 worknamevalue="-";
		 }
		 String restnamevalue=(String)hashTableValuelist3.get(dayvalue);
		 if(restnamevalue==null || "".equals(restnamevalue)){
			 restnamevalue="-";
		 }
	%>
		<tr>
	  			 <td class='td_class'><%=dayvalue %></td>
			     <td class='td_class'><%=weeknamevalue %></td>
			     <td class='td_class'>
			     <table>
			      <tr> 
			       <td><%=worknamevalue %></td>
			      </tr>
			     </table>
			     </td>
			     <td class='td_class'>
			      <table>
			       <tr> 
			       <td><%=restnamevalue %></td>
			       </tr>
			      </table>
			     </td>
	</tr>
	<%
	 }}
	%>
	</table>
</f:verbatim>
</h:panelGroup>
