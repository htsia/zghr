<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<script type="text/javascript">
function SetProbation() {
    window.showModalDialog("/employee/DChange/orgDChangeEdit.jsf", null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selPerson(){
	window.showModalDialog("/employee/DChange/selDChangePerson.jsf", null, "dialogWidth:600px; dialogHeight:250px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function modifyDate(itemId) {
    window.showModalDialog("/employee/DChange/DChangePlanPassDateEdit.jsf?itemId="+itemId, null, "dialogWidth:350px; dialogHeight:200px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selectPerson(){
	  var str=" |";
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
       if(str != null && str!=""){
      	 var vars=str.split("|");
      	 document.all("form1:personStr").value = vars[1];
      }
    }
}
function selectPerson4(){
	if(confirm("ȷ��Ҫ��Ч��")){
		  var str=" |";
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
	     if(str != null && str!=""){
	    	 var vars=str.split("|");
	    	 document.all("form1:personStr").value = vars[1];
	    }
	  }
	}else{
		return false;
	}
}
function selectPerson2(id){
    window.showModalDialog("/employee/DChange/DChangeWageEdit.jsf?itemId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}
function selectPerson3(id){
    window.showModalDialog("/employee/DChange/DChangeWageEdit2.jsf?itemId="+id, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:no;status:no;scroll:yes;");
    return true;
}

</script>

<x:saveState value="#{empDchangeMgrBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{empDchangeMgrBB.pageInit}"/>
    <h:inputHidden id="personStr" value=""/>
    <f:verbatim>
    <table height=96% width=100%>
     <tr><td height=8>
        <table align="center" border="0" cellpadding="0" cellspacing="0" width=100% bgcolor="#FFFFFF">
            <tr>
                <td class=td_title >
     </f:verbatim>
                    <h:graphicImage value="/images/tips.gif" />
                    <f:verbatim>
                            <%=LanguageSupport.getResource("RYGL-2123", "��Ա���� ")%>->
                            <%=LanguageSupport.getResource("RYGL-2223", "D��Ա��ת��ʽ���� ")%>
                    </f:verbatim>
      				<f:verbatim>
               </td>
               <td align="right" class=td_title >
               	 </f:verbatim>
                      	 <f:verbatim>
                            <%=LanguageSupport.getResource("RYGL-2132", "���� ")%>
                       </f:verbatim>
                        <h:selectBooleanCheckbox value="#{empDchangeMgrBB.probation}" onclick="submit();" valueChangeListener="#{empDchangeMgrBB.queryApply}"/>
                        <h:outputText value=" " rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
                        <h:outputText value="ת������" rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
                        <h:selectBooleanCheckbox value="#{empDchangeMgrBB.appring}" onclick="submit();" valueChangeListener="#{empDchangeMgrBB.queryApprving}" rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
                        <h:outputText value=" " rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
                        <h:outputText value="ת��" rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
                        <h:selectBooleanCheckbox value="#{empDchangeMgrBB.approved}" onclick="submit();" valueChangeListener="#{empDchangeMgrBB.queryApprived}" rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
                        <h:outputText value=" "/>
                        <f:verbatim>
                            <%=LanguageSupport.getResource("RYGL-2035", "������Ϣ��Ч ")%>
                       </f:verbatim>
                        <h:selectBooleanCheckbox value="#{empDchangeMgrBB.humanEfient}" onclick="submit();" valueChangeListener="#{empDchangeMgrBB.queryEfficent}" />
                        <h:outputText value=" "/>
                          <f:verbatim>
                            <%=LanguageSupport.getResource("RYGL-2036", "���ʵ��� ")%>
                       </f:verbatim>
                        <h:selectBooleanCheckbox value="#{empDchangeMgrBB.wageChange}" onclick="submit();" valueChangeListener="#{empDchangeMgrBB.queryWageChange}"/>
                        <h:outputText value=" " rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
                        <h:outputText value="�˻�" rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
                        <h:selectBooleanCheckbox value="#{empDchangeMgrBB.refuse}" onclick="submit();" valueChangeListener="#{empDchangeMgrBB.queryRsfuse}" rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
      			<f:verbatim>
               </td>
            </tr>
        </table>
      </td></tr>

     <tr><td height=8>
        <table width="95%"  >
            <tr><td align="right">
</f:verbatim>
				<h:commandButton value="D��Ա��ת������"  styleClass="button01" onclick="return SetProbation()"/>
                <h:outputText value="  " rendered="#{empDchangeMgrBB.mustApprov=='0'}"></h:outputText>
				<h:commandButton value="����"  styleClass="button01" onclick="selectPerson();" action="#{empDchangeMgrBB.approvid}" rendered="#{empDchangeMgrBB.mustApprov=='0'}"/>
                <h:outputText value="  "></h:outputText>
                <h:commandButton value="������Ϣ��Ч"  styleClass="button01" onclick="return selectPerson4();" action="#{empDchangeMgrBB.shengxiao}"/>
<f:verbatim>
            </td>
            <td align="right">
</f:verbatim>
				<h:panelGroup>
				
				<f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1043", "��¼��")%>��
			    </f:verbatim>
                <h:outputText value="#{empDchangeMgrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1044", "ҳ��")%>��
			    </f:verbatim>
	            <h:outputText value="#{empDchangeMgrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1045", "ÿҳ��")%>
			    </f:verbatim>
	            <h:outputText value="#{empDchangeMgrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1046", "��ǰΪ��")%>
								</f:verbatim>
	            <h:outputText value="#{empDchangeMgrBB.mypage.currentPage}"></h:outputText>
	            <f:verbatim>
									<%=LanguageSupport.getResource(
										"COMM-1047", "ҳ")%>
								</f:verbatim>
	            
	            <h:commandButton value="��ҳ" action="#{empDchangeMgrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{empDchangeMgrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{empDchangeMgrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{empDchangeMgrBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="ѡ����Ա"  styleClass="button01" onclick="return selPerson()"/>
            </h:panelGroup>
<f:verbatim>
            </td></tr>
        </table>
      </td></tr>

     <tr><td>
        <div style='width:100%;height:100%;overflow:auto' id=datatable>
</f:verbatim>
        <h:dataTable value="#{empDchangeMgrBB.empPerChangeList}" var="list" align="center"  id="dateList"
                     headerClass="td_top tr_fixrow" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                     styleClass="table03" width="95%" >
            <h:column>
                    <f:facet name="header">
                        <f:verbatim escape="false">
                            <input type="checkbox"  name="all"
                                   onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                        </f:verbatim>
                    </f:facet>
                    <f:verbatim escape="false">
                        <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                    <h:outputText value="#{list.itemId}"/>
                    <f:verbatim escape="false">"/></div></f:verbatim>
            </h:column>
           
            <h:column>
                <c:facet name="header"> <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-1016", "����")%>
			           </f:verbatim></c:facet>
                <h:outputText value="#{list.personId}"/>
            </h:column>
            <h:column>
                <c:facet name="header"> <f:verbatim>
	    	     <%=LanguageSupport.getResource("XTGL-1055", " ��ǰ��Ա���")%>
	    	    </f:verbatim></c:facet>
                <h:outputText value="#{list.curType}"/>
            </h:column>
            <h:column>
                <c:facet name="header">  <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2220", "ת������Ա���")%>
	    	    </f:verbatim></c:facet>
                <h:outputText value="#{list.passType}"/>
            </h:column>
			<h:column>
                <c:facet name="header"> <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2221", "��ǰ��λ")%>
	    	    </f:verbatim></c:facet>
                <h:outputText value="#{list.curPost}"/>
            </h:column>
            <h:column>
                <c:facet name="header"> <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2222", "ת�����λ")%>
	    	    </f:verbatim></c:facet>
                <h:outputText value="#{list.passPost}"/>
            </h:column>
            <h:column>
                <c:facet name="header"> <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2127", "��ǰ��λ����")%>
	    	    </f:verbatim></c:facet>
                <h:outputText value="#{list.curPostType}"/>
            </h:column>
            <h:column>
                <c:facet name="header"> <f:verbatim>
	    	     <%=LanguageSupport.getResource("RYGL-2126", "ת�����λ����")%>
	    	    </f:verbatim></c:facet>
                <h:outputText value="#{list.passPostType}"/>
            </h:column>
            <h:column>
                <c:facet name="header"> <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2129", "Ԥ��ת��ʱ��")%>
			           </f:verbatim></c:facet>
                <h:outputText value="#{list.planPassDate}"/>
            </h:column>
            <h:column>
                <c:facet name="header"> <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2130", "ת������ʱ����")%>
			           </f:verbatim></c:facet>
                <h:outputText value="#{list.haveDays}"/>
            </h:column>
            <h:column rendered="#{empDchangeMgrBB.mustApprov=='0'}">
                <c:facet name="header"> <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2028", "�������")%>
			           </f:verbatim></c:facet>
                <h:outputText value="#{list.auditResultDes}"/>
            </h:column>
            <h:column rendered="#{empDchangeMgrBB.mustApprov=='0'}">
                <c:facet name="header"> <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2029", "�������")%>
			           </f:verbatim></c:facet>
                <h:outputText value="#{list.auditResultDes1}"/>
            </h:column>
            <h:column rendered="#{empDchangeMgrBB.mustApprov=='0'}">
                <c:facet name="header"> <f:verbatim>
				     		<%=LanguageSupport.getResource("RYGL-2030", "�������")%>
			           </f:verbatim></c:facet>
                <h:outputText value="#{list.auditResultDes2}"/>
            </h:column>
			<h:column>
                <c:facet name="header"> <f:verbatim>
				     		<%=LanguageSupport.getResource("XTGL-1051", "״̬")%>
			           </f:verbatim></c:facet>
                <h:outputText value="#{list.statusDes}"/>
            </h:column>
            <h:column>
                <c:facet name="header"> <f:verbatim>
						     		<%=LanguageSupport.getResource("YXGL-1026", "����")%>
					            </f:verbatim></c:facet>
                <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{empDchangeMgrBB.delete}" styleClass="button01" rendered="#{list.status=='0'}">
                	<x:updateActionListener value="#{list.itemId}" property="#{empDchangeMgrBB.itemId}"></x:updateActionListener>
                </h:commandButton>
                <h:commandButton value="����ת��ʱ��" onclick="return modifyDate('#{list.itemId}')" styleClass="button01"></h:commandButton>
                <h:commandButton value="�鿴����" onclick="return showWorkFlowLogByLinkID('#{list.itemId}')" styleClass="button01" rendered="#{empDchangeMgrBB.mustApprov=='0'}"></h:commandButton>
                <h:commandButton value="�ⶨн��" styleClass="button01" onclick="return selectPerson2('#{list.itemId}');" rendered="#{list.status=='0'}"/>
                <h:commandButton value="�鿴н��" styleClass="button01" onclick="return selectPerson3('#{list.itemId}');" rendered="#{list.status!='0'}"/>
            </h:column>
        </h:dataTable>
<f:verbatim>
        </div>
    </td></tr>
    </table>
</f:verbatim>
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>