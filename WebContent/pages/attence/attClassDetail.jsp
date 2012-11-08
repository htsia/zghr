<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<script type="text/javascript">
	function forsave(){
		var pass=false;
		var date = $("input[code]");
		var am1=date.eq(0).val();
		var am2=date.eq(1).val();
		var am3=date.eq(2).val();
		var am4=date.eq(3).val();
		var pm1=date.eq(4).val();
		var pm2=date.eq(5).val();
		var pm3=date.eq(6).val();
		var pm4=date.eq(7).val();
		var hasam=(am1!='' || am2!='' || am3!='' || am4!='');
		var haspm=(pm1!='' || pm2!='' || pm3!='' || pm4!='');
		if(hasam && haspm){//ȫ���
			if(pm4<=pm3 || pm3<=pm2 || pm2<=pm1 || pm1<=am4 || am4<=am3 || am3<=am2 || am2<=am1 ||
					am1=='' || am2=='' || am3=='' || am4=='' || pm1=='' || pm2=='' || pm3=='' || pm4==''){
				alert("ȫ���ʱ����д����");
				pass= false;
			}else{
				pass= true;
			}
		}else if(hasam){//�����
			if(am4<=am3 || am3<=am2 || am2<=am1 || am1=='' || am2=='' || am3=='' || am4==''){
				alert("�����ʱ����д����");
				pass= false;
			}else{
				pass= true;
			}
		}else if(haspm){//�����
			if(pm4<=pm3 || pm3<=pm2 || pm2<=pm1 || pm1=='' || pm2=='' || pm3=='' || pm4==''){
				alert("�����ʱ����д����");
				pass= false;
			}else{
				pass= true;
			}
		}else{
			alert("����дʱ��");
			pass= false;
		}
		if(pass){
			var detail="";
			date.each(function(e){
				var d=$(this).val();
				if(d!=''){
					detail+=$(this).attr("code")+"-"+d+",";
				}
			});
			document.all("form1:detailStr").value=detail;
		}
		return pass;
	}
</script>
<x:saveState value="#{att_class_detailBB}"/>
<h:inputHidden value="#{att_class_detailBB.pageInit}"/>
<h:form id="form1">
<h:inputHidden id="detailStr" value="#{att_class_detailBB.detailStr}"/>
	<h:panelGrid columns="1" styleClass="td_title" width="98%"
		align="center">
		<h:panelGroup>
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="����ʱ�� -> #{att_class_detailBB.className}" />
		</h:panelGroup>
	</h:panelGrid>
	<c:verbatim>
		<table height=80% width=98% align="center">
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto'
					id="datatable" align="center"></c:verbatim>
					<x:dataTable value="#{att_class_detailBB.detailList}" var="list" 
					rowIndexVar="index" id="dateList" headerClass="td_top tr_fixrow"
					columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
					styleClass="table03" width="90%" border="0">

					<h:column>
						<c:facet name="header">
							<h:outputText value="���" />
						</c:facet>
						<h:outputText value="#{index+1}" />
					</h:column>

					<h:column>
						<c:facet name="header">
							<h:outputText value="ʱ������" />
						</c:facet>
						<h:outputText value="#{list.itemName}" />
					</h:column>
					<h:column>
						<c:facet name="header">
							<h:outputText value="ʱ��"  />
						</c:facet>
						<h:inputText code="#{list.itemID}" value="#{list.itemTime}" readonly="true" size="10" styleClass="input" onclick="WdatePicker({startDate:'%H:%m',dateFmt:'HH:mm'})"/>
					</h:column>
				</x:dataTable> 
				<h:panelGrid>
				<f:verbatim><br/></f:verbatim>
					<h:commandButton onclick="return forsave()" value="  ��  ��  " action="#{att_class_detailBB.saveClassDetail}"/>
				</h:panelGrid>
				<c:verbatim>
				</div>
				</td>
			</tr>
		</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
	setDataTableOver("form1:dateList");
</script>
</body>
