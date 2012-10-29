<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ page import="com.hr319wg.common.web.SysContext"%>
<%@ page import="com.hr319wg.wage.ucc.impl.WageSetPersonUCC"%>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.wage.ucc.IWageItemPowerUCC" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.api.WageAPI" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    String perstr = request.getParameter("PerStr");
    String setID = request.getParameter("setId");
    String inputField=request.getParameter("inputField");

    if (setID == null || "".equals(setID)) {
        setID = (String) session.getAttribute("setId");
    }
    if (setID == null || "".equals(setID)) { //ȡ����Ա��setID
        User user=(User)session.getAttribute(Constants.USER_INFO);
        WageAPI api = (WageAPI) SysContext.getBean("wage_api");
        setID=api.querySetByPersonID(user.getUserId());
    }
    String[] persId = null;
    if (perstr == null) {  //�㰴��������Ļط�
        persId = (String[]) session.getAttribute("persId");
        setID = (String) session.getAttribute("setId");
    } else {
        persId = perstr.split(",");
        session.setAttribute("persId", persId);
        session.setAttribute("setId", setID);
    }

    User user = (User) session.getAttribute(Constants.USER_INFO);
    IWageItemPowerUCC wagepowerucc = (IWageItemPowerUCC) SysContext.getBean("wage_itemPowerUCC");
    String source = wagepowerucc.getOnlyInsuraceBaseFields(user.getUserId(), setID);
    String[] field=null;
    if (inputField!=null && !"".equals(inputField) && !"-1".equals(inputField)){
        field = inputField.split(",");
    }
    else{
        field = source.split(",");
    }
    // �������ϱ��ո����½ɷѻ���(A755715)
    // ����ҽ�Ʊ��ո����½ɷѻ���(A760710)
    // ���˱��յ�λ�½ɷѻ���(A765705)
    // ʧҵ���ո����½ɷѻ���(A770710)
    //  �������յ�λ�½ɷѻ���(A775704)
    //  ס������������½ɷѻ���(A780708)
    session.setAttribute("field", field);
    HashMap rs = null;
    try {
        WageSetPersonUCC wagesetpersonucc = (WageSetPersonUCC) SysContext.getBean("wage_SetPersonUccImpl");
        rs = wagesetpersonucc.queryPersonBaseItem(persId, field);
    }
    catch (Exception e) {
    }
%>
    <script type="text/javascript">
        function doSetValue(id) {
            <%
            for(int i=0;i<field.length;i++){
                out.println("document.all(id+\"|"+field[i]+"\").value=document.all(\"Base_\"+id).value");
            }
            %>
        }
    </script>

<x:saveState value="#{ins_BaseInfoBB}"/>

<h:form id="form1">
    <h:inputHidden id="setId" value="#{ins_BaseInfoBB.setId}"></h:inputHidden>
    <h:panelGrid align="center" columns="2" width="95%" styleClass="td_title">
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value="�޸ı�����Ա�ɷѻ���"/>
        </h:panelGroup>
        <h:panelGrid align="right" columns="3">
            <h:commandButton styleClass="button01" value="ȷ��" action="#{ins_BaseInfoBB.savePersonBase}"   />
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
        <table width="95%" align="center" cellpadding="2" cellspacing="0" class="table03" id="setlist">
            <tr>
                <td colspan="<%=col+3%>" nowrap class="td_top">��ѡ����Ա�б�&nbsp&nbsp<%out.print("����"+row+"��");%></td>
            </tr>

            <tr>
                <td nowrap class="td_top">Ա�����</td>
                <td nowrap class="td_top">����</td>
                <%if (col>1) { %>
                  <td nowrap class="td_top">����</td>
                <%
                    }
                    for (int j = 0; j < col; j++) {
                        out.println("<td class=td_top>" + CodeUtil.interpertCode(CodeUtil.TYPE_INFOITEM, field[j]) + "</td>");
                    }
                %>
            </tr>
            <%
                for (int i = 0; i < row; i++) {
                    out.println("<tr>");
                    PersonBO pb=SysCacheTool.findPersonById(persId[i]);
                    for (int j = -1; j < col; j++) {
                        if (j == -1) {
                            out.println("<td width='80px' class=td_top>" + pb.getPersonCode() + "</td>");
                            out.println("<td width='80px' class=td_top>" + pb.getName()+ "</td>");
                            if (col>1){
                                out.println("<td width='120px' class=td_top>");
                                out.println("<input name='Base_" + pb.getPersonId() + "' type='text' value='' class='input' size=10>");
                                out.println("<input type='button' class='button01' value='����' onclick='doSetValue(\""+pb.getPersonId()+"\")'>");
                                out.println("</td>");
                            }
                        } else {
                            String fldname = persId[i] + "|" + field[j];
                            InfoItemBO item = SysCacheTool.findInfoItem("", field[j]);
                            if (InfoItemBO.DATA_TYPE_STRING.equals(item.getItemDataType())) {
                                String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=100 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|s'></td>");
                            } else {
                                String value = CommonFuns.filterNullToZero((String) rs.get(fldname));
                                out.println("<td class=td_middle><input name='" + fldname + "' type='text' value='" + value + "' class='input' size=10 maxlenght=20 style=\"behavior:url('../../js/mytextbox.htc');\" alt='����ֵ|0|f'></td>");
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
<script type="text/javascript">
   setTableInputOver("setlist");
</script>
