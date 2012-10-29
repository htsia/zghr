<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
    function doOK() {
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
           	window.returnValue=str;
            window.close();
        }
        else{
            alert("��ѡ��Ҫ����Ľ̲�!");
        }
    }
    </script>

<x:saveState value="#{trainClassBookBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{trainClassBookBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="superId" value="#{trainClassBookBB.superId}"></h:inputHidden>
    <c:verbatim>
       <table height=98% width=98% align="center">
       <tr><td height=8> 
    </c:verbatim>
    <h:panelGrid width="98%" columns="2">
          <h:panelGrid align="left">
              <h:panelGroup>
                  <h:outputText value="��ǰ����:"></h:outputText>
                  <h:outputText value="#{trainClassBookBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             
            <h:panelGroup>
                <h:outputText value="��¼��:#{trainClassBookBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{trainClassBookBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{trainClassBookBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{trainClassBookBB.mypage.currentPage}ҳ"></h:outputText>
            
	            <h:commandButton value="��ҳ" action="#{trainClassBookBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{trainClassBookBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{trainClassBookBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{trainClassBookBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="ȷ��" onclick="doOK();" styleClass="button01" ></h:commandButton>
            </h:panelGroup>
          
          </h:panelGrid>
    </h:panelGrid>
    
    <c:verbatim>
	  </td></tr>
	  
	  <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    
    <h:dataTable value="#{trainClassBookBB.bookList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle,td_middle_center,td_middle,td_middle,td_middle_center"
                 styleClass="table03" width="90%" >
        
        <h:column>
                        <f:facet name="header">
                            <f:verbatim escape="false">
                                <input type="checkbox"  name="all"
                                       onclick="selectAll(document.forms(0).all,document.forms(0).selectItem)"/>
                            </f:verbatim>
                        </f:facet>
                        <f:verbatim escape="false">
                            <div align="center"> <input type="checkbox" name="selectItem" value="</f:verbatim>
                        <h:outputText value="#{list.bookID}"/>
                        <f:verbatim escape="false">"/>
                            </div>
                        </f:verbatim>
                    </h:column>
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