<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.hr319wg.emp.util.PersonTool" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%
    String setId = request.getParameter("setId");
    String pid = (String) session.getAttribute("batch_perlist");
    if (setId != null && !"".equals(setId)) {
        ArrayList list = (ArrayList) request.getAttribute("batch_pers");
        if (list != null && list.size() > 0) {

            TableVO table2 = (TableVO) request.getAttribute("batch_cur");
            String[] pids = pid.split(",");
            HashMap map = PersonTool.setTable(table2, pids);
            int[] ff = new int[map.size()];
            RecordVO[] r2 = new RecordVO[map.size()];
            for (int m = 0; m < map.size(); m++) {
                if ((RecordVO) map.get(pids[m]) == null) {
                    ff[m] = 1;
                } else {
                    r2[m] = (RecordVO) map.get(pids[m]);
                }
            }
            CellVO[] header = table2.getHeader();
            int colnum = header.length;

            out.println("<table width=95% border=0 cellspacing=0 cellpadding=0 align=center>");
            //draw  header 画列表头
            out.println("<tr>");
            if (!setId.equals("A001"))
                out.println("<td class=td_top nowrap>姓名</td>");
            for (int i = 0; i < colnum; i++) {
                if (InfoItemBO.DATA_TYPE_CLOB.equals(header[i].getItemDataType()) || InfoItemBO.DATA_TYPE_IMAG.equals(header[i].getItemDataType())
                        || InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[i].getItemProperty())) {
                    continue;
                }
                out.println("<td class=td_top nowrap>" + header[i].getItemName() + "</td>");
            }
            out.println("</tr>");
            //end 画表头
            //draw table body
            int k = 0;
            for (int i = 0; i < list.size(); i++) {
                PersonBO bo = (PersonBO) list.get(i);
                out.println("<tr>");
                if (!setId.equals("A001")) {
                    out.println("<td class=td_top nowrap>");
                    out.println(CommonFuns.filterNull(bo.getName()));
                    out.println("</td>");
                }
                if (ff[i] == 1) {
                    for (int j = 0; j < colnum; j++) {
                        out.println("<td class=td_02 nowrap >");
                        out.println("  ");
                        out.println("</td>");
                    }
                } else {
                    RecordVO r3 = null;
                    if (r2.length < list.size()) {
                        r3 = r2[k++];
                    } else {
                        r3 = r2[i];
                    }
                    for (int j = 0; j < colnum; j++) {
                        CellVO cell = r3.getCell()[j];
                        int right = cell.getPermission();
                        String value = CommonFuns.filterNull(cell.getValue());
                        switch (right) {
                            case 1:
                                value = "********";
                                break;
                            case 2:
                            case 3:
                                break;
                        }

                        if (cell.getItemId().equals("A001001")) {
                            out.println("<td class=td_top nowrap >" + value + "&nbsp;</td>");
                        } else
                        if (InfoItemBO.DATA_TYPE_CLOB.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_IMAG.equals(cell.getItemDataType()) || InfoItemBO.PROPERTY_CONTROL_HIDE.equals(cell.getItemProperty())) {
                            continue;
                        } else if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType())) {
                            out.println("<td class=td_middle nowrap   >");
                            out.println(CodeUtil.interpertCode(CommonFuns.filterNull(cell.getItemCodeSet()), value));
                            out.println("&nbsp;</td>");
                        } else
                        if (InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_WAGE.equals(cell.getItemDataType())) {
                            out.println("<td class=td_middle nowrap   > ");
                            out.println(CodeUtil.interpertCode("OU", value));
                            out.println("&nbsp;</td>");
                        } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType())) {
                            out.println("<td class=td_top nowrap   > ");
                            out.println(CodeUtil.interpertCode("PE", value));
                            out.println("&nbsp;</td>");
                        } else if (InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType())) {
                            out.println("<td class=td_middle nowrap  > ");
                            out.println(CodeUtil.interpertCode("PO", value));
                            out.println("&nbsp;</td>");
                        } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())) {
                            out.println("<td class=td_middle nowrap > ");
                            out.println(CodeUtil.interpertCode("PA", value));
                            out.println("&nbsp;</td>");
                        } else if (InfoItemBO.DATA_TYPE_CLOB.equals(cell.getItemDataType())) {
                            continue;
                        } else {
                            out.println("<td class=td_middle nowrap >" + value + "&nbsp;</td>");
                        }
                    }
                }//end 画表体
            }
            out.println("</tr>");
            out.println("</table>");
        }
    }
%>