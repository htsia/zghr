<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <script type="text/javascript">
        function check(){
            if (document.all('form1:year').value==""){
                alert("请选择年份！")
                return false;
            }
            return true;
        }
    </script>

<x:saveState value="#{wage_sheetBB}"/>
<h:form id="form1">
    <c:verbatim>
    <table width=300 height=98% align="center">
      <tr><td width=150 height=8 align="left">
    </c:verbatim>
         <h:selectManyCheckbox layout="pageDirection" value="#{wage_sheetBB.inputField}">
             <c:selectItems value="#{wage_sheetBB.fieldList}"></c:selectItems>
         </h:selectManyCheckbox>
    <c:verbatim>
    </td>

      <td align="left" valign="top">
           <strong>请选择台帐字段</strong><br>
           <strong>请选择年份</strong><br>
           <strong>然后点设置按钮</strong><br>
    </c:verbatim>       
           <h:selectOneMenu id='year' value="#{wage_sheetBB.year}">
               <c:selectItem itemValue="2005" itemLabel="2005"></c:selectItem>
               <c:selectItem itemValue="2006" itemLabel="2006"></c:selectItem>
               <c:selectItem itemValue="2007" itemLabel="2007"></c:selectItem>
               <c:selectItem itemValue="2008" itemLabel="2008"></c:selectItem>
               <c:selectItem itemValue="2009" itemLabel="2009"></c:selectItem>
               <c:selectItem itemValue="2010" itemLabel="2010"></c:selectItem>
               <c:selectItem itemValue="2011" itemLabel="2011"></c:selectItem>
               <c:selectItem itemValue="2012" itemLabel="2012"></c:selectItem>
               <c:selectItem itemValue="2013" itemLabel="2013"></c:selectItem>
               <c:selectItem itemValue="2014" itemLabel="2014"></c:selectItem>
               <c:selectItem itemValue="2015" itemLabel="2015"></c:selectItem>
           </h:selectOneMenu>

           <h:commandButton value="设置" styleClass="button01" onclick="return check();" action="#{wage_sheetBB.save}"></h:commandButton>
    <c:verbatim>
      </td>
      </tr>
    </table>
    </c:verbatim>
</h:form>
