<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script type="text/javascript">
function forSave(){
	if (forCheck()== true) {
        debugger;   
        forsubmit(document.forms(0));
        return true ;
    }
	else {
		  return false ;
        }
	    }
  
    function forCheck(){
        if(document.all("form1:name").value == ""){
                alert("����Ʋ���Ϊ��!");
                document.all("form1:name").focus();
                return false;
               }
        if(document.all("form1:act_method").value == ""){
           alert("����Ͳ���Ϊ��!");
           document.all("form1:act_method").focus();
           return false;
          }
        else{
            return true ;
            }
        }


	function forPerson() {

		showx = event.screenX - event.offsetX - 150;
		showy = event.screenY - event.offsetY + 18;
		var retval = window.showModalDialog("/pages/common/ContactTreeSelPerson.jsp",
				"", "dialogWidth:900px; dialogHeight:500px; dialogLeft:"
						+ showx + "px; dialogTop:" + showy
						+ "px; status:0;resizable:yes");
		if (retval != null) {
			rs = retval.split(",");
			document.all("form1:conCode").value = rs[0];
			document.all("form1:conName").value = rs[1];
			document.all("form1:cuCode").value = rs[2];
			document.all("form1:cuName").value = rs[3];
		}
	}
</script>
<x:saveState value="#{actionBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{actionBB.editInit}"></h:inputHidden>
	<h:inputHidden value="#{actionBB.actId}"></h:inputHidden>
	<h:inputHidden id="conCode" value="#{actionBB.conId}"></h:inputHidden>
	<h:inputHidden id="cuCode" value="#{actionBB.cuId}"></h:inputHidden>

<h:panelGrid columns="1" styleClass="td_title" width="102%"
		align="center">
		<h:panelGroup >
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="�ͻ����� - >  ����� "></h:outputText>
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" align="center">

		<h:panelGroup>
				<h:panelGrid align="right">
					<h:commandButton value="����" onclick="return forSave();"
						styleClass="button01" action="#{actionBB.saveOrUpdate}" />
				</h:panelGrid>
		</h:panelGroup>

		<h:panelGroup>

			<h:panelGrid columns="1" columnClasses="table02" align="center">

				<h:panelGroup>
					<h:panelGrid columns="1" >

						<h:panelGroup>
							<h:panelGrid align="left">
								<h:outputText value="������Ϣ   :"></h:outputText>
							</h:panelGrid>
						</h:panelGroup>

						<h:panelGroup >
							<h:panelGrid columns="4" styleClass="td_form01">
								<h:outputText value="�����  " styleClass="f07"></h:outputText>
								<h:panelGroup>
									<h:inputText id="name"  
										value="#{actionBB.actionBO.act_name}"></h:inputText>
									<h:inputText style="display:none"
										value="#{actionBB.actionBO.act_id}" />
								</h:panelGroup>
								<h:outputText value="�����  "  styleClass="f07"></h:outputText>
								<h:panelGroup>
									<h:inputText styleClass="inputDark" id="act_method" code=""
										dict="yes" dict_num="2901" readonly="true"
										value="#{actionBB.actionBO.act_method}"></h:inputText>
									<h:commandButton type="button" styleClass="button_select"
										onclick="PopUpCodeDlgOneControl('form1:act_method')" />
								</h:panelGroup>


								<h:outputText value="��  ��  ��  "></h:outputText>
								<h:inputText readonly="true" styleClass="inputDark"
									value="#{actionBB.actionBO.create_or}"></h:inputText>
								<h:outputText value="��  ϵ  ��  "></h:outputText>
								<h:panelGroup>
									<h:inputText styleClass="inputDark" id="conName" code=""
										dict="yes" dict_num="2901" readonly="true"
										value="#{actionBB.actionBO.conectionName}"></h:inputText>
									<h:commandButton type="button" styleClass="button_select"
										onclick="return forPerson();" />
								</h:panelGroup>
							</h:panelGrid>
						</h:panelGroup>
						<h:panelGroup styleClass="td_form01">
							<h:outputText value='�����ͻ�  '></h:outputText>
							<h:inputText styleClass="inputDark" readonly="true" id="cuName"
								value="#{actionBB.actionBO.customerName}"></h:inputText>
						</h:panelGroup>
						<h:panelGroup>
							<h:panelGrid columns="2" styleClass="td_form01">
								<h:outputText value="���ȼ���"></h:outputText>
								<h:selectOneRadio value="#{actionBB.actionBO.level}">
									<f:selectItem itemLabel="�߼�" itemValue="0" />
									<f:selectItem itemLabel="�ϸ�" itemValue="1" />
									<f:selectItem itemLabel="�м�" itemValue="2" />
									<f:selectItem itemLabel="�ͼ�" itemValue="3" />
									<f:selectItem itemLabel="�ϵ�" itemValue="4" />
								</h:selectOneRadio>
							</h:panelGrid>
						</h:panelGroup>

						<h:panelGroup>
							<h:panelGrid columns="2" styleClass="td_form01">
								<h:outputText value="״̬"></h:outputText>
								<h:selectOneRadio value="#{actionBB.actionBO.status}">
									<f:selectItem itemLabel="δ��ʼ" itemValue="0" />
									<f:selectItem itemLabel="������" itemValue="1" />
									<f:selectItem itemLabel="��ͣ" itemValue="2" />
									<f:selectItem itemLabel="���" itemValue="3" />
									<f:selectItem itemLabel="����" itemValue="4" />
								</h:selectOneRadio>
							</h:panelGrid>
						</h:panelGroup>

						<h:panelGroup>
							<h:panelGrid columns="2" styleClass="td_form01">
								<h:outputText value="��ַ��Ϣ"></h:outputText>
								<h:inputText  
									value="#{actionBB.actionBO.act_addr}" size="69"></h:inputText>
							</h:panelGrid>
						</h:panelGroup>

						<h:panelGroup>
							<h:panelGrid columns="2" styleClass="td_form01">
								<h:outputText value="��ɽ��"></h:outputText>
								<h:inputText  
									value="#{actionBB.actionBO.result}" size="69"></h:inputText>
							</h:panelGrid>
						</h:panelGroup>
						<h:panelGroup>
						</h:panelGroup>

					</h:panelGrid>

				</h:panelGroup>

              
				<h:panelGroup>
					<h:panelGrid columns="1"  >

						<h:panelGroup>
							<h:panelGrid align="left">
								<h:outputText value="�ճ̰���   :"></h:outputText>
							</h:panelGrid>
						</h:panelGroup>

						<h:panelGroup>
							<h:panelGrid columns="4" styleClass="td_form01">
								<h:outputText value="��ʼ����   "></h:outputText>
								<h:panelGroup>
									<h:inputText styleClass="inputDark" id="A001012"
										value="#{actionBB.actionBO.begin_date}" readonly="true"
										alt="��������|1|d|50||" />
									<h:commandButton type="button" styleClass="button_select"
										onclick="PopUpCalendarDialog('form1:A001012')" />
								</h:panelGroup>


								<h:outputText value="��ʼʱ��   "></h:outputText>
								<h:panelGroup>
									<h:selectOneMenu value="#{actionBB.actionBO.startHour}">
										<f:selectItems value="#{actionBB.hourItem}" />
									</h:selectOneMenu>
									<h:selectOneMenu value="#{actionBB.actionBO.startMinute}">
										<f:selectItems value="#{actionBB.minuteItem}" />
									</h:selectOneMenu>
								</h:panelGroup>


								<h:outputText value="��������   "></h:outputText>
								<h:panelGroup>
									<h:inputText styleClass="inputDark" id="A001014"
										value="#{actionBB.actionBO.end_date}" readonly="true"
										alt="��������|1|d|50||" />
									<h:commandButton type="button" styleClass="button_select"
										onclick="PopUpCalendarDialog('form1:A001014')" />
								</h:panelGroup>

								<h:outputText value="����ʱ��   "></h:outputText>
								<h:panelGroup>
									<h:selectOneMenu value="#{actionBB.actionBO.endHour}">
										<f:selectItems value="#{actionBB.hourItem}" />
									</h:selectOneMenu>
									<h:selectOneMenu value="#{actionBB.actionBO.endMinute}">
										<f:selectItems value="#{actionBB.minuteItem}" />
									</h:selectOneMenu>
								</h:panelGroup>
							</h:panelGrid>
						</h:panelGroup>
						
						 
							<h:panelGrid columns="2" styleClass="td_form01">
								<h:outputText value="��ǰ����ʱ��   "></h:outputText>
								<h:inputText  
									value="#{actionBB.actionBO.alert_day}"></h:inputText>
							</h:panelGrid>
						 
					</h:panelGrid>
				</h:panelGroup>
			</h:panelGrid>
		</h:panelGroup>
	</h:panelGrid>


</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>

















