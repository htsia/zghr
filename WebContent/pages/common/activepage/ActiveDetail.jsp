<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.ucc.IInfoItemUCC" %>
<%@ page import="com.hr319wg.sys.pojo.bo.OrgCodeRelationBO" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>

<script language=javascript src="/js/hashtable.js"></script>
<script language=javascript>
$(function(){
	$(":text,select").width("200px");
});
</script>
<%
    //------------------------------  视图录入页面 ---------------------------------
    String editFlag=request.getParameter("editFlag");
    //是否查看
    boolean isEdit = true;
    try {
        isEdit = Boolean.valueOf(request.getParameter("isEdit")).booleanValue();
    } catch (Exception e) {
    }
    String tableId = request.getParameter("tableId");

    //是否是员工自助
    boolean boolSelf = false;
    try {
        boolSelf = Boolean.valueOf(request.getParameter("self")).booleanValue();
    } catch (Exception e) {
    }

    if (tableId == null || "".equals(tableId.trim())) {
        tableId = Constants.OBJECT_DETAIL;
    }
    TableVO table = (TableVO) request.getAttribute(tableId);
    if (table == null)
        table = (TableVO) session.getAttribute(tableId);

    String flag = request.getParameter("flag");
    String fk = "";
    fk = (String) session.getAttribute(tableId + "fk");   // 这样可以动态变动人员
    if (fk == null || "".equals(fk)) {
        fk = request.getParameter("fk");
    }
    String setId = request.getParameter("setId");
    String pk = request.getParameter("pk");
    String zpphoto = "display:none";
    String sfzphoto = "display:none";
    String imageValue = "";
    String zpValue = "";
    String sfzValue = "";

    IInfoItemUCC itemucc = (IInfoItemUCC) SysContext.getBean("sys_infoItemUccImpl");
    if (table != null) {
        int tableright = table.getPermission();
        if (tableright == TableVO.PERMISSON_REFUSE) {
            //拒绝的权限
            out.println("<font color=#0033CC>对不起，您没有权限查看该指标集！</font>");
            return;
        }

        String tableRt = "";
        switch (tableright) {
            case TableVO.PERMISSON_READ://读的权限
                tableRt = "disabled";
                break;
            case TableVO.PERMISSON_WRITE://写的权限
                tableRt = "";
                break;
        }

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
            flag = "2";
        } else {                                                 //子集是多记录
            pk = ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).getValue();
        }

        // 对指标进行循环
//         User user =(User)session.getAttribute(Constants.USER_INFO);
//         Map itemMap=user.getPmsInfoItem();
//         if(itemMap==null){
//         	itemMap=new HashMap();
//         }
        for (int j = 0; j < colnum; j++) {
            CellVO cell = row[j];
//             if(!itemMap.containsKey(cell.getItemId()) && cell.getItemId().startsWith(setId)){
//             	continue;
//             }
            if (boolSelf && !InfoItemBO.INFO_ITEM_SELF.equals(cell.getItemSelf())) {
                continue;
            }
            cellType = cell.getItemDataType();//指标的数据类型
            property = cell.getItemProperty();//指标的属性
            itemId = CommonFuns.filterNull(cell.getItemId());//指标的数据库代码
            itemName = CommonFuns.filterNull(cell.getItemName());//指标的中文名称
            maskValue = CommonFuns.filterNull(cell.getValue());//指标的值

            if (InfoItemBO.DATA_TYPE_IMAG.equals(cell.getItemDataType())) {
                imageValue = maskValue;
            }

            // A001780	员工照片 单位公章
            if ("A001780".equals(cell.getItemId()) || "B001082".equals(cell.getItemId())) {
                zpValue = maskValue;
                if (zpValue != null && !"".equals(zpValue)) {
                    zpphoto = "";  //显示照片
                    //将照片数据从数据库中取到本地
                    try {
                        String basepath = application.getRealPath("/");
                        AttachmentUCC aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");
                        if (!aucc.checkAttachFileExist(basepath, zpValue)) {
                            aucc.getFileContentToFile(basepath, zpValue);
                        }
                    }
                    catch (Exception e) {

                    }
                }
            }
            //A001786 身份证图片
            if ("A001786".equals(cell.getItemId())) {
                sfzValue = maskValue;
                if (sfzValue != null && !"".equals(sfzValue)) {
                    sfzphoto = "";  //显示照片
                    //将照片数据从数据库中取到本地
                    try {
                        AttachmentUCC aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");
                        String basepath = application.getRealPath("/");
                        if (!aucc.checkAttachFileExist(basepath, sfzValue)) {
                            aucc.getFileContentToFile(basepath, sfzValue);
                        }
                    }
                    catch (Exception e) {

                    }
                }
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
            String cellStatus="";

            //指标的不同权限，在页面不同显示(隐藏、只读、可写)
            if (InfoItemBO.PROPERTY_CONTROL_SHOW.equals(cell.getItemProperty())) {
                cellRight = "readonly";
                operRight = "disabled";
            }
            switch (cell.getPermission()) {
                case CellVO.PERMISSION_REFUSE:
                    if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(cell.getItemProperty())) {
                        cellRight = "readonly";
                        maskValue = "";
                        operRight = "disabled";
                    }
                    break;
                case CellVO.PERMISSION_READ:
                    cellRight = "readonly";
                    operRight = "disabled";
                    break;
                case CellVO.PERMISSION_WRITE:
                    cellRight = "";
                    operRight = "";
                    break;
                default:
                    cellRight = "";
                    operRight = "";
                    break;
            }
            if (InfoItemBO.PROPERTY_CONTROL_SHOW.equals(cell.getItemProperty())) {
                cellRight = "readonly";
                operRight = "disabled";
            }
            if (!isEdit) {
                cellRight = "readonly";
                msg = "";
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
            String notNull = CommonFuns.filterNull(cell.getItemNotNull());
            if ("1".equals(notNull)) {
                notNull = "0";
                tdfontclass = "td_form01 td_form_required";
            } else {
                notNull = "1";
            }
            check.append(" alt=\"")
                    .append(CommonFuns.filterNull(cell.getItemName())).append("|")
                    .append(CommonFuns.filterNull(notNull)).append("|")
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
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" "+cellRight+" ")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" type=\"hidden\" class=\"input\" value='" + imageValue + "'>");
                    out.println("<td class=td_form01 >" + itemName + "</td>");
                    out.print(input.toString());
                    out.print("<td  class=td_form02  nowrap valign=top>");
                    if (isEdit) {
                        out.print("<iframe name=" + itemId + " frameBorder=0 width=\"100%\" height=22 scrolling=no src='/common/UploadPhoto.jsf?pk=" + pk + "&imageItemId=" + itemId + "&imageId=" + imageValue + "'></iframe>");
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
                                out.println("<option  value=" + realValue + ">" + maskValue + "</option>");
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
                    } else {
                        if ("readonly".equals(cellRight)){
                             input.append(maskValue);
                             input.append("<input type='hidden' name='"+itemId+"' value='"+realValue+"'>");
                        }
                        else{
                             input.append("<input name=\"")
                                .append(itemId).append("\"")
                                .append(" type=\"text\" style=\"behavior:url('/js/mytextbox.htc');\" class=\"input\" ")
                                .append(" readonly ")
                                .append(id)
                                .append(next)
                                .append(check)
                                .append(event)
                                .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                                .append(" code=\"").append(realValue).append("\" ")
                                .append(value)
                                .append(">");
                        }
                        out.println("<td class='" + tdfontclass + "'  >" + itemName + "</td>");
                        out.print("<td class=" + tdclass + "  >");
                        out.print(input.toString());
                        if (isEdit && !"readonly".equals(cellRight)) {
                            if ("1".equals(cell.getCodeByOrg())) {
                                String orgid = fk;
                                if (cell.getItemId().startsWith("A")){
                                    PersonBO pbbo = SysCacheTool.findPersonById(fk);
                                    orgid=pbbo.getOrgId();
                                }
                                OrgCodeRelationBO orgcode = itemucc.getOrgCodeRelationBO(orgid, cell.getItemCodeSet());
                                if (orgcode != null && orgcode.getRootID() != null && !"".equals(orgcode.getRootID())) {
                                    out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCodeDlgOneControl('" + cell.getItemId().trim() + "','" + orgcode.getRootID() + "')\">");
                                } else {
                                    out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCodeDlgOneControl('" + cell.getItemId().trim() + "')\">");
                                }
                            } else {
                                out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCodeDlgOneControl('" + cell.getItemId().trim() + "')\">");
                            }
                        }
                    }
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_POST.equals(cellType)) {//岗位型指标的处理
                	if("0".equals(editFlag)){
	                    input.append("<input name=\"")
	                            .append(itemId).append("\"")
	                            .append(" type=\"text\" class=\"input\" ")
	                            .append(" readonly ")
	                            .append(id)
	                            .append(next)
	                            .append(check)
	                            .append(event)
	                            .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
	                            .append(" code=\"").append(realValue).append("\" ")
	                            .append(value)
	                            .append(" style='border:none;'>");
                	}else{
	                    input.append("<input name=\"")
	                            .append(itemId).append("\"")
	                            .append(" type=\"text\" class=\"input\" ")
	                            .append(" readonly ")
	                            .append(id)
	                            .append(next)
	                            .append(check)
	                            .append(event)
	                            .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
	                            .append(" code=\"").append(realValue).append("\" ")
	                            .append(value)
	                            .append(" >");
                	}
                    out.println("<td class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit) {
						if("A001".equals(setId)){
							out.print("<input type=\"button\" " + operRight + " class=\"button_select\" if onclick=\"fPopUpPostDlgRy('" + cell.getItemId().trim() + "')\">");
						}else{						
							out.print("<input type=\"button\" " + operRight + " class=\"button_select\" if onclick=\"fPopUpPostDlg('" + cell.getItemId().trim() + "')\">");
						}                        
                    }
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_COMPUTE.equals(cellType)) {//计算型指标
                    input.append("<input  name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(" "+cellRight+" ")
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
                    if ("readonly".equals(cellRight)){
                        input.append(maskValue);
                        input.append("<input type='hidden' name='"+itemId+"' value='"+realValue+"'>");
                    }
                    else{
                        input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(value)
                            .append(event)
                            .append(">");
                    }
                    out.println("<td  class='" + tdfontclass + "' >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_date\" onclick=\"PopUpCalendarDialog('" + cell.getItemId().trim() + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_DATE6.equals(cellType)) {//六位日期型指标
                    if ("readonly".equals(cellRight)){
                        input.append(maskValue);
                        input.append("<input type='hidden' name='"+itemId+"' value='"+realValue+"'>");
                    }
                    else{
                      input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(value)
                            .append(event)
                            .append(">");
                    }
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpCalendarDlg_OnlyMonth('" + cell.getItemId().trim() + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else
                if (InfoItemBO.DATA_TYPE_FLOAT.equals(cellType) || InfoItemBO.DATA_TYPE_INT.equals(cellType)) {//数值型
                    if ("readonly".equals(cellRight)){
                        input.append(maskValue);
                        input.append("<input type='hidden' name='"+itemId+"' value='"+realValue+"'>");
                    }
                    else{
                        input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(" "+cellRight+" ")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(formula)
                            .append(value)
                            .append(event)
                            .append(">");
                    }
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_ORG.equals(cellType)) { //机构型指标
                    if ("readonly".equals(cellRight)){
                        input.append(maskValue);
                        input.append("<input type='hidden' name='"+itemId+"' value='"+realValue+"'>");
                    }
                    else{
                        input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(" "+cellRight+" ")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append("OU").append("\"")
                            .append(" code=\"").append(realValue).append("\" ").append(value)
                            .append(">");
                    }
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit && !"readonly".equals(cellRight)) {
                        if ("A001706".equals(cell.getItemId()) || "C001010".equals(cell.getItemId())) {  // 班组
                            out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpOrgDlgShowGroup('" + cell.getItemId().trim() + "',1,'')\">");
                        } else {
                            out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"PopUpOrgDlg('" + cell.getItemId().trim() + "',1,'')\">");
                        }
                    }
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_WAGE.equals(cellType)) { //发薪机构型指标
                    if ("readonly".equals(cellRight)){
                        input.append(maskValue);
                        input.append("<input type='hidden' name='"+itemId+"' value='"+realValue+"'>");
                    }
                    else{
                        input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(" "+cellRight+" ")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append("WA").append("\"")
                            .append(" code=\"").append(realValue).append("\" ").append(value)
                            .append(">");
                    }
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit)
                        out.print("<input type=\"button\" " + operRight + " class=\"button_select\" onclick=\"fPopUpWageUnitDlg('" + cell.getItemId().trim() + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_WAGEDEPT.equals(cellType)) { //发薪部门型指标
                    if ("readonly".equals(cellRight)){
                        input.append(maskValue);
                        input.append("<input type='hidden' name='"+itemId+"' value='"+realValue+"'>");
                    }
                    else{
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(id)
                            .append(next)
                            .append(check)
                            .append(event)
                            .append(" readOnly ").append(value)
                            .append(">");
                    }
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    if (isEdit && !"readonly".equals(cellRight))
                        out.print("<input type=\"button\"  class=\"button_select\" onclick=\"PopUpWageDeptDlgByPerson('" + cell.getItemId().trim() + "','" + pk + "')\">");
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cellType)) { //党组织指标
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(" "+cellRight+" ")
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
                            .append(" cols=\"80\" rows=\"8\" ")
                            .append(" "+cellRight+" ")
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
                    if ("readonly".equals(cellRight)){
                         input.append(maskValue);
                         input.append("<input type='hidden' name='"+itemId+"' value='"+realValue+"'>");
                    } else {
                    	if("A001077".equals(itemId)){
	                        input.append("<input onblur='setBirth();' name=\"")
	                                .append(itemId).append("\"")
	                                .append(" type=\"text\" class=\"input\" ")
	                                .append(" "+cellRight+" ")
	                                .append(id)
	                                .append(next)
	                                .append(check)
	                                .append(event)
	                                .append(value)
	                                .append(">");                    		
                    	}else{
	                        input.append("<input name=\"")
	                                .append(itemId).append("\"")
	                                .append(" type=\"text\" class=\"input\" ")
	                                .append(" "+cellRight+" ")
	                                .append(id)
	                                .append(next)
	                                .append(check)
	                                .append(event)
	                                .append(value)
	                                .append(">");
                    	}
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
                        out.print("<input type=\"button\" " + operRight + " class=\"button01\" value=\"选择人员\" onclick=\"" + click + "\" >");
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
            out.println("<td align=center>");
            out.println("<input name=save  type=button class=button01 value= '保存' " + tableRt + " onclick=forsave(document.forms(0))>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
            if (InfoSetBO.RS_TYPE_MANY.equals(table.getSet_rsType())) {
                out.println("<input name=back  type=button class=button01 value= '返回' " + tableRt + " onclick=forBack(document.forms(0))>");
            }
            out.println("</td>");
            out.println("</tr>");
            out.println("</table>");
        }
        out.println("<input type=hidden name=flag value='" + CommonFuns.filterNull(flag) + "'>");
        out.println("<input type=hidden name=fk value='" + CommonFuns.filterNull(fk) + "'>");
        out.println("<input type=hidden name=setId value='" + CommonFuns.filterNull(setId) + "'>");
        out.println("<input type=hidden name=pk value='" + CommonFuns.filterNull(pk) + "'>");
        //修改parent页面参数
        out.println("<script language=\"javascript\">");
        out.println("</script >");
    }
%>

<div id=seryFilterDiv style="cursor:move;position:absolute;z-index:0;right:0px;top:0px;<%=zpphoto%>;">
    <img id=showZP  width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> alt="照片">
</div>
<div id=seryFilterDiv2 onMouseDown="catchFilter2()" onMouseUp="releaseFilter2()"
     style="cursor:move;position:absolute;z-index:0;left:650px;top:<%=Constants.PHOTOHEIGHT%>px;<%=sfzphoto%>;">
    <img id=showSFZ  width=<%=Constants.IDWIDTH%> height=<%=Constants.IDHEIGHT%> alt="身份证">
</div>
<div id=seryFilterDiv3 onMouseDown="catchFilter3()" onMouseUp="releaseFilter3()"
     style="cursor:move;position:absolute;z-index:0;left:650px;top:140px;display:none">
    <TEXTAREA id="imgText" name="imgText">
    </TEXTAREA>
</div>

<script language=javascript>
    var movePhoto="1";
    <%
        if (zpValue!=null && !"".equals(zpValue)){
           out.println("document.all('showZP').src='';");
           out.println("document.all('showZP').src='/file/tmp/"+zpValue+".JPG';");
        }
        if (sfzValue!=null && !"".equals(sfzValue)){
           out.println("document.all('showSFZ').src='';");
           out.println("document.all('showSFZ').src='/file/tmp/"+sfzValue+".JPG';");
        }
        if ("0".equals(Constants.EMP_ENABLE_MOVE_PHOTO)) out.println("   movePhoto='0';");
    %>

    var countPhoto;
    var photoSrc="";
    var photoID="";

    function setLoadPhoto(){
        countPhoto=window.setInterval("refreshPhoto()",1500);
    }
    function refreshPhoto(){
        window.clearInterval(countPhoto);
        if (photoID=="A001780"){
            document.all.seryFilterDiv.style.display = "";
            document.all.showZP.src = photoSrc;
        }
        else if (photoID=="A001786"){
            document.all.seryFilterDiv2.style.display = "";
            document.all.showSFZ.src = photoSrc;
        }
        else if (photoID=="B001082"){
            document.all.seryFilterDiv.style.display = "";
            document.all.showZP.src = photoSrc;
        }
        else{
            document.all.seryFilterDiv3.style.display = "";
            document.all("imgText").value="图片上传成功,保存后生效！";
        }
    }
    
    function selPost(idf, org) {
        obj = document.all(org);
        if (obj.value == null || obj.value == "") {
            alert("在选岗位时，部门不能为空");
            return;
        }
        var arg = parent.CSApp;
        fPopUpPostDlgByOrg(idf, obj.code, arg);
    }
    function selPostNo(idf) {
        var arg = parent.CSApp;
        fPopUpPostDlg(idf, arg);
    }
    document.all.seryFilterDiv.style.left = document.body.scrollWidth - 120;
    document.all.seryFilterDiv2.style.left = document.body.scrollWidth - 120;
    document.all.seryFilterDiv3.style.left = document.body.scrollWidth - 120;

    var bIsCatchSery = false;
    var dragClickX = 0;
    var dragClickY = 0;

    var bIsCatchSery2 = false;
    var dragClickX2 = 0;
    var dragClickY2 = 0;

    var bIsCatchSery3 = false;
    var dragClickX3 = 0;
    var dragClickY3 = 0;

    function myload_setFilter() {
        seryFilterDiv.style.top = document.body.scrollTop + 100;
        seryFilterDiv.style.left = document.body.scrollLeft + 100;
    }
    function catchFilter(e) {
        if (movePhoto=="0") return ;
        bIsCatchSery = true;
        var x = event.x + document.body.scrollLeft;
        var y = event.y + document.body.scrollTop;
        dragClickX = x - seryFilterDiv.style.pixelLeft;
        dragClickY = y - seryFilterDiv.style.pixelTop;
        seryFilterDiv.setCapture();
        document.onmousemove = moveFilter;
    }
    function catchFilter2(e) {
        if (movePhoto=="0") return ;
        bIsCatchSery2 = true;
        var x = event.x + document.body.scrollLeft;
        var y = event.y + document.body.scrollTop;
        dragClickX2 = x - seryFilterDiv2.style.pixelLeft;
        dragClickY2 = y - seryFilterDiv2.style.pixelTop;
        seryFilterDiv2.setCapture();
        document.onmousemove = moveFilter2;
    }
    function catchFilter3(e) {
        if (movePhoto=="0") return ;
        bIsCatchSery3 = true;
        var x = event.x + document.body.scrollLeft;
        var y = event.y + document.body.scrollTop;
        dragClickX3 = x - seryFilterDiv3.style.pixelLeft;
        dragClickY3 = y - seryFilterDiv3.style.pixelTop;
        seryFilterDiv3.setCapture();
        document.onmousemove = moveFilter3;
    }

    function releaseFilter(e) {
        if (movePhoto=="0") return ;
        bIsCatchSery = false;
        seryFilterDiv.releaseCapture();
        document.onmousemove = null;
    }
    function releaseFilter2(e) {
        if (movePhoto=="0") return ;
        bIsCatchSery2 = false;
        seryFilterDiv2.releaseCapture();
        document.onmousemove = null;
    }
    function releaseFilter3(e) {
        if (movePhoto=="0") return ;
        bIsCatchSery3 = false;
        seryFilterDiv3.releaseCapture();
        document.onmousemove = null;
    }

    function moveFilter(e) {
        if (bIsCatchSery) {
            seryFilterDiv.style.left = event.x + document.body.scrollLeft - dragClickX;
            seryFilterDiv.style.top = event.y + document.body.scrollTop - dragClickY;
        }
    }
    function moveFilter2(e) {
        if (bIsCatchSery2) {
            seryFilterDiv2.style.left = event.x + document.body.scrollLeft - dragClickX;
            seryFilterDiv2.style.top = event.y + document.body.scrollTop - dragClickY;
        }
    }
    function moveFilter3(e) {
        if (bIsCatchSery3) {
            seryFilterDiv3.style.left = event.x + document.body.scrollLeft - dragClickX;
            seryFilterDiv3.style.top = event.y + document.body.scrollTop - dragClickY;
        }
    }
	function moveimg(){
		document.getElementById("seryFilterDiv").style.top = (document.documentElement.scrollTop || document.body.scrollTop);
		document.getElementById("seryFilterDiv").style.left = document.body.clientWidth-110;
	}
	function setBirth(){
		var card = document.all("A001077").value;
		if(card.length==18 || card.length==15){
			if(card.length==18){
				document.all("A001011").value=card.substring(6,10)+"-"+card.substring(10,12)+"-"+card.substring(12,14);
				var sex = card.substring(16,17)%2;
				if(sex==0){
					document.all("A001007").value="女";
				}else{
					document.all("A001007").value="男";					
				}
			}else{
				document.all("A001011").value="19"+card.substring(6,8)+"-"+card.substring(8,10)+"-"+card.substring(10,12);
				var sex = card.substring(14)%2;
				if(sex==0){
					document.all("A001007").value="女";
				}else{
					document.all("A001007").value="男";					
				}
			}
		}
	}
	window.onresize=moveimg;
	window.onscroll=moveimg;
</script>

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        