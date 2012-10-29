<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.wage.ucc.impl.WageSetPersonUCC"%>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

<x:saveState value="#{wage_OrderInputBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{wage_OrderInputBB.pageInit}"></h:inputHidden>
    <h:inputHidden id="setId" value="#{wage_OrderInputBB.setId}"></h:inputHidden>
     <%
         String perstr=request.getParameter("PerStr");
         String[] persId=null;
         if (perstr==null){  //�㰴��������Ļط�
             persId=(String[])session.getAttribute("persId");
         }
         else{
             persId =  perstr.replaceAll("~","#").split(",");
             session.setAttribute("persId",persId); // ѡ�����Ա
         }
         String setID=request.getParameter("setId");
         if (setID==null){
             setID=(String)request.getParameter("form1:setId");
         }
         if (setID==null){
             setID=(String)request.getAttribute("SETID");
         }
         String[]  field=new String[2];
         field[0]="A001743";        // н�ʲ���
         field[1]="A001745";        // ��Ա�����
         session.setAttribute("field",field);
         HashMap rs=null;
         try{
             WageSetPersonUCC wagesetpersonucc=(WageSetPersonUCC)SysContext.getBean("wage_SetPersonUccImpl");
             rs = wagesetpersonucc.queryPersonOrder(persId, field);
         }
         catch(Exception e){
         }
     %>
    <c:verbatim>
    <script type="text/javascript">
        function batchUpdate(field){
        <%
               for(int i=0;i<persId.length;i++){
                   String fldname = persId[i] + "|" + field;
                   out.println("        document.all('"+persId[i] + "'+'|'+field).value=document.all('ALL'+field).value;");
               }
           %>
        }
    </script>
    </c:verbatim>
    <h:panelGrid align="center" columns="3" width="95%" >
        <h:outputText escape="false" value="<strong>�޸���Ա������Ϣ</strong>"/>
        <h:panelGroup>
            <h:selectBooleanCheckbox onclick="submit()" id="orderByName" valueChangeListener="#{wage_OrderInputBB.changeOrder}"></h:selectBooleanCheckbox>
            <h:outputText value="����������"></h:outputText>
        </h:panelGroup>
        <h:panelGrid align="center" columns="3" width="15%">
            <h:commandButton styleClass="button01" value="ȷ��" action="#{wage_OrderInputBB.savePersonInput}"   />
            <h:commandButton styleClass="button01" type="button" value="ȡ��" onclick="window.close()"/>
        </h:panelGrid>
    </h:panelGrid>

    <c:verbatim escape="false">
     <br>
        <%
            if (persId != null && field != null) {
                int col = field.length;
                int row = persId.length;
        %>
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03">
            <tr>
                <td colspan="<%=col+3%>" nowrap class="td_top">��ѡ����Ա�б�&nbsp&nbsp<%out.print("����"+row+"��");%></td>
            </tr>

            <tr>
                <td nowrap class="td_top">Ա�����</td>
                <td nowrap class="td_top">����</td>
                <td nowrap class="td_top">���ڲ���</td>
                <%
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top>" + CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM, field[j]) + "</td>");
                    }
                %>
            </tr>
            <tr>
                <td colspan="3" nowrap class="td_top">��������</td>
                <%
                      for (int j = 0; j < col; j++) {
                            String fldname = "ALL" + field[j];
                            InfoItemBO item = SysCacheTool.findInfoItem("A001", field[j]);
                            if (item.getItemId().equals("A001743")) {
                                String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' readonly type='text' value='' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|s'>");
                                out.println("<input type='button'  class='button_select' onclick='PopUpWageDeptDlg(\"" + fldname + "\",\"" + setID + "\")'>");
                                out.println("<input type='button'  value='������ֵ' class='button01' onclick='batchUpdate(\""+field[j]+"\")'>");
                                out.println("</td>");
                            } else {
                                if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                                    String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|s'><input type='button'  class='button01' value='������ֵ' onclick='batchUpdate(\""+field[j]+"\")'></td>");
                                } else {
                                    String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|f'><input type='button'  class='button01' value='������ֵ' onclick='batchUpdate(\""+field[j]+"\")'></td>");
                                }
                            }
                    }
                 %>
            </tr>

            <%
                for (int i = 0; i < row; i++) {
                    out.println("<tr>");
                    PersonBO pb=SysCacheTool.findPersonById(persId[i]);
                    for (int j = -1; j < col; j++) {
                        if (j == -1) {
                            out.println("<td class=td_top>" + pb.getPersonCode() + "</td>");
                            out.println("<td class=td_top>" + pb.getName()+ "</td>");
                            out.println("<td class=td_top>" + CodeUtil.interpertCode(CodeUtil.TYPE_ORG,pb.getDeptId()) + "</td>");
                        } else {
                            String fldname = persId[i] + "|" + field[j];
                            InfoItemBO item = SysCacheTool.findInfoItem("A001", field[j]);
                            if (item.getItemId().equals("A001743")) {
                                String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' readonly type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|s'>");
                                out.println("<input type='button'  class='button_select' onclick='PopUpWageDeptDlg(\"" + fldname + "\",\"" + setID + "\")'>");
                                out.println("</td>");
                            } else {
                                if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                                    String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|s'></td>");
                                } else {
                                    String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                    out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|f'></td>");
                                }
                            }
                        }
                    }
                    out.println("</tr>");
                }
            %>
        </table>
        <%
            }
        %>
    </c:verbatim>
</h:form>
