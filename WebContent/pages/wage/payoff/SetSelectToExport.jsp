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
    
    String setId=request.getParameter("setId");
%>
    
    <script language="javascript">
       function DoSelectAll(isSelect){
            var size = document.getElementsByName('inputField').length;
            for (var i = 0; i < size; i++) {
                document.getElementsByName('inputField')[i].checked=isSelect;
            }
        }
       function DoPartSelectAll(varlist,select){
            var size = document.getElementsByName('inputField').length;
            for (var i = 0; i < size; i++) {
                if (varlist.indexOf(document.getElementsByName('inputField')[i].value)>=0){
                    document.getElementsByName('inputField')[i].checked=document.all(select).checked;
                }
            }
        }

        function doCheck(){
            if (!checkMutilSelect(form1.all('inputField'))){
                alert('请选择输入项');
                return false;}
            else{
                var str="";
                var size = document.getElementsByName('inputField').length;
                for (var i = 0; i < size; i++) {
                    if (document.getElementsByName('inputField')[i].checked){
                        if (str==""){
                            str=document.getElementsByName('inputField')[i].value;
                        }
                        else{
                            str+=","+document.getElementsByName('inputField')[i].value;
                        }
                    }
                }
                window.open('/pages/wage/payoff/exportWage.jsp?setId=<%=setId%>&exportField='+str,'','toolbar=0,scrollbars=1,height=800,width=1400,top=40,left='+(screen.width-500)/2);
                return false;
            }
        }
    </script>

<x:saveState value="#{wage_computeBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_computeBB.exportFieldList}"></h:inputHidden>
    <c:verbatim>
    <table width=98% align="center">
        <tr>
            <td colspan=3 align="right">
</c:verbatim>
                <h:commandButton  styleClass="button01" type="button" value="全部选择" onclick="DoSelectAll(true);" />
                <h:commandButton  styleClass="button01" type="button" value="全部取消" onclick="DoSelectAll(false);" />
                <h:commandButton styleClass="button01" value="确认" onclick="return doCheck();"/>
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
            	if ("System".equals(typearray[k])) {
                    continue;
                }
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
                
                out.print("<input type=checkbox checked name='"+typearray[k]+"' onclick=\"DoPartSelectAll('"+varlist+"','"+typearray[k]+"');\">");
                out.print(CodeUtil.interpertCode("0280", typearray[k]));
                out.println("<font></td><tr>");
                for (int j = 0; j < cells.size(); j++) {
                    out.print("<tr><td>");
                    out.print("<input type=checkbox checked name=inputField value='" + ((CellVO) (cells.get(j))).getItemId() + "'>");
                    out.print(((CellVO) (cells.get(j))).getItemName());
                    out.print("</td>");

                    if (j<cells.size()-1){
                        j++;
                        out.print("<td>");
                        out.print("<input type=checkbox checked name=inputField value='" + ((CellVO) (cells.get(j))).getItemId() + "'>");
                        out.print(((CellVO) (cells.get(j))).getItemName());
                        out.print("</td>");
                    }

                    if (j<cells.size()-1){
                        j++;
                        out.print("<td>");
                        out.print("<input type=checkbox checked name=inputField value='" + ((CellVO) (cells.get(j))).getItemId() + "'>");
                        out.print(((CellVO) (cells.get(j))).getItemName());
                        out.print("</td>");
                    }
                    
                    out.println("</tr>");
                }
            }
        %>
    </table>
</c:verbatim>
</h:form>
