<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<script language="javascript" src="<%=request.getContextPath()%>/js/maininterface.js"></script>
<script language="javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
<script type="text/javascript">
    function forSave(){
    	  if (forCheck()== true) {
    		 return   forsubmit(document.forms('form1'));
        }
     	  return false ;
    	   }

    function forCheck(){
     
        if(document.all("form1:name").value == ""){
                alert("�ͻ����ֲ���Ϊ��!");
                document.all("form1:name").focus();
                return false;
               }
        if(document.all("form1:cu_nation").value == ""){
            alert("�ͻ��������Ҳ���Ϊ��!");
            document.all("form1:cu_nation").focus();
            return false;
           }
        if(document.all("form1:cu_city").value == ""){
            alert("�ͻ����ڳ��в���Ϊ��!");
            document.all("form1:cu_city").focus();
            return false;
           }
        if(document.all("form1:name1").value == ""){
            alert("��ϵ����������Ϊ��!");
            document.all("form1:name1").focus();
            return false;
           }
        if(document.all("form1:sex").value == ""){
            alert("��ϵ���Ա��!");
            document.all("form1:sex").focus();
            return false;
           }
        if(document.all("form1:mobile").value == ""){
            alert("��ϵ�绰����Ϊ��!");
            document.all("form1:mobile").focus();
            return false;
           }
        return true ;
        }

   
</script>
<x:saveState value="#{customerBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{customerBB.updaeInit}"></h:inputHidden>
	<h:inputHidden value="#{customerBB.cuId}"></h:inputHidden>
	
	<h:panelGrid columns="1" styleClass="td_title" width="102%"
		align="center">
		<h:panelGroup >
			<h:graphicImage value="/images/tips.gif" />
			<h:outputText value="�ͻ����� - >  �༭�ͻ� "></h:outputText>
		</h:panelGroup>
	</h:panelGrid>

	<h:panelGrid columns="1" align="center">

		<h:panelGroup>
			<h:panelGrid columns="2" align="right">
				<h:commandButton value="����" onclick="javascript:return forSave();"
					styleClass="button01" action="#{customerBB.saveCustomer}" />
				<h:commandButton value="����" styleClass="button01"
					onclick="window.close();" />
			</h:panelGrid>
		</h:panelGroup>

		<h:panelGroup>

			<h:panelGrid columns="1" columnClasses="table02" align="center">

				<h:panelGroup>
					<h:panelGrid columns="1">

						<h:panelGroup>
							<h:panelGrid columns="1">
								<h:outputText value="�ͻ�������Ϣ    ��"></h:outputText>
							</h:panelGrid>
						</h:panelGroup>

						<h:panelGroup>
							<h:panelGrid columns="4" styleClass="td_form01">
								<h:outputText value="�ͻ�����" styleClass="f07" />
								<h:inputText id="name" value="#{customerBB.customerBO.cu_name}"></h:inputText>
								<h:outputText value="��        �� " styleClass="f07" />
								<h:panelGroup>
									<h:inputText id="cu_nation" code="" dict="yes" dict_num="0106"
										readonly="true" value="#{customerBB.customerBO.cu_nation}"></h:inputText>
									<h:commandButton type="button" styleClass="button_select"
										onclick="PopUpCodeDlgOneControl('form1:cu_nation')" />
								</h:panelGroup>

								<h:outputText value="��    ��" styleClass="f07" />
								<h:panelGroup>
									<h:inputText styleClass="inputDark" id="cu_city" code=""
										dict="yes" dict_num="0105" readonly="true"
										value="#{customerBB.customerBO.cu_city}"></h:inputText>
									<h:commandButton type="button" styleClass="button_select"
										onclick="PopUpCodeDlgOneControl('form1:cu_city')" />
								</h:panelGroup>
								<h:outputText value="�ͻ��ʱࣺ" />
								<h:inputText value="#{customerBB.customerBO.zip}"></h:inputText>


								<h:outputText value="�ͻ�����" />
								<h:panelGroup>
									<h:inputText styleClass="inputDark" id="cu_type" code=""
										dict="yes" dict_num="2227" readonly="true"
										value="#{customerBB.customerBO.cu_type}"></h:inputText>
									<h:commandButton type="button" styleClass="button_select"
										onclick="PopUpCodeDlgOneControl('form1:cu_type')" />
								</h:panelGroup>

								<h:outputText value="������ҵ " />
								<h:panelGroup>
									<h:inputText styleClass="inputDark" id="vocation" code=""
										dict="yes" dict_num="2228" readonly="true"
										value="#{customerBB.customerBO.vocation}"></h:inputText>
									<h:commandButton type="button" styleClass="button_select"
										onclick="PopUpCodeDlgOneControl('form1:vocation')" />
								</h:panelGroup>



							</h:panelGrid>
						</h:panelGroup>

						<h:panelGroup>
							<h:panelGrid columns="2" styleClass="td_form01">
							
							
								<h:outputText value="�ͻ���ַ" />
								<h:inputText value="#{customerBB.customerBO.cu_addr}" size="69"></h:inputText>

								<h:outputText value="�ͻ���վ" />
								<h:inputText value="#{customerBB.customerBO.web_url}" size="69"></h:inputText>

								<h:outputText value="�ͻ�����" />
								<h:inputTextarea value="#{customerBB.customerBO.description}"
									rows="5" cols="82">
								</h:inputTextarea>
							</h:panelGrid>
						</h:panelGroup>
					</h:panelGrid>
				</h:panelGroup>


				 


				<h:panelGroup rendered="#{customerBB.flag == 1}">
					<h:panelGrid columns="1">

						<h:panelGroup>
							<h:outputText rendered="#{customerBB.flag == 1}" value="��ϵ����Ϣ : "></h:outputText>
						</h:panelGroup>

						<h:panelGroup>
							<h:panelGrid columns="4" styleClass="td_form01">
								<h:outputText value="��        ��" styleClass="f07" />
								<h:inputText id="name1"
									value="#{customerBB.contactBO.person_name}" />
								<h:outputText value="��        ��" styleClass="f07" />
								<h:panelGroup>
									<h:inputText styleClass="inputDark" id="sex" code="" dict="yes"
										dict_num="0100" readonly="true"
										value="#{customerBB.contactBO.sex}"></h:inputText>
									<h:commandButton type="button" styleClass="button_select"
										onclick="PopUpCodeDlgOneControl('form1:sex')" />
								</h:panelGroup>

								<h:outputText value="����ϵ��" />
								<h:panelGroup>
									<h:inputText styleClass="inputDark" id="primaryPerson" code=""
										dict="yes" dict_num="0090" readonly="true"
										value="#{customerBB.contactBO.primaryPerson}"></h:inputText>
									<h:commandButton type="button" styleClass="button_select"
										onclick="PopUpCodeDlgOneControl('form1:primaryPerson')" />
								</h:panelGroup>
								<h:outputText value="ְλ" />
								<h:inputText id="duty" value="#{customerBB.contactBO.duty}" />


								<h:outputText styleClass="f07" value="�ֻ�" />
								<h:inputText id="mobile" value="#{customerBB.contactBO.mobile}" />
								<h:outputText value="��ͥ�绰" />
								<h:inputText id="home_tel"
									value="#{customerBB.contactBO.home_tel}" />


								<h:outputText value="�칫�绰" />
								<h:inputText id="office_tel"
									value="#{customerBB.contactBO.office_tel}" />
								<h:outputText value="QQ" />
								<h:inputText id="qq" value="#{customerBB.contactBO.qq}" />


								<h:outputText value="MSN" />
								<h:inputText id="msn" value="#{customerBB.contactBO.msn}" />
								<h:outputText value="����" />
								<h:inputText id="fax" value="#{customerBB.contactBO.fax}" />


								<h:outputText value="eMail" />
								<h:inputText id="email" value="#{customerBB.contactBO.email}" />

							</h:panelGrid>
						</h:panelGroup>
						<h:panelGroup>
							<h:panelGrid columns="2" styleClass="td_form01">
								<h:outputText value="�ͻ�����" />
								<h:inputTextarea value="#{customerBB.contactBO.remark}" rows="5"
									cols="82">
								</h:inputTextarea>
							</h:panelGrid>
						</h:panelGroup>
					</h:panelGrid>
				</h:panelGroup>
			</h:panelGrid>

		</h:panelGroup>
	</h:panelGrid>

</h:form>
<script type="text/javascript">
    interpret(document.forms(0));
</script>












