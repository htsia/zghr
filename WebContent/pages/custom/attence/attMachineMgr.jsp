<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
    function addRecuNeed(){
        window.showModalDialog("/custom/attence/attMachineEdit.jsf?act=init", "", "dialogWidth:350px; dialogHeight:200px; status:0;resizable:yes");
        return true;
    }
	function modify(id){
	    window.showModalDialog("/custom/attence/attMachineEdit.jsf?act=init&machineID="+id, "", "dialogWidth:320px; dialogHeight:200px; status:0;resizable:yes");
	    return true;
	}
	function process(){
		x = document.body.clientWidth / 2 - 150;
		y = document.body.clientHeight / 2;
		document.all('processbar').style.top = y;
		document.all('processbar').style.left = x;
		document.all('processbar').style.display = "";
    }
	
	function selIP(){
	    var item = document.getElementsByName("selectItem");
        var selId="";
        if(item.length>0){
            for(var i=0;i<item.length;i++){
                if(item[i].checked)
                {
                	selId+=item[i].value+",";    
                }
            }
        }
        if(selId==""){
        	alert("请选择考勤机");
        	return false;
        }
        document.all("form1:ips").value=selId;
        return true;
	}
	
	function forClearFinger(){
		if(confirm('确定要清除吗?这样会清除所选考勤机所有人员指纹信息')){
			if(selIP()){
				process();
				return true;
			}
		}
		return false;
	}
	function forClearFinger1(){
		if(confirm('确定要清除吗?这样会清除该考勤机所有人员指纹信息')){
			process();
			return true;
		}
		return false;
	}
	
	function forClearLog(){
		if(confirm('确定要清除吗?这样会清除所选考勤机所有人员打卡记录')){
			if(selIP()){
				process();
				return true;
			}
		}
		return false;
	}
	function forClearLog1(){
		if(confirm('确定要清除吗?这样会清除该考勤机所有人员打卡记录')){
			process();
			return true;
		}
		return false;
	}
	function forDetail(){
		if(selIP()){
			process();			
		}
		return false;
	}
	function forDownloadLog(){
		if(selIP()){
			process();
			return true;
		}
		return false;
	}
	
</script>
<x:saveState value="#{attMachineMgrBB}"></x:saveState>
<h:inputHidden value="#{attMachineMgrBB.pageInit}"/>
<h:form id="form1">
	<h:inputHidden id="ips" value="#{attMachineMgrBB.selectedMachineIPs}"/>
	<c:verbatim>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> 考勤管理-> 考勤机管理</td>
        </tr>
    </table>
		<table height=95% width=100% align="center" valign="top">
			<tr>
				<td height=8></c:verbatim>
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left" columns="5">
						<h:outputText escape="false" value="<strong>批量操作：</strong>" />
						<h:commandButton value="清除所有人员" onclick="return forClearFinger();"
							action="#{attMachineMgrBB.clearUserInfo}" styleClass="button01"/>
						<h:commandButton value="清除考勤记录" onclick="return forClearLog();"
							action="#{attMachineMgrBB.clearLog}" styleClass="button01"/>
						<h:commandButton value="读取考勤记录" onclick="return forDownloadLog();"
							action="#{attMachineMgrBB.downloadLog}" styleClass="button01"/>
						<h:commandButton value="查看考勤机信息" onclick="return forDetail();"
						    action="#{attMachineMgrBB.machineDetail}" styleClass="button01"/>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">
						<h:panelGroup>
							<h:outputText
								value="记录数:#{attMachineMgrBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="页数:#{attMachineMgrBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="每页有#{attMachineMgrBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="当前为第#{attMachineMgrBB.mypage.currentPage}页"></h:outputText>
							<h:commandButton value="首页"
								action="#{attMachineMgrBB.first}" styleClass="button01"></h:commandButton>
							<h:commandButton value="上页"
								action="#{attMachineMgrBB.pre}" styleClass="button01"></h:commandButton>
							<h:commandButton value="下页"
								action="#{attMachineMgrBB.next}" styleClass="button01"></h:commandButton>
							<h:commandButton value="尾页"
								action="#{attMachineMgrBB.last}" styleClass="button01"></h:commandButton>
						</h:panelGroup>
						<h:commandButton value="添加" onclick="return addRecuNeed();"
							styleClass="button01"></h:commandButton>
					</h:panelGrid>
					<br />
				</h:panelGrid> <c:verbatim></td>
			</tr>

			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim> <x:dataTable
					value="#{attMachineMgrBB.list}" var="list"
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="100%" border="0">

					<h:column>
				        <f:facet name="header">
				            <f:verbatim escape="false">
				                <input type="checkbox" name="all"
				                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
				            </f:verbatim>
				        </f:facet>
				        <f:verbatim escape="false">
				            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim><h:outputText value="#{list.machineIP}"/><f:verbatim escape="false">"/></div></f:verbatim>
				    </h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="考勤机名称" />
						</c:facet>
						<h:outputText value="#{list.machineName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="考勤机IP" />
						</c:facet>
						<h:outputText value="#{list.machineIP}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="是否主考勤机" />
						</c:facet>
						<h:outputText value="#{list.machineTypeName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="考勤记录" />
						</c:facet>
						<h:outputText value="#{list.log}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="管理员数" />
						</c:facet>
						<h:outputText value="#{list.manager}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="用户数" />
						</c:facet>
						<h:outputText value="#{list.user}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="指纹数" />
						</c:facet>
						<h:outputText value="#{list.finger}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="密码数" />
						</c:facet>
						<h:outputText value="#{list.password}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="状态" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="操作" />
						</c:facet>
						<h:commandButton value="编辑"
							onclick="return modify('#{list.machineID}')"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="删除" onclick="return confirm('确定要删除吗?');"
							action="#{attMachineMgrBB.delete}" styleClass="button01">
							<x:updateActionListener property="#{attMachineMgrBB.operMachineID}"
								value="#{list.machineID}" />
						</h:commandButton>
						<h:outputText value="  "/>						
						<h:commandButton value="读取考勤记录" onclick="process();"
							action="#{attMachineMgrBB.downloadLog}" styleClass="button01">
							<x:updateActionListener property="#{attMachineMgrBB.operMachineIP}"
								value="#{list.machineIP}" />
						</h:commandButton>
						<c:verbatim><br/></c:verbatim>
						<h:commandButton value="清除所有人员" onclick="return forClearFinger1();"
							action="#{attMachineMgrBB.clearUserInfo}" styleClass="button01">
							<x:updateActionListener property="#{attMachineMgrBB.operMachineIP}"
								value="#{list.machineIP}" />					
						</h:commandButton>
						<h:commandButton value="清除考勤记录" onclick="return forClearLog1();"
							action="#{attMachineMgrBB.clearLog}" styleClass="button01">
							<x:updateActionListener property="#{attMachineMgrBB.operMachineIP}"
								value="#{list.machineIP}" />
						</h:commandButton>
						
					</h:column>
				</x:dataTable> <c:verbatim></div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none; border:1px solid #000000" direction="right" width="300"
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
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
</body>
