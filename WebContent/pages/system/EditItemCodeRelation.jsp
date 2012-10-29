<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<html>
<head>
    <title></title>
    
    <script language="javascript">
        function forSelDes() {
             PopUpCodeDlgTwoControlSelectAll(document.all('form1:desid'),document.all( 'form1:desdes'), document.all("form1:desField").value,'');
             return false;
        }
        function forSelSource() {
            if (document.all('form1:oper1').value=='1'){
                PopUpMutilCodeDlgNoSubmit('form1:classvalue', 'form1:classvaluedes', document.all("form1:sourceField").value,'');
            }
            else{
                PopUpCodeDlgTwoControlSelectAll(document.all('form1:classvalue'),document.all( 'form1:classvaluedes'), document.all("form1:sourceField").value,'');
            }
            return false;
        }
        
        function chkNull() {
            if (document.getElementById("form1:desid").value == ""
                || document.getElementById("form1:classvalue").value == "") {
                alert("请选择相关项目！")
                return false;
            }
            else {
                return true;
            }
        }
    </script>

</head>

<body>
<x:saveState value="#{sys_codeItemListBB}"/>
<h:form id="form1">
    <table  width=98% align="center" cellpadding=0 cellspacing=0>
         <tr><td height=8 class="td_title" >
             <h:graphicImage value="/images/tips.gif" />
              <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1188","设定对应关系")%> :
            </f:verbatim>
             <h:inputHidden value="#{sys_codeItemListBB.editRelation}"/>
             <h:inputHidden id="desField" value="#{sys_codeItemListBB.codeRel.desField}"/>
             <h:inputHidden id="sourceField" value="#{sys_codeItemListBB.codeRel.sourceField}"/>
         </td>
         <td align="right" class="td_title"> <h:commandButton value="修改" styleClass="button01" onclick="return chkNull();" action="#{sys_codeItemListBB.saveModifSet}"></h:commandButton></td>
         </tr>

        <tr><td height=3 colspan=2>
        </td></tr>

        <tr><td height=8 colspan=2>
                <h:outputText escape="false" value="<strong>当#{sys_codeItemListBB.codeRel.sourceFieldName}</strong>"/>
                <h:selectOneMenu id="oper1" value="#{sys_codeItemListBB.codeRel.oper}">
                     <c:selectItem itemValue="1" itemLabel="等于"></c:selectItem>
                     <c:selectItem itemValue="2" itemLabel="属于"></c:selectItem>
                </h:selectOneMenu>
         </td></tr>

        <tr><td height=8 colspan=2>
            <h:inputText readonly="true"  style="width:300px" id="classvaluedes" value="#{sys_codeItemListBB.codeRel.sourceCodeDes}"/>
            <h:inputHidden id="classvalue" value="#{sys_codeItemListBB.codeRel.sourceCode}"/>
            <h:commandButton id="source" type="button" styleClass="button01" value="选择"  onclick="forSelSource()"/>
         </td></tr>

        <tr><td height=8 colspan=2>
                <h:outputText escape="false" value="<strong>#{sys_codeItemListBB.codeRel.desFieldName}
                </strong>"/>
           <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1188","等于")%> :
            </f:verbatim>
                <h:inputText readonly="true"  style="width:200px" id="desdes" value="#{sys_codeItemListBB.codeRel.desCodeDes}"/>
                <h:inputHidden id="desid" value="#{sys_codeItemListBB.codeRel.desCode}"/>
                <h:commandButton id="select" type="button" styleClass="button01" value="选择"  onclick="forSelDes()"/>
        </td></tr>

    </table>
</h:form>
<script type="text/javascript" language="javascript">
    interpret(document.forms(0));
</script>
</body>
</html>