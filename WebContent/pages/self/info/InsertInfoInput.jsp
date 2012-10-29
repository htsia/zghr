<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ include file="/pages/include/taglib.jsp" %>

<script language=javascript src="/js/hashtable.js"></script>

<%
    //--------------自助信息插入 针对子集-------------
    //是否查看
    boolean isEdit = true;
    String tableId = request.getParameter("tableId");
    if (tableId == null || "".equals(tableId.trim())) {
        tableId = Constants.OBJECT_DETAIL;
    }
    TableVO table = (TableVO) request.getAttribute(tableId);
    if (table == null)
        table = (TableVO) session.getAttribute(tableId);

    String fk = "";
    fk = (String) session.getAttribute(tableId + "fk");   // 这样可以动态变动人员
    if (fk == null || "".equals(fk)) {
        fk = request.getParameter("fk");
    }
    String setId = request.getParameter("setId");
    String pk = "";
    String itemIdName = "";
    String encode = "";
    String imageValue = "";

    if (table != null) {
        int tableright = table.getPermission();

        //1:1 表
        RecordVO[] rsv = table.getRowData();
        CellVO[] row = null;
        //如果TableVO的行记录没有数据，则把TableVO的头部赋给RecordVO
        if (rsv == null || rsv.length == 0) {
            rsv = new RecordVO[1];
            rsv[0] = new RecordVO(table.getHeader());
            table.setRowData(rsv);
        }
        row = rsv[0].getCell();
        int colnum = row.length;
        int count = 0;
        out.println("<br><table width=95% align=center border=0 cellpadding=0 cellspacing=0 class='table03'>");
        //画表格
        StringBuffer input = new StringBuffer();
        StringBuffer check = new StringBuffer();
        StringBuffer id = new StringBuffer();
        StringBuffer next = new StringBuffer();
        StringBuffer value = new StringBuffer();

        String itemId = null;
        String itemName = null;

        String cellRight = "";

        String cellType = "";
        String property = null;
        String maskValue = null;
        String realValue = null;

        String formula = null;
        String datatype = null;

        //修改参数
        RecordVO[] rows = table.getRowData();

        String rsType = table.getSet_rsType();

        if (InfoSetBO.RS_TYPE_SINGLE.equals(rsType)) {   //子集是单记录
            pk = ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).getValue();
            if (pk == null) {
                ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).setValue(fk);
                pk = fk;
            } else {
                fk = pk;
            }
        } else {                                                 //子集是多记录
            pk = ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).getValue();
        }

        // 对指标进行循环
        for (int j = 0; j < colnum; j++) {
            CellVO cell = row[j];
            cellType = cell.getItemDataType();//指标的数据类型
            property = cell.getItemProperty();//指标的属性
            itemId = CommonFuns.filterNull(cell.getItemId());//指标的数据库代码
            itemName = CommonFuns.filterNull(cell.getItemName());//指标的中文名称
            maskValue = CommonFuns.filterNull(cell.getValue());//指标的值

            if (InfoItemBO.DATA_TYPE_IMAG.equals(cell.getItemDataType())) {
                imageValue = maskValue;
            }
            formula = " formula='" + CommonFuns.filterNull(cell.getItemFormula()) + "' ";//指标对应的要调用的javascript方法
            if (cell.getValue() == null) {
                maskValue = CommonFuns.filterNull(cell.getItemDefaultValue());
            }
            realValue = maskValue;

            if (InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, maskValue);  //翻译机构型指标
            } else if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType())) {
                if (maskValue != null && !"".equals(maskValue)) {
                    maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_CODE, maskValue);//翻译代码型指标
                }
            } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, maskValue);  //翻译人员型指标
            } else if (InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_POST, maskValue);//翻译岗位型指标
            } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_PARTY, maskValue);//翻译党组织型指标
            } else if (InfoItemBO.DATA_TYPE_WAGE.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, maskValue); //翻译发薪机构
            }

            String msg = " <font color=red>" + CommonFuns.filterNull(cell.getItemDesc()) + "</font>";//指标的注释
            String nextType = "";
            String operRight = "";

            //指标的不同权限，在页面不同显示(隐藏、只读、可写)
            if (InfoItemBO.PROPERTY_CONTROL_SHOW.equals(cell.getItemProperty())) {
                cellRight = " readonly ";
                operRight = "disabled";
            }
            switch (cell.getPermission()) {
                case CellVO.PERMISSION_REFUSE:
                    if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(cell.getItemProperty())) {
                        cellRight = " readonly ";
                        maskValue = "**********";
                        operRight = "disabled";
                    }
                    break;
                case CellVO.PERMISSION_READ:
                    cellRight = " readonly ";
                    operRight = "disabled";
                    break;
                case CellVO.PERMISSION_WRITE:
                    cellRight = " ";
                    operRight = "";
                    break;
                default:
                    cellRight = " ";
                    operRight = "";
                    break;
            }
            if (InfoItemBO.PROPERTY_CONTROL_SHOW.equals(cell.getItemProperty())) {
                cellRight = " readonly ";
                operRight = "disabled";
            }
            if (!isEdit) {
                cellRight = " readonly ";
                msg = "";
            }
            if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())
                    || InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_WAGE.equals(cell.getItemDataType())) {
                cellRight = " readonly ";
            }
            check.delete(0, check.length());//指标的校验（非空、数字、日期等）
            //指标的长度
            String length = cell.getItemDataLength();
            if (length == null || "".equals(length)) {
                if (InfoItemBO.DATA_TYPE_REMARK.equals(cellType)) {
                    length = "1000";
                } else if (InfoItemBO.DATA_TYPE_STRING.equals(cellType)) {
                    length = "100";
                }
            }
            //指标的校验（非空、数字、日期等）
            String tdclass = "td_form02";
            String tdfontclass = "td_form01";
            check.append(" alt=\"")
                    .append(CommonFuns.filterNull(cell.getItemName())).append("|")
                    .append(CommonFuns.filterNull("1")).append("|")
                    .append(InfoItemBO.getHtmlDataType(cell.getItemDataType())).append("|")
                    .append(CommonFuns.filterNull(length)).append("|")
                    .append(CommonFuns.filterNull(cell.getItemMin())).append("|")
                    .append(CommonFuns.filterNull(cell.getItemMax())).append("|")
                    .append(CommonFuns.filterNull(cell.getItemPrecision())).append("\"");

            id.delete(0, id.length());
            id.append(" id=\"").append(cell.getItemId()).append("\"");

            next.delete(0, next.length());
            next.append(" next=\"");

            value.delete(0, value.length());
            value.append(" value=\"").append(maskValue).append("\"");
            //指标对应的表单含的javascript函数
            String event = " ";

            if (j < colnum - 1) {
                nextType = row[j + 1].getItemDataType();
                next.append(row[j + 1].getItemId()).append("\"");
            } else if (j == colnum - 1) {
                next.append("\"");
            }

            //隐藏指标
            if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(property)) {
                out.print("<input " + id.toString() + " "
                        + next.toString()
                        + " name=\"" + cell.getItemId()
                        + "\" type=\"hidden\" class=\"input\" value='" + CommonFuns.filterNull(realValue) + "'>");
            } else {
                // 每行两个
                if (count % 2 == 0) {
                    out.println("<tr nowrap>");
                }
                input.delete(0, input.length());
                //clob类型的指标,照片
                if (InfoItemBO.DATA_TYPE_IMAG.equals(cellType)) {
                    itemIdName = cell.getItemId();
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" type=\"hidden\" class=\"input\" value='" + imageValue + "'>");
                    out.println("<td class=td_form01 >" + itemName + "</td>");
                    out.print(input.toString());
                    out.print("<td  class=td_form02  nowrap >");
                    if (isEdit) {
                        out.print("<iframe name=" + itemId + " frameBorder=0 width=\"100%\" height=22 scrolling=no src='/common/UploadPhoto.jsf?imageItemId=" + itemId + "&imageId=" + imageValue + "'></iframe>");
                    } else {
                        out.println("<a href='/pages/common/photo.jsp?id=" + imageValue + "' target='_blank'>查看</a>");
                    }
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_CODE.equals(cellType)) {//代码型指标处理
                    if ("1".equals(cell.getItemIsSelect())) {
                        out.println("<td class='" + tdfontclass + "' >" + itemName + "</td>");
                        out.print("<td class=" + tdclass + "  >");
                        out.println("<select name=" + itemId + " style='width:140'   " + cellRight + ">");
                        if (!isEdit || "readonly".equals(cellRight)) {   //如果是只读的
                            if ("".equals(CommonFuns.filterNull(realValue))) {
                                out.println("<option  value=\"\">---请选择---</option>");
                            } else {
                                out.println("<option  value=" + realValue + ">" + value + "</option>");
                            }

                        } else { //可编辑的
                            List list = SysCacheTool.queryCodeItemBySetId(cell.getItemCodeSet());
                            out.println("<option  value=\"\">---请选择---</option>");
                            if (list != null) {
                                for (int i = 0; i < list.size(); i++) {
                                    CodeItemBO cb = (CodeItemBO) list.get(i);
                                    if (cb != null) {
                                        String sel = "";
                                        if (CommonFuns.filterNull(cb.getItemId()).equals(realValue)) {
                                            sel = "selected";
                                        }
                                        out.println("<option  value=" + CommonFuns.filterNull(cb.getItemId()) + " " + sel + ">" + CommonFuns.filterNull(cb.getItemName()) + "</option>");
                                    }
                                }
                            }
                        }
                    } else { // 其他指标
                        input.append("<input name=\"")
                                .append(itemId).append("\"")
                                .append(" type=\"text\" style=\"behavior:url('/js/mytextbox.htc');\" class=\"input\" ")
                                .append(cellRight)
                                .append(id)
                                .append(next)
                                .append(check)
                                .append(event)
                                .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                                .append(" code=\"").append(realValue).append("\" ")
                                .append(value)
                                .append(">");

                        out.println("<td class='" + tdfontclass + "'  >" + itemName + "</td>");
                        out.print("<td class=" + tdclass + "  >");
                        out.print(input.toString());
                        if (isEdit) {
                            out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCodeDlgOneControl('" + cell.getItemId().trim() + "')\">");
                        }
                    }
                    out.println(msg);
                    out.println("</td>");

                } else if (InfoItemBO.DATA_TYPE_POST.equals(cellType)) {//岗位型指标的处理
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                            .append(" code=\"").append(realValue).append("\" ")
                            .append(value)
                            .append(">");
                    out.println("<td class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit) {
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" if onclick=\"fPopUpPostDlg('" + cell.getItemId().trim() + "')\">");
                    }
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_COMPUTE.equals(cellType)) {//计算型指标
                    input.append("<input  name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(formula)
                            .append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_DATE.equals(cellType)) {//日期型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(value)
                            .append(event)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "' >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCalendarDialog('" + cell.getItemId().trim() + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_DATE6.equals(cellType)) {//六位日期型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(value)
                            .append(event)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCalendarDlg_OnlyMonth('" + cell.getItemId().trim() + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else
                if (InfoItemBO.DATA_TYPE_FLOAT.equals(cellType) || InfoItemBO.DATA_TYPE_INT.equals(cellType)) {//数值型
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(formula)
                            .append(value)
                            .append(event)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_ORG.equals(cellType)) { //机构型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append("OU").append("\"")
                            .append(" code=\"").append(realValue).append("\" ").append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit) {
                        if (cell.getItemId() == "A001706") {  // 班组
                            out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpOrgDlgShowGroup('" + cell.getItemId().trim() + "',1,'')\">");
                        } else {
                            out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpOrgDlg('" + cell.getItemId().trim() + "',1,'')\">");
                        }
                    }
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_WAGE.equals(cellType)) { //发薪机构型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append("WA").append("\"")
                            .append(" code=\"").append(realValue).append("\" ").append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"fPopUpWageUnitDlg('" + cell.getItemId().trim() + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_WAGEDEPT.equals(cellType)) { //发薪部门型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" readOnly ").append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpWageDeptDlgByPerson('" + cell.getItemId().trim() + "','" + pk + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cellType)) { //党组织指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append("PA").append("\"")
                            .append(" code=\"").append(realValue).append("\" ").append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'    >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit) {
                        if ("A001708".equals(cell.getItemId()) || "A820200".equals(cell.getItemId())) {
                            out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"fPopUpPartyDlg('" + cell.getItemId().trim() + "','0')\">");
                        } else {
                            out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"fPopUpPartyDlg('" + cell.getItemId().trim() + "','2')\">");
                        }
                    }
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_REMARK.equals(cellType)) { //备注型指标
                    // 确保备注型字段单独一行
                    if (count % 2 == 1) {
                        out.println("</tr>");
                        out.println("<tr nowrap>");
                    }
                    input.append("<textarea name=\"")
                            .append(itemId).append("\"")
                            .append(" cols=\"80\" rows=\"3\" ")
                            .append(cellRight)
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(">")
                            .append(maskValue)
                            .append("</textarea>");
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + " colspan=\"3\">");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                    out.println("</tr>");
                    out.println("<tr nowrap>");
                } else if (InfoItemBO.DATA_TYPE_STRING.equals(cellType)) { //字符型指标
                    if ("A001077".equals(itemId)) {
                        input.append("<input name=\"")
                                .append(itemId).append("\"")
                                .append(" type=\"text\" class=\"input\" ")
                                .append(cellRight)
                                .append(id)
                                .append(next)
                                .append(check)
                                .append(event)
                                .append(value)
                                .append(" size='22'>");
                    } else {
                        input.append("<input name=\"")
                                .append(itemId).append("\"")
                                .append(" type=\"text\" class=\"input\" ")
                                .append(cellRight)
                                .append(id)
                                .append(next)
                                .append(check)
                                .append(event)
                                .append(value)
                                .append(">");
                    }
                    out.println("<td class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cellType)) { //人员型指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" readOnly")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                            .append(" code=\"").append(realValue).append("\" ")
                            .append(value)
                            .append(">");
                    out.println("<td class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit) {
                        String click = "fPopUpPerDlg('" + itemId + "')";
                        out.print("<input type=\"button\" " + operRight + " class=\"buttonface03\" value=\"选择人员\" onclick=\"" + click + "\" >");
                    }
                    out.println(msg);
                    out.println("</td>");
                }
                if (count % 2 == 1) {
                    out.println("</tr>");
                }
                count++;
            }
        }
        out.println("</table><br>");
        if (isEdit) {
            out.println("<table width=95% border=0 align=center cellpadding=0 cellspacing=0>");
            out.println("<tr>");
            out.println("<td align=right>");
            out.println("<input name=save  type=button class=button01 value= '保存' " + " onclick=forsave(document.forms(0))>&nbsp;&nbsp;");
            if (InfoSetBO.RS_TYPE_MANY.equals(table.getSet_rsType())) {
                out.println("<input name=back  type=button class=button01 value= '返回' "  + " onclick=forBack(document.forms(0))>");
            }
            out.println("</td>");
            out.println("</tr>");
            out.println("</table>");
        }
        out.println("<input type=hidden name=fk value='" + CommonFuns.filterNull(fk) + "'>");
        out.println("<input type=hidden name=setId value='" + CommonFuns.filterNull(setId) + "'>");
        out.println("<input type=hidden name=pk value='" + CommonFuns.filterNull(pk) + "'>");
    }
%>

