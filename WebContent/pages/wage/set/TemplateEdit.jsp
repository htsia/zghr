<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.faces.model.SelectItem" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script language="javascript" src="<%=request.getContextPath()%>/js/selectItem.js"></script>
    <script type="text/javascript">
    function removeInputItem() {
        var obj = document.all("form1:rsItem");
        var count = obj.options.length;
        for (i = count - 1; i >= 0; i--) {
            if (obj.options[i].selected) {
                    obj.remove(i);
                }
        }
    }
    function forSel() {
        PopUpMutilCodeDlgForSubmit('form1:personType', 'form1:personTypeValue', "0135",'');
        //debugger;
        if (document.all( 'form1:personTypeValue').value!=""){
            document.all('form1:personTypeDes').innerText="当前人员类别:"+document.all( 'form1:personTypeValue').value;
        }
    }
    function checkSave() {
        if (document.all("form1:configname").value==""){
            alert("请录入配置名称！")
            return false;
        }
        var obj = document.all("form1:rsItem");
        if (obj.options.length < 1) {
            alert("请选择输入项！")
            return false;
        } else {
            selectTotal(obj);
            return true;
        }
    }
    </script>

<x:saveState value="#{wage_templateEditBB}"/>
<h:form id="form1">
    <h:inputHidden id="pageInit" value="#{wage_templateEditBB.pageInit}"/>

    <h:panelGrid columns="1" align="center" width="98%">
        <h:panelGrid columns="2">
            <h:panelGroup>
                <h:outputText value="名称"></h:outputText>
                <h:inputText  id="configname" value="#{wage_templateEditBB.bo.tempname}"/>
                <h:outputText escape="false" value="&nbsp;&nbsp;"></h:outputText>
                <h:outputText value="所属帐套"></h:outputText>
                <h:selectOneMenu value="#{wage_templateEditBB.bo.wagesetid}">
                    <c:selectItems value="#{wage_templateEditBB.setList}"></c:selectItems>
                </h:selectOneMenu>
            </h:panelGroup>

            <h:panelGrid columns="3" align="right">
                    <c:verbatim escape="false">
                       <input name="simple1" type="button" id=15 next=20 class="button01" value="适用人员类别"    onclick="forSel()">
                    </c:verbatim>
                    <h:commandButton value="保存" onclick="return checkSave();" styleClass="button01" action="#{wage_templateEditBB.save}"/>
                    <h:commandButton value="返回" styleClass="button01" onclick="window.close();" />
            </h:panelGrid>
        </h:panelGrid>

        <h:panelGroup>
            <h:inputHidden id="personType" value="#{wage_templateEditBB.personType}"/>
            <h:inputHidden id="personTypeValue" value="#{wage_templateEditBB.personTypeValue}"/>
            <h:outputText id="personTypeDes" value="#{wage_templateEditBB.personTypeDesc}"></h:outputText>
        </h:panelGroup>

    </h:panelGrid>



    <h:panelGrid columns="3" align="center" width="95%"
                    styleClass="table03" columnClasses="td_middle,td_middle,td_middle">
        <h:outputText value="备选输入项"/>
        <h:outputText value="操作"/>
        <h:outputText value="已选输入项"/>

        <h:selectManyListbox size="15" style="width:240px;height:300px" id="preTreat">
            <c:selectItems value="#{wage_templateEditBB.inputList}"/>
        </h:selectManyListbox>

        <h:panelGrid align="center" columns="1">
            <c:verbatim escape="false">
                <input name=rightBnt type="button" class="button01"
                       onclick="forAddItem(document.all('form1:rsItem'),document.all('form1:preTreat'))" value="->>">
                <br>
                <INPUT name=leftBnt type=button class="button01" onclick="removeInputItem()" value="<<-">
                <br>
                <INPUT name=leftBnt type=button class="button01" onclick="forUpItem(form1.all('form1:rsItem'))" value="上移">
                <br>
                <INPUT name=leftBnt type=button class="button01" onclick="forDownItem(form1.all('form1:rsItem'))" value="下移">
            </c:verbatim>
        </h:panelGrid>

        <c:verbatim>
          <select size="15" style="width:240px;height:300px" name="form1:rsItem" multiple="true">
              <%
                  List sel = (List) session.getAttribute("selitem");
                  if (sel != null) {
                      for (int i = 0; i < sel.size(); i++) {
                          SelectItem si = (SelectItem)sel.get(i);
                          out.println("<option value=\""+si.getValue()+"\">"+si.getLabel()+"</option>");
                      }
                  }
              %>
          </select>
       </c:verbatim>

    </h:panelGrid>
</h:form>
