<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script>
   function showResult(personId,staus,itemId){
	   window.showModalDialog("/recruit/resumeDetail.jsf?itemId="+itemId+"&personId="+personId+"&status="+staus, "", "dialogWidth:"+screen.width*0.7+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:yes");
       return true;
   }
   function showdetail(detailId){
  	 window.showModalDialog('/pages/recruit/personResume.jsp?recuMailId='+detailId, "", "dialogHeight="+screen.height*0.7+"px; dialogWidth="+screen.width*0.7+"px; top=90;left=180; toolbar=no; menubar=no; scrollbars=yes; resizable=yes;location=no; status=no");
  	 return true;
   }
   function showTable(personId){
		url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID="+personId+"&ORGUID=&Parameter=&Title=";
		window.open(url);
	}
	function changePost(detailId,postMode){
		 window.showModalDialog("/recruit/changePost.jsf?detailId="+detailId+"&postMode="+postMode, "", "dialogWidth:"+screen.width*0.4+"px; dialogHeight:"+screen.height*0.3+"px; status:0;resizable:yes");
	     return true;
	}

	function doOK(){
	    var str="";
	    chk=document.forms(0).selectItem;
	    if (checkMutilSelect(chk)){
	        var size = chk.length;
	        if (size == null) {
	            if (chk.checked) {
	                str+=chk.value;
	            }
	        } else {
	            for (var i = 0; i < size; i++) {
	                if (chk[i].checked) {
	                    if (i==0){
	                        str+=chk[i].value;
	                    }
	                    else{
	                        str+=","+chk[i].value;
	                    }
	                }
	            }
	        }
	        window.showModalDialog("/recruit/recuResumeInfoSend.jsf?detailIds="+str, "", 'height=500px, width=600px, top=100,left=200, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	       	return true;
	    }else{
	        alert("��ѡ��Ҫ�������Ա!");
	        return false;
	    }
	}
</script>
<c:verbatim><link href="/css/style.css" rel="stylesheet" type="text/css"/></c:verbatim>  
<x:saveState value="#{recu_resumeInfoBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{recu_resumeInfoBB.initPost}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{recu_resumeInfoBB.superId}"></h:inputHidden>
    <c:verbatim>
    	<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"><img src="/images/tips.gif">�ⲿ��Ƹ->�������
        </td>
        <td class="td_title" align="center">
        	</c:verbatim>
        		<h:selectOneRadio value="#{recu_resumeInfoBB.ivStatus}" onclick="submit();" valueChangeListener="#{recu_resumeInfoBB.changeStatus}" >
        			<c:selectItem itemLabel="ӦƸ" itemValue="0"/>
        			<c:selectItem itemLabel="�ⶨ����" itemValue="1"/>
        			<c:selectItem itemLabel="��׼����" itemValue="2"/>
        			<c:selectItem itemLabel="֪ͨ����" itemValue="F"/>
        		</h:selectOneRadio>
        	<c:verbatim>
        </td>
    </tr>
</table>
       <table height="98%" width="98%" align="center">
       <tr><td height="8" colspan="2"> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
    	  <h:panelGrid columns="2" align="center">
    	  	<h:outputText value="���"/>
    	  	<h:selectOneMenu id="ReportID" style="width:190px">
               		<c:selectItems value="#{recu_resumeInfoBB.regTableList}"/>
           	    </h:selectOneMenu>
    	  </h:panelGrid>
          <h:panelGrid align="center" columns="2">
          <h:panelGroup>
          		<h:outputText value="������"></h:outputText>
          		<h:inputText value="#{recu_resumeInfoBB.queryValue}"></h:inputText>
          		<h:commandButton action="#{recu_resumeInfoBB.queryPersonList}" styleClass="button01" value="��ѯ"></h:commandButton>
          </h:panelGroup>
          <h:panelGroup>
             <h:outputText value="  "></h:outputText>
          	 <h:commandButton styleClass="button01" value="֪ͨ����" onclick="return doOK();" rendered="#{recu_resumeInfoBB.ivStatus=='2'}"/>
			<h:outputText value="��λ��" rendered="#{recu_resumeInfoBB.postMode=='0'}"/>
			<h:outputText value="��λ���ͣ�" rendered="#{recu_resumeInfoBB.postMode=='1'}"/>
            <h:selectOneMenu id="tem" style="width:200px"  onchange="submit();"  valueChangeListener="#{recu_resumeInfoBB.getInitResumePerson}">
					<c:selectItems value="#{recu_resumeInfoBB.recuOutterList}" />
			</h:selectOneMenu>
			
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td colspan="2">
	  <div style='width:100%;height:95%;overflow:auto' id=datatable>	
    </c:verbatim>
    
    <x:dataTable value="#{recu_resumeInfoBB.outterResumePersonList}" var="list" align="center" id="dateList1"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="90%" rowIndexVar="index" rendered="#{recu_resumeInfoBB.outterResumePersonList!=null}">
     	<h:column>
						<f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox"  name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.detailId}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
		</h:column>      
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{index+1}"/>
        </h:column>
        
        <h:column>
            <c:facet name="header"><h:outputText value="�����б�"/></c:facet>
            <h:graphicImage alt="û���Ķ�" value="/images/common/new.gif" rendered="#{list.browflag=='0'}"/>
            <h:outputText value="#{list.personName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��λ����רҵ��"/></c:facet>
            <h:outputText value="#{list.postName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        
        <h:column>
			<c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="������Ϣ"  styleClass="button01" onclick="return showResult('#{list.personId}','#{list.status}','#{list.itemId}');"/>
            <h:commandButton value="������λ"  styleClass="button01" onclick="changePost('#{list.detailId}','#{recu_resumeInfoBB.postMode}')" rendered="#{list.status=='0'&&recu_resumeInfoBB.postMode=='0'&&list.firstAuditStatus!='2'}"/>
            <h:commandButton value="ɾ��"  styleClass="button01" onclick="return confirm('ȷʵɾ����ӦƸ��Ϣ');" action="#{recu_resumeInfoBB.deleteDetail}" rendered="#{list.status=='0'&&list.firstAuditStatus!='2'&&list.firstAuditStatus!='1'}">
           		<x:updateActionListener value="#{list.detailId}" property="#{recu_resumeInfoBB.detailId}"></x:updateActionListener>
            </h:commandButton>
            <h:commandButton value="������λ����"  styleClass="button01" onclick="changePost('#{list.detailId}','#{recu_resumeInfoBB.postMode}')" rendered="#{list.status=='0'&&recu_resumeInfoBB.postMode=='1'&&list.firstAuditStatus!='2'}"/>
            <h:commandButton value="�鿴����ԭ��"  styleClass="button01" onclick="showdetail('#{list.recuMailId}')" rendered="#{list.recuMailId!=null && list.recuMailId!=''}"/>   
            <h:commandButton value="��ʾ���" styleClass="button01" onclick="return showTable('#{list.personId}');"/>                       
        </h:column>
       
    </x:dataTable>
	<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- ��νű��Ĺ�����ʵ����꾭��ʱ������ʾ -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
