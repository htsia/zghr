<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    
    <script language="javascript">
       function DoSelectAll(isSelect){
            var size = document.all('inputField').length;
            for (var i = 0; i < size; i++) {
                document.all('inputField')[i].checked=isSelect;
            }
        }
       function DoPartSelectAll(varlist,select){
            var size = document.all('inputField').length;
            for (var i = 0; i < size; i++) {
                if (varlist.indexOf(document.all('inputField')[i].value)>=0){
                    document.all('inputField')[i].checked=document.all(select).checked;
                }
            }
        }

        function doCheck(){
            if (!checkMutilSelect(form1.all('inputField'))){
                alert('请选择输入项');
                return false;}
            else{
                var str="";
                var size = document.all('inputField').length;
                for (var i = 0; i < size; i++) {
                    if (document.all('inputField')[i].checked){
                        if (str==""){
                            str=document.all('inputField')[i].value;
                        }
                        else{
                            str+=","+document.all('inputField')[i].value;
                        }
                    }
                }
                document.all("form1:exportField").value=str;
                return true;
            }
        }
    </script>

<x:saveState value="#{wage_computeBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_computeBB.exportFieldList}"></h:inputHidden>
    <h:inputHidden id="exportField" value="#{wage_computeBB.exportField}"></h:inputHidden>
    <c:verbatim>
    <table width=98% align="center">
        <tr>
            <td colspan=3 align="right">
</c:verbatim>
                <h:commandButton  styleClass="button01" type="button" value="全部选择" onclick="DoSelectAll(true);" />
                <h:commandButton  styleClass="button01" type="button" value="全部取消" onclick="DoSelectAll(false);" />
                <h:commandButton styleClass="button01" value="确认" action="#{wage_computeBB.exportToExcel}"
                                 onclick="return doCheck();"/>
                <h:commandButton styleClass="button01" type="button" value="取消" onclick="window.close()"/>
<c:verbatim>
            </td>
        </tr>
        <tr><td colspan=3 height=5></td></tr>
        <%
            Hashtable fieldHash = (Hashtable) request.getAttribute("fieldHash");
            String[] typearray = new String[fieldHash.size()];
            int index = 0;
            typearray[index] = "System";
            Iterator it = fieldHash.keySet().iterator();
            while (it.hasNext()) {
                String setkey = it.next().toString();
                if (!"System".equals(setkey)) {
                    index++;
                    typearray[index] = setkey;
                }
            }
            for (int k = 0; k < typearray.length; k++) {
                ArrayList cells = (ArrayList) fieldHash.get(typearray[k]);
                out.print("<tr><td colspan=3 align='center' bgcolor=\"#2074C5\"><font color='white'>");
                String varlist="";
                for (int j = 0; j < cells.size(); j++) {
                    if ("".equals(varlist)){
                         varlist=((CellVO) (cells.get(j))).getItemId();
                    }
                    else{
                        varlist+=","+((CellVO) (cells.get(j))).getItemId();
                    }
                }
                out.print("<input type=checkbox name='"+typearray[k]+"' onclick=\"DoPartSelectAll('"+varlist+"','"+typearray[k]+"');\">");
                if ("System".equals(typearray[k])) {
                    out.print("基本信息");
                } else {
                    out.print(CodeUtil.interpertCode("0280", typearray[k]));
                }
                out.println("<font></td><tr>");
                for (int j = 0; j < cells.size(); j++) {
                    out.print("<tr><td>");
                    out.print("<input type=checkbox name=inputField value='" + ((CellVO) (cells.get(j))).getItemId() + "'>");
                    out.print(((CellVO) (cells.get(j))).getItemName());
                    out.print("</td>");

                    if (j<cells.size()-1){
                        j++;
                        out.print("<td>");
                        out.print("<input type=checkbox name=inputField value='" + ((CellVO) (cells.get(j))).getItemId() + "'>");
                        out.print(((CellVO) (cells.get(j))).getItemName());
                        out.print("</td>");
                    }

                    if (j<cells.size()-1){
                        j++;
                        out.print("<td>");
                        out.print("<input type=checkbox name=inputField value='" + ((CellVO) (cells.get(j))).getItemId() + "'>");
                        out.print(((CellVO) (cells.get(j))).getItemName());
                        out.print("</td>");
                    }

                    out.println("</tr>");
                    //out.println("<tr><td colspan=3 height=3></td></tr>");
                }
            }
        %>
    </table>
</c:verbatim>
</h:form>
