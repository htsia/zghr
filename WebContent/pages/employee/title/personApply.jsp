<%@ page contentType="text/html;charset=GBK" language="java"%>
<%@ include file="../../include/taglib.jsp"%>
<%
	response.setHeader("progma", "no-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<script type="text/javascript">
        
         function apply(applyId){
        	 window.showModalDialog("/employee/title/personApplyEdit.jsf?applyId="+applyId, "", "dialogWidth:"+screen.width*0.5+"px; dialogHeight:300px; status:0;resizable:yes");
             return true;  
         }
         function showApply(applyId){
        	 window.showModalDialog("/employee/title/personApplyEdit.jsf?applyId="+applyId, "", "dialogWidth:"+screen.width*0.5+"px; dialogHeight:300px; status:0;resizable:yes");
             return true;  
         }
         function apply2(applyId){
        	 window.showModalDialog("/employee/title/pesonExcEidt.jsf?edit=false&applyId="+applyId, "", "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px; status:0;resizable:no");
             return true;  
         }
         function refuse(id){
        	  window.showModalDialog("/employee/title/pesonRefuseEidt.jsf?edit=false&applyId="+id, "", "dialogWidth:"+screen.width*0.5+"px; dialogHeight:"+screen.height*0.5+"px; status:0;resizable:no");
        	  return true; 
          }
         function applyContent(id){
        	 window.showModalDialog("/employee/title/personApplyDirIndex.jsf?showType=edit&applyId="+id, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:no");
             return true;
         }
         function applyContent1(id){
        	 window.showModalDialog("/employee/title/personApplyDirIndex.jsf?showType=show&applyId="+id, "", "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px; status:0;resizable:no");
             return true;
         }
         function scanf(id){
        	 window.open("/pages/employee/title/displayReport.jsp?itemId="+id, null, "height="+screen.height*0.8+", width="+screen.width*0.8+", top=100,left=200, toolbar=yes, menubar=no, location=no, resizable=yes,status=no");
             return true;
         }
         function showOthers(id){
        	 window.open("/employee/title/showTitleApplyItemList.jsf?applayId="+id, "", "height="+screen.height*0.8+", width="+screen.width+", top=50,left=0, toolbar=yes, menubar=no, location=no, resizable=yes,status=no");
             return true;  
         }
    </script>

<x:saveState value="#{persontitleapplyBB}"></x:saveState>
<h:form id="form1">
	<h:inputHidden value="#{persontitleapplyBB.pageInit}"></h:inputHidden>
	<c:verbatim>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif"> ְ������ -> ְ�Ƹ����걨����</td>
        </tr>
    </table>
		<table height=98% width=98% align="center" >
            <tr>
            <td  height="10" align="right" valign="top">
            </td>
            </tr>
			<tr>
				<td>
				<div style='width: 100%; height: 100%; overflow: auto' id=datatable>
				</c:verbatim>
			 <x:dataTable value="#{persontitleapplyBB.titleApplyList}" rowIndexVar="index"
					id="dateList" var="list" align="center" headerClass="td_top"
					columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
					styleClass="table03" width="100%">
					<h:column>
		               <c:facet name="header"><h:outputText value="���"/></c:facet>
		               <h:outputText value="#{index+1}"/>
       				 </h:column>
					 <h:column>
                        <f:facet name="header">
                            <h:outputText value="���"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.year}"/>
                    </h:column>
					<h:column>
                        <f:facet name="header">
                            <h:outputText value="��ʼʱ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.beginDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="����ʱ��"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.endDate}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="״̬"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.statusDes}"/>
                    </h:column>
                    <h:column>
                        <f:facet name="header">
                            <h:outputText value="����״̬"/>
                        </f:facet>
                        <h:outputText escape="false" value="#{list.personStatusDes}"/>
                    </h:column>
                    <h:column>
						<c:facet name="header">
							<h:outputText value="����" />
						</c:facet>
						<h:commandButton value="�걨" styleClass="button01" onclick="apply('#{list.applyId}')" rendered="#{list.personStatus=='N'}">
						</h:commandButton>
						<h:commandButton value="�걨���" styleClass="button01" onclick="apply('#{list.applyId}')" rendered="#{list.personStatus!='N'}"></h:commandButton>
						<h:commandButton value="�걨����" styleClass="button01" onclick="applyContent('#{list.applyId}')" rendered="#{list.personStatus=='0'||list.personStatus=='9'}"></h:commandButton>
						<h:commandButton value="�걨����" styleClass="button01" onclick="applyContent1('#{list.applyId}')" rendered="#{list.personStatus!='0'&&list.personStatus!='9'}"></h:commandButton>
						<h:commandButton value="Ԥ��" styleClass="button01" onclick="scanf('#{list.itemId}')" rendered="#{list.personStatus!='N'}"></h:commandButton>
						<h:commandButton value="�ύ" onclick="return confirm('ȷ��Ҫ�ύ��?');" action="#{persontitleapplyBB.commitItem}" styleClass="button01" rendered="#{list.personStatus=='0'||list.personStatus=='9'}">
                  	        <x:updateActionListener property="#{persontitleapplyBB.applyId}" value="#{list.applyId}"/>
            			</h:commandButton>
            			<h:commandButton value="�����޸�"  action="#{persontitleapplyBB.modifyItem}" styleClass="button01" rendered="#{list.personStatus=='1'||list.personStatus=='2'}">
                  	        <x:updateActionListener property="#{persontitleapplyBB.applyId}" value="#{list.applyId}"/>
            			</h:commandButton>
						<h:commandButton value="�ų�ԭ��" styleClass="button01" onclick="apply2('#{list.applyId}')" rendered="#{list.personStatus=='8'}"></h:commandButton>
						<h:commandButton value="�˻�ԭ��" styleClass="button01" onclick="refuse('#{list.applyId}')" rendered="#{list.personStatus=='9'}"></h:commandButton>
						<h:commandButton value="�걨��Ա�б�" styleClass="button01" onclick="showOthers('#{list.applyId}')"></h:commandButton>
					</h:column>
				</x:dataTable>
				<c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>

<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
