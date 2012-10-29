<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
         function addBook(){
             if (document.all("form1:superId").value==null || document.all("form1:superId").value==""){
                 alert("��ѡ�����!");
                 return false;
             }
             window.showModalDialog("/train/TrainBookEdit.jsf?superId="+document.all("form1:superId").value, "", "dialogWidth:400px; dialogHeight:280px; status:0;resizable:yes");
             return true;
         }
        function modify(id){
            window.showModalDialog("/train/TrainBookEdit.jsf?orgID="+id, "", "dialogWidth:400px; dialogHeight:280px; status:0;resizable:yes");
            return true;
        }
    </script>

<x:saveState value="#{train_booklistbb}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{train_booklistbb.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{train_booklistbb.superId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{train_booklistbb.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             
            <h:panelGroup>
                <h:outputText value="��¼��:#{train_booklistbb.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{train_booklistbb.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{train_booklistbb.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{train_booklistbb.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{train_booklistbb.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_booklistbb.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{train_booklistbb.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{train_booklistbb.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="����" onclick="return addBook();" styleClass="button01" ></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <h:dataTable value="#{train_booklistbb.bookList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        <h:column>
            <c:facet name="header"><h:outputText value="��ѵ�̲�����"/></c:facet>
            <h:outputText value="#{list.bookName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.bookAuthor}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="������"/></c:facet>
            <h:outputText value="#{list.bookPublisher}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="�۸�"/></c:facet>
            <h:outputText value="#{list.bookPrice}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:outputText value="#{list.bookMemo}"/>
        </h:column>

		<h:column>
            <c:facet name="header"><h:outputText value="Ӧ�÷�Χ"/></c:facet>
            <h:outputText value="#{list.bookOrg}"/>
        </h:column>
		
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:commandButton value="�༭" onclick="return modify('#{list.bookID}')" styleClass="button01"></h:commandButton>
            <h:commandButton value="ɾ��" onclick="return confirm('ȷ��Ҫɾ����?');" action="#{train_booklistbb.delete}" styleClass="button01">
                  <x:updateActionListener property="#{train_booklistbb.bookID}" value="#{list.bookID}"/>
            </h:commandButton>
        </h:column>
    </h:dataTable>
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