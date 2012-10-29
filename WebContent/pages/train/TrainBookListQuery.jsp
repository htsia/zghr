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
            alert("请选择要加入的教材!");
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
                  <h:outputText value="当前机构:"></h:outputText>
                  <h:outputText value="#{trainClassBookBB.superName}"></h:outputText>
              </h:panelGroup>
          </h:panelGrid>
          <h:panelGrid align="right" columns="2">
             
            <h:panelGroup>
                <h:outputText value="记录数:#{trainClassBookBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="页数:#{trainClassBookBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="每页有#{trainClassBookBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="当前为第#{trainClassBookBB.mypage.currentPage}页"></h:outputText>
            
	            <h:commandButton value="首页" action="#{trainClassBookBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="上页" action="#{trainClassBookBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="下页" action="#{trainClassBookBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="尾页" action="#{trainClassBookBB.last}" styleClass="button01"></h:commandButton>
	            <h:outputText value="  "></h:outputText>
	            <h:commandButton value="确定" onclick="doOK();" styleClass="button01" ></h:commandButton>
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
            <c:facet name="header"><h:outputText value="培训教材名称"/></c:facet>
            <h:outputText value="#{list.bookName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="作者"/></c:facet>
            <h:outputText value="#{list.bookAuthor}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="出版社"/></c:facet>
            <h:outputText value="#{list.bookPublisher}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="价格"/></c:facet>
            <h:outputText value="#{list.bookPrice}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="介绍"/></c:facet>
            <h:outputText value="#{list.bookMemo}"/>
        </h:column>

		<h:column>
            <c:facet name="header"><h:outputText value="应用范围"/></c:facet>
            <h:outputText value="#{list.bookOrg}"/>
        </h:column>
	</h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
</h:form>
<!-- 这段脚本的功能是实现鼠标经过时高亮显示 -->
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>