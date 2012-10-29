<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.wage.pojo.vo.WageStandardVO" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.util.CodeUtil"%>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.wage.pojo.bo.*"%>
<%@ page import="com.hr319wg.wage.ucc.impl.WageReformMgrUcc" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<c:verbatim>

    <style type="text/css">
        <!--
        .td_top {
            background-color: #EDECE2;
            font-family: "Tahoma";
            FONT-SIZE: 11px;
            color: #7C5618;
            padding: 4px;
            border-collapse: collapse;
            border-top: 0px none;
            border-right: 2px solid #FFFFFF;
            border-bottom: 2px solid #FFFFFF;
            border-left: 0px none;
        }

        .td_02 {
            background-color: #F2F2F2;
            font-family: "Tahoma";
            FONT-SIZE: 11px;
            color: #000000;
            padding: 4px;
            border-collapse: collapse;
            border-top: 0px none;
            border-right: 2px solid #FFFFFF;
            border-bottom: 2px solid #FFFFFF;
            border-left: 0px none;
        }

        .input {
            BORDER-RIGHT: 1px solid;
            BORDER-TOP: 1px solid;
            BORDER-LEFT: 1px solid;
            BORDER-BOTTOM: 1px solid;
            COLOR: #000000;
            FONT-SIZE: 11px;
            font-family: "Tahoma";
            HEIGHT: 20px;
            background-color: #F2F2F2
        }

        .td_form02 {
            background-color: #F2F2F2;
            font-family: "Tahoma";
            FONT-SIZE: 11px;
            color: #000000;
            padding: 0px;
            border-collapse: collapse;
            border-top: 0px solid;
            border-right: 2px solid #FFFFFF;
            border-bottom: 2px solid #FFFFFF;
            border-left: 0px solid;
        }
        -->
    </style>
</c:verbatim>
<c:verbatim><script language=javascript src="/js/list.js"></script></c:verbatim>
<script>
	function setWageSetYear(){
		var setId=document.all("form1:setID").value;
		window.showModalDialog("/wage/adjust/reformColList.jsf?setId="+setId, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:no;");
		return true;
	}
	function setPostYear(){
		var setId=document.all("form1:setID").value;
		window.showModalDialog("/wage/adjust/reformRowList.jsf?setId="+setId, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:no;");
		return true;
	}
</script>
<x:saveState value="#{wageReformMgrBB}"></x:saveState>
<h:form id="form1">
<h:inputHidden value="#{wageReformMgrBB.pageInit}"></h:inputHidden>
<h:inputHidden id="setID" value="#{wageReformMgrBB.setID}"></h:inputHidden>
<%
	List colList=(ArrayList)session.getAttribute("colList");
	List rowList=(ArrayList)session.getAttribute("rowList");
	Hashtable hash=(Hashtable)session.getAttribute("hash");
%>
<c:verbatim>
<table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr><td height=8></td></tr>
    <tr>
    	<td align="center">
</c:verbatim>
            <h:commandButton styleClass="button01" value="套改年限配置" style="button" onclick="setWageSetYear()"/>
            <h:outputText value=" "></h:outputText>
            <h:commandButton styleClass="button01" value="岗位任职年限配置" style="button" onclick="setPostYear()"/>
<c:verbatim>
		</td>
    
        <td align="left">
</c:verbatim>
            <h:commandButton styleClass="button01" value="保存" action="#{wageReformMgrBB.saveWage}"/>
<c:verbatim>
	</td>
    </tr>
</table>

<div style='width:100%;height:93%;overflow:auto' id=datatable>
<table width="95%" align="center" id="dateList" >
	<tr>
		<td class="locked_top td_fixtop" width="200px">
		<table width="180px" height="100%">
			<tr>
				<td style="color: #7C5618;border-right: 2px solid #FFFFFF;" width="100">薪级</td>
				<td style="color: #7C5618;border-bottom: 2px solid #FFFFFF;" width="100">套改年限</td>
			</tr>
			<tr>
				<td style="color: #7C5618;border-right: 2px solid #FFFFFF;">岗位</td>
				<td style="color: #7C5618;">任职年限</td>
			</tr>
		</table>
		</td>
<%
		if(colList!=null&&colList.size()>0){
			for(int i=0;i<colList.size();i++){
				WageReformColBO bo=(WageReformColBO)colList.get(i);
%>
				<td class="locked_top td_fixtop"><%=bo.getTitle() %></td>
<%
			}
		}
%>
	</tr>
<%
		if(rowList!=null&&rowList.size()>0){
			for(int i=0;i<rowList.size();i++){	
				WageReformRowBO bo=(WageReformRowBO)rowList.get(i);
%>
	<tr>
		<td  width="200" class="locked_top td_fixcol"><table width="100%" height="100%">
		<tr>
		<td style="color: #7C5618;border-right: 2px solid #FFFFFF;" width="100" ><%=CodeUtil.interpertCode(bo.getJobLevel())%></td>
		<td style="color: #7C5618;" width="100"><%=bo.getTitle()%></td>
		</tr>
		</table></td>
<%				
				WageReformMgrUcc rc = (WageReformMgrUcc) SysContext.getBean("wageReformMgrucc");
				if(colList!=null&&colList.size()>0){
					for(int j=0;j<colList.size();j++){
						WageReformColBO colbo=(WageReformColBO)colList.get(j);
						WageReformDataBO databo=(WageReformDataBO)hash.get(bo.getRowId()+colbo.getColId());
						String name=bo.getRowId()+"-"+colbo.getColId();
						if(databo!=null&&databo.getDataValue()!=null&&!databo.getDataValue().equals("")){
%>
						<td class="td_form02"><input class="input" type="text" name="<%=name%>" value="<%=databo.getDataValue()%>" size="5"/></td>
<% 
						}else{
%>
						<td class="td_form02"><input class="input" type="text" name="<%=name%>" size="5"/></td>
<% 							
						}
					}
				}
%>
	</tr>
<%
			}
		}
%>
</table>
</div>
</c:verbatim>
</h:form>
<script type="text/javascript">
   tableFixCol=1;// 锁定两列
   listControl=document.all("dateList");
   window.setInterval('setFixCol()', 700);
</script>