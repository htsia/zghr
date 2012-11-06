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
        	alert("��ѡ���ڻ�");
        	return false;
        }
        document.all("form1:ips").value=selId;
        return true;
	}
	
	function forClearFinger(){
		if(confirm('ȷ��Ҫ�����?�����������ѡ���ڻ�������Աָ����Ϣ')){
			if(selIP()){
				process();
				return true;
			}
		}
		return false;
	}
	function forClearFinger1(){
		if(confirm('ȷ��Ҫ�����?����������ÿ��ڻ�������Աָ����Ϣ')){
			process();
			return true;
		}
		return false;
	}
	
	function forClearLog(){
		if(confirm('ȷ��Ҫ�����?�����������ѡ���ڻ�������Ա�򿨼�¼')){
			if(selIP()){
				process();
				return true;
			}
		}
		return false;
	}
	function forClearLog1(){
		if(confirm('ȷ��Ҫ�����?����������ÿ��ڻ�������Ա�򿨼�¼')){
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
            <td class="td_title"><img src="/images/tips.gif"> ���ڹ���-> ���ڻ�����</td>
        </tr>
    </table>
		<table height=95% width=100% align="center" valign="top">
			<tr>
				<td height=8></c:verbatim>
				<h:panelGrid width="98%" columns="2">
					<h:panelGrid align="left" columns="5">
						<h:outputText escape="false" value="<strong>����������</strong>" />
						<h:commandButton value="���������Ա" onclick="return forClearFinger();"
							action="#{attMachineMgrBB.clearUserInfo}" styleClass="button01"/>
						<h:commandButton value="������ڼ�¼" onclick="return forClearLog();"
							action="#{attMachineMgrBB.clearLog}" styleClass="button01"/>
						<h:commandButton value="��ȡ���ڼ�¼" onclick="return forDownloadLog();"
							action="#{attMachineMgrBB.downloadLog}" styleClass="button01"/>
						<h:commandButton value="�鿴���ڻ���Ϣ" onclick="return forDetail();"
						    action="#{attMachineMgrBB.machineDetail}" styleClass="button01"/>
					</h:panelGrid>
					<h:panelGrid align="right" columns="2">
						<h:panelGroup>
							<h:outputText
								value="��¼��:#{attMachineMgrBB.mypage.totalRecord}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="ҳ��:#{attMachineMgrBB.mypage.totalPage}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="ÿҳ��#{attMachineMgrBB.mypage.pageSize}"></h:outputText>
							<h:outputText value="  "></h:outputText>
							<h:outputText
								value="��ǰΪ��#{attMachineMgrBB.mypage.currentPage}ҳ"></h:outputText>
							<h:commandButton value="��ҳ"
								action="#{attMachineMgrBB.first}" styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ"
								action="#{attMachineMgrBB.pre}" styleClass="button01"></h:commandButton>
							<h:commandButton value="��ҳ"
								action="#{attMachineMgrBB.next}" styleClass="button01"></h:commandButton>
							<h:commandButton value="βҳ"
								action="#{attMachineMgrBB.last}" styleClass="button01"></h:commandButton>
						</h:panelGroup>
						<h:commandButton value="���" onclick="return addRecuNeed();"
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
							<h:outputText value="���ڻ�����" />
						</c:facet>
						<h:outputText value="#{list.machineName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="���ڻ�IP" />
						</c:facet>
						<h:outputText value="#{list.machineIP}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="�Ƿ������ڻ�" />
						</c:facet>
						<h:outputText value="#{list.machineTypeName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="���ڼ�¼" />
						</c:facet>
						<h:outputText value="#{list.log}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����Ա��" />
						</c:facet>
						<h:outputText value="#{list.manager}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="�û���" />
						</c:facet>
						<h:outputText value="#{list.user}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="ָ����" />
						</c:facet>
						<h:outputText value="#{list.finger}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="������" />
						</c:facet>
						<h:outputText value="#{list.password}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="״̬" />
						</c:facet>
						<h:outputText value="#{list.status}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="�༭"
							onclick="return modify('#{list.machineID}')"
							styleClass="button01"></h:commandButton>
						<h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');"
							action="#{attMachineMgrBB.delete}" styleClass="button01">
							<x:updateActionListener property="#{attMachineMgrBB.operMachineID}"
								value="#{list.machineID}" />
						</h:commandButton>
						<h:outputText value="  "/>						
						<h:commandButton value="��ȡ���ڼ�¼" onclick="process();"
							action="#{attMachineMgrBB.downloadLog}" styleClass="button01">
							<x:updateActionListener property="#{attMachineMgrBB.operMachineIP}"
								value="#{list.machineIP}" />
						</h:commandButton>
						<c:verbatim><br/></c:verbatim>
						<h:commandButton value="���������Ա" onclick="return forClearFinger1();"
							action="#{attMachineMgrBB.clearUserInfo}" styleClass="button01">
							<x:updateActionListener property="#{attMachineMgrBB.operMachineIP}"
								value="#{list.machineIP}" />					
						</h:commandButton>
						<h:commandButton value="������ڼ�¼" onclick="return forClearLog1();"
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
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
</body>
