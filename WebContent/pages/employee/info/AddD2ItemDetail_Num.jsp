<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<x:saveState value="#{emp_d2AnaBB}"/>
    <script type="text/javascript">
        function doCheck(){
            if  (document.all("form1:name").value==""){
                alert("请录入名称！");
                return false;
            }

            if  (document.all("form1:lowValue").value==""){
                alert("请录入低限！");
                return false;
            }
            if  (document.all("form1:highValue").value==""){
                alert("请录入高限！");
                return false;
            }

            return true;
        }
        // 选择指标项
        function selectInfoItem() {
            showx = event.screenX - event.offsetX - 150;
            showy = event.screenY - event.offsetY + 18;

            retval = window.showModalDialog("/pages/employee/info/SelectD2InfoItem.jsp", "", "dialogWidth:300px; dialogHeight:400px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
            if (retval != null) {
                rs = retval.split("|");
                document.all("form1:fieldName").value= rs[1];
                vals=rs[0].split(".");
                document.all("form1:andField").value = vals[1];
            }
        }
       </script>
<x:saveState value="#{emp_d2AnaBB}"></x:saveState>
<h:form id="form1">
    <h:panelGrid align="center" width="98%">
        <h:inputHidden value="#{emp_d2AnaBB.editDetail}"></h:inputHidden>
        <h:inputHidden value="#{emp_d2AnaBB.currentID}"></h:inputHidden>
        <h:panelGrid columns="2" align="right" cellspacing="2">
            <h:commandButton styleClass="button01" value="保存" action="#{emp_d2AnaBB.saveDetail}"
                             onclick="return doCheck();"/>
            <h:commandButton styleClass="button01" type="button" value="取消返回" onclick="window.close();"/>
        </h:panelGrid>

        <h:panelGrid columns="2" width="100%" columnClasses="td_form01,td_form02" align="center" styleClass="table03">
              <f:verbatim>
              <%=LanguageSupport.getResource("XTGL-1157","顺序")%>  
            </f:verbatim>
            <h:inputText id="seq" value="#{emp_d2AnaBB.anditembo.seq}" />
           
              <f:verbatim>
              <%=LanguageSupport.getResource("JGGL-1058","名称")%>  
            </f:verbatim>
            <h:inputText id="name" value="#{emp_d2AnaBB.anditembo.itemName}" />

             <f:verbatim>
              <%=LanguageSupport.getResource("JGGL-1058","低限")%>  
            </f:verbatim>
            <h:inputText id="lowValue" value="#{emp_d2AnaBB.anditembo.lowValue}" />

             <f:verbatim>
              <%=LanguageSupport.getResource("RYGL-2254","高限")%>  
            </f:verbatim>
            <h:inputText id="highValue" value="#{emp_d2AnaBB.anditembo.highValue}" />

        </h:panelGrid>
    </h:panelGrid>
</h:form>
