<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>


<c:verbatim>
    <link href="/css/editor.css" rel="stylesheet" type="text/css"/>
    <script language="javascript" src="/js/commonFuns.js"></script>
    <script language="javascript" src="/js/editor.js"></script>
    <script language="javascript" src="/js/editor_toolbar.js"></script>
</c:verbatim>
<c:verbatim><base target="_self"></c:verbatim>
<script type="text/javascript">
    

    function forCheck() {
        
        if (document.all('form1:trainstyle').value==null || document.all('form1:trainstyle').value=="") {
            alert("��ѡ����ѵ��ʽ!");
            return false;
        }
      
        
       
        return true;
    }
    function forSave() {
        PutTextareaValue(document.all('form1:textarea'),fGetContent());
        if (forCheck()) {
            return forsubmit(document.all('form1'));
        }
        return false;
    }
</script>
    <x:saveState value="#{train_selfPersonDemandEditbb}"/>
	<h:form id="form1" enctype="multipart/form-data">
	  <h:inputHidden value="#{train_selfPersonDemandEditbb.initEdit}" />
      <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="1">
           <h:panelGroup>
                <h:graphicImage value="/images/tips.gif" />
                <h:outputText value="��������>>������ѵ����"/>
           </h:panelGroup>
       </h:panelGrid>

        <f:verbatim>
            <br>
        </f:verbatim>
  <c:verbatim>
        <table border="0"  align="center" cellspacing="2"    cellpadding="10"	columnClasses="td_form01,td_form02" styleClass="table03">
		    <tr>
                <td class="td_form01">��ѵ����</td>
                <td class="td_form02">
</c:verbatim>
                  <h:inputText id="text1" readonly="true" styleClass="input" value="��������" size="80" maxlength="50" />
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">���������Ա</td>
                <td class="td_form02">
</c:verbatim>
                  <h:inputHidden id="personId" value="#{train_selfPersonDemandEditbb.bo.personID}"></h:inputHidden>
                  <h:inputText readonly="true" id="personName" styleClass="input" value="#{train_selfPersonDemandEditbb.bo.personName}" size="65" maxlength="50"/>
             
<c:verbatim>
                </td>
            </tr>
      		<tr>
                <td class="td_form01">��������</td>
                <td class="td_form02">
</c:verbatim>
                 <h:selectOneMenu value="#{train_selfPersonDemandEditbb.bo.bullId}">
				<c:selectItems value="#{train_selfPersonDemandEditbb.bullList}"/>
			</h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">��ѵ��ʽ</td>
                <td class="td_form02">
</c:verbatim>
                 <h:selectOneMenu id="trainstyle" value="#{train_selfPersonDemandEditbb.bo.demandStyle}" style="width:30%">
                   <c:selectItem itemLabel="------��ѡ��------" itemValue=""/>
                   <c:selectItem itemLabel="���ý���" itemValue="0"/>
                   <c:selectItem itemLabel="��ѧУ����" itemValue="1"/>
                   <c:selectItem itemLabel="��¼����Ӱ" itemValue="2"/>
                   <c:selectItem itemLabel="�ֳ�����" itemValue="3"/>
                   <c:selectItem itemLabel="��������" itemValue="4"/>
                   <c:selectItem itemLabel="����" itemValue="5"/>
                 </h:selectOneMenu>
<c:verbatim>
                </td>
            </tr>
            <tr>
                <td class="td_form01">��ѵʱ��</td>
                <td class="td_form02">
</c:verbatim>
                 <h:selectOneRadio  value="#{train_selfPersonDemandEditbb.bo.demandTime}">
                        <f:selectItem itemValue="0" itemLabel="����ʱ������" />
                        <f:selectItem itemValue="1" value="true" itemLabel="����ʱ������" />
                        <f:selectItem itemValue="2" value="true" itemLabel="����ʱ������" />
                        <f:selectItem itemValue="3" value="true" itemLabel="��ĩ" />
                    </h:selectOneRadio>
<c:verbatim>
                </td>
            </tr>
            <tr>
            <td class="td_form01">���ʱ��</td>
			<td class="td_form02">
</c:verbatim>
				<h:inputText id="text5" styleClass="input" value="#{train_selfPersonDemandEditbb.bo.createDate}" size="19" readonly="true">
				</h:inputText>
			
<c:verbatim>
			</td>
            </tr>
            

           <tr >
               <td class="td_form01">˵��</td>
               <td class="td_form02">
 </c:verbatim>
                    <h:inputTextarea id="textarea" rows="15" cols="80" style="display:none;"  value="#{train_selfPersonDemandEditbb.bo.memo}" />
<c:verbatim>
                    <script language="javascript">
                        gFrame = 1;//1-�ڿ����ʹ�ñ༭��
                        gContentId = "form1:textarea";//Ҫ�������ݵ�content ID
                        OutputEditorLoading();
                    </script>
                    <iframe id="HtmlEditor" class="editor_frame" frameborder="0" marginheight="0" marginwidth="0" style="width:100%;height:300px;overflow:visible;" ></iframe>
               </td>
            </tr>

           
</c:verbatim>
				
                
<c:verbatim>
               
        </table>
			<br>
</c:verbatim>

        <h:panelGrid border="0" columns="2" cellpadding="8" align="center">
			<h:commandButton value="����" onclick="return forSave();" action="#{train_selfPersonDemandEditbb.save}" styleClass="button01" />
			<h:commandButton value="����" onclick="window.close()" styleClass="button01" />
		</h:panelGrid>
	</h:form>


