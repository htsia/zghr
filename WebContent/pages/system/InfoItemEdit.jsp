<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%  
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
    function forDataType(actType){
        var form = document.forms(0);
        form["formInfoItemEdit:itemDefaultValue"].dict_num="";
        form["formInfoItemEdit:itemDefaultValue"].dict="";
        form["formInfoItemEdit:helpButton"].disabled="true"

        var len=form["formInfoItemEdit:itemDataType"].options.length;
        var opt=form["formInfoItemEdit:itemDataType"].options;
        if(1==actType){
            form["formInfoItemEdit:itemDefaultValue"].value="";
        }

        if(opt(5).selected){  //������
            form["formInfoItemEdit:itemIsSelect"].disabled=false;
            form["formInfoItemEdit:itemCodeSet"].disabled=false;
            form["formInfoItemEdit:itemDataLength"].disabled=true;
            form["formInfoItemEdit:itemMax"].disabled=true;
            form["formInfoItemEdit:itemMin"].disabled=true;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemDefaultValue"].dict_num="";
            form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            form["formInfoItemEdit:helpButton"].disabled=false;
        }else if( opt(6).selected  //��������
                || opt(7).selected  //��Ա
                || opt(10).selected  //��λ
                || opt(11).selected  // ����֯
                || opt(12).selected){  //н�ʻ���
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=true;
            form["formInfoItemEdit:itemMax"].disabled=true;
            form["formInfoItemEdit:itemMin"].disabled=true;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:helpButton"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
            if(opt(6).selected) {    //����
               form["formInfoItemEdit:itemDefaultValue"].dict_num="OU";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            }else if(opt(7).selected){ //��Ա
                form["formInfoItemEdit:itemDefaultValue"].dict_num="PE";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            }else if(opt(10).selected){  // ��λ
                form["formInfoItemEdit:itemDefaultValue"].dict_num="PO";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            }else if(opt(11).selected){  // ����֯
                form["formInfoItemEdit:itemDefaultValue"].dict_num="PA";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes";
            }else if(opt(12).selected){  // ����֯
                form["formInfoItemEdit:itemDefaultValue"].dict_num="WA";
                form["formInfoItemEdit:itemDefaultValue"].dict="yes" ;
            }
        }else  if(opt(9).selected){    //��������
           form["formInfoItemEdit:itemIsSelect"].disabled=true;
            form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=true;
            form["formInfoItemEdit:itemMax"].disabled=false;
            form["formInfoItemEdit:itemMin"].disabled=false;
            form["formInfoItemEdit:itemDefaultValue"].disabled=true;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
            //forsetdefault()
        }else if(opt(2).selected){      //�ַ�
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=false;
            form["formInfoItemEdit:itemMax"].disabled=true;
            form["formInfoItemEdit:itemMin"].disabled=true;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
        }else if(opt(0).selected){ //����
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            //form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=false;
            form["formInfoItemEdit:itemMax"].disabled=false;
            form["formInfoItemEdit:itemMin"].disabled=false;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
        }else if(opt(1).selected){  //С��
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            //form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=false;
            form["formInfoItemEdit:itemMax"].disabled=false;
            form["formInfoItemEdit:itemMin"].disabled=false;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=false;
        } else if(opt(3).selected || opt(4).selected){  // ����
            form["formInfoItemEdit:itemIsSelect"].disabled=true;
            form["formInfoItemEdit:itemCodeSet"].disabled=true;
            form["formInfoItemEdit:itemDataLength"].disabled=true;
            form["formInfoItemEdit:itemMax"].disabled=true;
            form["formInfoItemEdit:itemMin"].disabled=true;
            form["formInfoItemEdit:itemDefaultValue"].disabled=false;
            form["formInfoItemEdit:itemPrecision"].disabled=true;
        }
        showTitle();
    }

    function   forCodeSelect(){
        var form = document.forms(0);
        var opt=form["formInfoItemEdit:itemCodeSet"].options;
        len = opt.length;
        for(i=0;i<len;i++){
           if(opt(i).selected){
              form["formInfoItemEdit:itemDefaultValue"].dict_num=opt(i).value;
              break;
           }
        }
    }

    function forPopupDlg(objName){
     var form = document.forms(0);
     var obj = form[objName];
     var dict_num = obj.dict_num;
     if(dict_num == "" || dict_num==null) {
         obj.dict_num=document.all('formInfoItemEdit:itemCodeSet').value;
         dict_num = obj.dict_num;
         if(dict_num == "" || dict_num==null) return;
     }
     if(dict_num=="OU"){
         PopUpOrgDlg(objName,"1");
     }else if(dict_num=="PE"){
         fPopUpPerDlg(objName);
     }else if(dict_num=="PO"){
        fPopUpPostDlg(objName);
     }else if(dict_num=="PA"){
        fPopUpPartyDlg(objName,"1");
     }else if(dict_num=="WA"){
        fPopUpWageUnitDlg(objName,true);
     }else{
         PopUpCodeDlgOneControl(objName);
     }
    }
    function showTitle(){
         if (document.all('formInfoItemEdit:itemDataType').value=='14'){
             document.all('max').innerText="<%=LanguageSupport.getResource("XTGL-1400","��")%>";
             document.all('min').innerText="<%=LanguageSupport.getResource("XTGL-1401","��")%>";
         }
         else{
             document.all('max').innerText="<%=LanguageSupport.getResource("XTGL-1195","���ֵ")%>";
             document.all('min').innerText="<%=LanguageSupport.getResource("XTGL-1194","��Сֵ")%>";
         }
    }
</script>
<x:saveState value="#{sys_infoItemEditBB}"></x:saveState>
<h:form id="formInfoItemEdit">
<h:inputHidden id="pageInit" value="#{sys_infoItemEditBB.pageInit}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.setId}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.itemId}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.itemSelf}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.editStatus}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.set_sType}"></h:inputHidden>
<h:inputHidden value="#{sys_infoItemEditBB.itemMust}"></h:inputHidden>
<h:inputHidden id="showcode" />
<h:inputHidden id="showvalue" />

<h:panelGrid columns="1" width="740" cellpadding="0" align="left"     cellspacing="0" border="0" >
    <h:outputText escape="false" value="<font color='blue'><strong>���������</strong></font>"></h:outputText>
    <h:panelGrid  columns="4"
                width="97%"
                cellpadding="0" border="1" align="left"
                styleClass="table03"
                columnClasses="td_form01,td_form02,td_form01,td_form02">
     <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1136","ָ�꼯����")%>
    </f:verbatim>
    <h:inputText value="#{sys_infoItemEditBB.setName}" alt="ָ�꼯����|1|s|50" styleClass="input"/>
    <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1190","ָ��������")%>
    </f:verbatim>
    <h:inputText value="#{sys_infoItemEditBB.itemName}" alt="ָ��������|0|s|50" styleClass="input"/>

    <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1015","����")%>
    </f:verbatim>
    <h:inputText value="#{sys_infoItemEditBB.itemDesc}" alt="����|1|s|100" styleClass="input"/>
    <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1199","��������")%>
    </f:verbatim>
    <h:selectOneMenu id="itemDataType" value="#{sys_infoItemEditBB.itemDataType}" onchange="forDataType(1)">
        <f:selectItem itemValue="1" itemLabel="����"/>
        <f:selectItem itemValue="2" itemLabel="С��"/>
        <f:selectItem itemValue="3" itemLabel="�ַ�"/>
        <f:selectItem itemValue="5" itemLabel="8λ����"/>
        <f:selectItem itemValue="15" itemLabel="6λ����"/>
        <f:selectItem itemValue="6" itemLabel="����"/>
        <f:selectItem itemValue="7" itemLabel="����"/>
        <f:selectItem itemValue="8" itemLabel="��Ա"/>
        <f:selectItem itemValue="4" itemLabel="��ע"/>
        <f:selectItem itemValue="9" itemLabel="����"/>
        <f:selectItem itemValue="11" itemLabel="��λ"/>
        <f:selectItem itemValue="12" itemLabel="����֯"/>
        <f:selectItem itemValue="13" itemLabel="н�ʻ���"/>
        <f:selectItem itemValue="23" itemLabel="н�ʲ���"/>
        <f:selectItem itemValue="14" itemLabel="ͼƬ"/>
    </h:selectOneMenu>

    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1180","���뼯")%>
    </f:verbatim>
    <h:panelGroup>
        <h:selectOneMenu id="itemCodeSet" value="#{sys_infoItemEditBB.itemCodeSet}" onchange="forCodeSelect()">
            <f:selectItems value="#{sys_infoItemEditBB.codeSetList}"/>
        </h:selectOneMenu>
        <h:commandButton value="��ʾ������"  type="button" onclick="PopUpCodeDlgTwoControl(document.all('formInfoItemEdit:showcode'),document.all('formInfoItemEdit:showvalue'),document.all('formInfoItemEdit:itemCodeSet').value)" styleClass="button01" />
    </h:panelGroup>

     <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1197","���ݳ���")%>
    </f:verbatim>
    <h:inputText id="itemDataLength"   alt="���ݳ���|1|i|20"  value="#{sys_infoItemEditBB.itemDataLength}" styleClass="input"/>

   <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1198"," ��������ʾ")%>
    </f:verbatim>
    <h:selectOneMenu id="itemIsSelect" value="#{sys_infoItemEditBB.itemIsSelect}">
        <f:selectItem itemValue="0" itemLabel="��"/>
        <f:selectItem itemValue="1" itemLabel="��"/>
    </h:selectOneMenu>
    
    <f:verbatim>
         <%=LanguageSupport.getResource("XTGL-1196","С��λ��")%>
    </f:verbatim>
    <h:inputText id="itemPrecision" alt="���ݳ���|1|i|10" value="#{sys_infoItemEditBB.itemPrecision}" styleClass="input"/>


     <f:verbatim>
            <span id="max"></span>
    </f:verbatim>
    <h:inputText id="itemMax" alt="���ֵ|1|f|20" value="#{sys_infoItemEditBB.itemMax}" styleClass="input"/>
     <f:verbatim>
            <span id="min"></span>
    </f:verbatim>
    <h:inputText id="itemMin" alt="��Сֵ|1|f|20" value="#{sys_infoItemEditBB.itemMin}" styleClass="input"/>


    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1005","��ʾ˳��")%>
    </f:verbatim>
    <h:inputText  alt="��ʾ˳��|1|i|20" value="#{sys_infoItemEditBB.itemSequence}" styleClass="input"/>
    
    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1200","�Ƿ������")%>
    </f:verbatim>
    <h:selectOneRadio value="#{sys_infoItemEditBB.itemNotNull}">
        <f:selectItem itemValue="0" itemLabel="��"/>
        <f:selectItem itemValue="1" itemLabel="��"/>
    </h:selectOneRadio>

   <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1201","ָ������")%>
    </f:verbatim>
    <h:selectOneMenu value="#{sys_infoItemEditBB.itemProperty}">
        <f:selectItem itemValue="4" itemLabel="�ɱ༭"/>
        <f:selectItem itemValue="2" itemLabel="ֻ��"/>
    </h:selectOneMenu>

    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1193","ȱʡֵ")%>
    </f:verbatim>
    <h:panelGroup>
        <h:inputText   alt="ȱʡֵ|1|s|20" code="" dict="" dict_num=""  id="itemDefaultValue" value="#{sys_infoItemEditBB.itemDefaultValue}" styleClass="input"/>
        <h:commandButton id="helpButton" type="button" styleClass="button_select" onclick="forPopupDlg('formInfoItemEdit:itemDefaultValue')"/>
    </h:panelGroup>

    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1006","����/����")%>
    </f:verbatim>
    <h:selectOneRadio value="#{sys_infoItemEditBB.itemStatus}" disabled="#{sys_infoItemEditBB.itemMust=='1'}">
        <f:selectItem itemValue="1" itemLabel="����"/>
        <f:selectItem itemValue="0" itemLabel="����"/>
    </h:selectOneRadio>


    <h:outputText value="����ֻ���"></h:outputText>
    <h:selectOneRadio value="#{sys_infoItemEditBB.codeByOrg}">
        <c:selectItem itemValue="1" itemLabel="��"></c:selectItem>
        <c:selectItem itemValue="0" itemLabel="��"></c:selectItem>
    </h:selectOneRadio>

     <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1192","����ҽ�������")%>
    </f:verbatim>
    <h:selectOneRadio id="canInWage" value="#{sys_infoItemEditBB.modiInWage}">
        <f:selectItem itemValue="0" itemLabel="������"/>
        <f:selectItem itemValue="1" itemLabel="����"/>
    </h:selectOneRadio>

    <f:verbatim>
            <%=LanguageSupport.getResource("XTGL-1138","�Ƿ�������")%>
    </f:verbatim>
    <h:selectOneRadio id="canImport" value="#{sys_infoItemEditBB.canInport}">
        <f:selectItem itemValue="0" itemLabel="������"/>
        <f:selectItem itemValue="1" itemLabel="����"/>
    </h:selectOneRadio>
</h:panelGrid>
    <h:panelGrid columns="2"
                 width="97%"
                 cellpadding="0" border="1" align="left"
                 styleClass="table03"
              columnClasses="td_form01,td_form02">
        <f:verbatim>
                <%=LanguageSupport.getResource("XTGL-1191","��Ŀ��;")%>
        </f:verbatim>
        <h:inputTextarea id="itemIssue" value="#{sys_infoItemEditBB.itemIssue}" styleClass="input" cols="85" rows="3"/>
    </h:panelGrid>

    <h:outputText escape="false" value="<br><font color='blue'><strong>��ӦJY/T 1006��2012��׼�����</strong></font>"></h:outputText>
    <h:panelGrid  columns="4"
                width="97%"
                cellpadding="0" border="1" align="left"
                styleClass="table03"
                columnClasses="td_form01,td_form02,td_form01,td_form02">
                       <%=LanguageSupport.getResource("XTGL-1136","ָ�꼯����")%>
        <h:outputText value="���"></h:outputText>
        <h:inputText value="#{sys_infoItemEditBB.jy1006bh}" alt="���|1|s|50" styleClass="input"/>

        <h:outputText value="��������"></h:outputText>
        <h:inputText value="#{sys_infoItemEditBB.jy1006name}" alt="��������|1|s|50" styleClass="input"/>
    </h:panelGrid>

    <h:outputText escape="false" value="<br><font color='blue'><strong>��ӦGB/T14946-2009��׼�����</strong></font>"></h:outputText>
    <h:panelGrid  columns="2"
                width="97%"
                cellpadding="0" border="1" align="left"
                styleClass="table03"
                columnClasses="td_form01,td_form02,td_form01,td_form02">
                       <%=LanguageSupport.getResource("XTGL-1136","ָ�꼯����")%>
        <h:outputText value="���"></h:outputText>
        <h:inputText value="#{sys_infoItemEditBB.gb14946}" alt="���|1|s|50" styleClass="input"/>

    </h:panelGrid>

<f:verbatim>
    <br>
</f:verbatim>

<h:panelGrid columns="2" width="20%" cellpadding="0"
                align="right" border="0">
    <h:commandButton value="�� ��" onclick="return forsubmit(document.forms(0))"
                     action="#{sys_infoItemEditBB.saveInfoItem}" styleClass="button01">
        <x:updateActionListener property="#{sys_infoItemListBB.setId}" value="#{sys_infoItemEditBB.setId}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.set_sType}" value="#{sys_infoItemEditBB.set_sType}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.setName}" value="#{sys_infoItemEditBB.setName}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.showOnlyOpen}" value="#{sys_infoItemEditBB.showOnlyOpen}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.showOnlyUser}" value="#{sys_infoItemEditBB.showOnlyUser}"/>
    </h:commandButton>
    <h:commandButton value="�� ��" action="itemlist" styleClass="button01">
        <x:updateActionListener property="#{sys_infoItemListBB.setId}" value="#{sys_infoItemEditBB.setId}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.set_sType}" value="#{sys_infoItemEditBB.set_sType}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.setName}" value="#{sys_infoItemEditBB.setName}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.showOnlyOpen}" value="#{sys_infoItemEditBB.showOnlyOpen}"/>
        <x:updateActionListener property="#{sys_infoItemListBB.showOnlyUser}" value="#{sys_infoItemEditBB.showOnlyUser}"/>
    </h:commandButton>
</h:panelGrid>
</h:panelGrid>
<script type="text/javascript">
	forDataType(2);
	interpret(document.forms(0));
</script>
</h:form>
