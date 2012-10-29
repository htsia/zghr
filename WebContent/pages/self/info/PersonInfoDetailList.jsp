<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.common.Constants"%>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.org.util.OrgTool" %>
<%@ include file="/pages/include/taglib.jsp" %>

<script language=javascript src="/js/list.js"></script>
<script type="text/javascript">
        function forAdd(setid) {
            window.showModalDialog("/self/info/InsertInfo.jsf?setId="+setid, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:no;");
            return true;
        }
        function BatchModiInfo(setid,kid){
            window.showModalDialog("/self/info/BatchModifyInfo.jsf?setId="+setid+"&keyId="+kid, null, "dialogWidth:600px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:auto;");
            return false;
        }
        
        function ModiInfo(setid,kid) {
            window.showModalDialog("/self/info/ModifyInfo.jsf?setId="+setid+"&keyId="+kid, null, "dialogWidth:330px; dialogHeight:300px;center:center;resizable:yes;status:no;scroll:no;");
            return false;
        }
        function showChkList(fk){
            window.showModalDialog("/self/info/ChkList.jsf?fk="+fk, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
    </script>
<body style="height:1000px">
    <x:saveState value="#{self_personEditBB}" />
    <h:form id="form1">
       <h:inputHidden value="#{self_personEditBB.table}"/>
    </h:form>
    <%
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
        String fk = request.getParameter("fk");

        //“维护”、“查看”等对列表某行进行处理的展示名
        String[] editColName = null;
        String[] editName = null;
        //“维护”、“查看”等对列表某行进行处理的javascript函数名，如forView()
        String[] editFuncName = null;

        //是否检查操作权限
        boolean isCheckRight = false;
        //是否分页
        boolean isPage = false;

        //是否编辑列表
        boolean isEditList = true;
        //列表页面是否滚动
        boolean isScroll = true;

        //从request里得到TableVO,键值request.getAttribute(tableId)
        String tableId = request.getParameter("target");
        if (tableId == null || "".equals(tableId.trim())) {
            tableId = Constants.OBJECT_DETAIL;
        }

        //从request得到TableVO
        TableVO table = (TableVO) request.getAttribute(tableId);
        //如果request里没有，则从session里取
        if (table == null) {
            table = (TableVO) session.getAttribute(tableId);
        }

        //主键对应的字段名
        String keyName = request.getParameter("keyName");

        if (table != null) {
            //得到列表的头部
            CellVO[] header = table.getHeader();
            //得到列表的记录
            RecordVO[] rows = table.getRowData();
            //列表的列数
            int colnum = header.length;
            //列表的记录数
            int rownum = rows.length;
            String divId = "";
            //如果允许列表页面滚动的话，则给列表位于div，设一个id值
            if (isScroll) {
                divId = "id=datatable";
            }
            out.println("<div " + divId + " style='height:100%;width:100%'>");

            //根据权限设定操作
            int tableright = table.getPermission();

            if (tableright == TableVO.PERMISSON_WRITE) {
                out.println("<table width=95% align=center>");
                out.println("<tr><td align='right'><input type='button' class='button01' value='提交添加申请' onclick=\"forAdd('"+table.getSetId()+"')\"><input type='button' value='修改历史记录' class='button01' onclick=\"showChkList('"+fk+"')\"></td></tr>");
                out.println("</table>");

                editColName=new String[1];
                editColName[0]="操作";

                editName=new String[1];
                editName[0]="提交修改申请";

                editFuncName=new String[1];
                editFuncName[0]="ModiInfo";
            }
            else{
                out.println("<br>");
            }
            out.println("<table width=95% border=0 cellpadding=0 cellspacing=0 align=center class='table03' id='list'>");

            //draw header 画列表页面的头部所占的那一行
            String trFubc = "";

            out.println("<tr> ");
            //如果允许编辑的话，则画列表维护部分,在前部
            if (editColName != null && editColName.length > 0) {
                for (int e = 0; e < editColName.length; e++) {
                    out.println("<td id=\"locked\"  class=locked_top align=center nowrap>");
                    out.println(editColName[e]);
                    out.println("</td>");
                }
            }
            //画头部各列
            for (int i = 0; i < colnum; i++) {
                if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[i].getItemProperty()) || InfoItemBO.DATA_TYPE_CLOB.equals(header[i].getItemDataType())) {
                    continue;
                } else {
                    if (header[i].isShowId()) {
                        if (InfoItemBO.DATA_TYPE_CODE.equals(header[i].getItemDataType())) {
                            out.println("<td id=\"locked\"  class=locked_top nowrap >" + header[i].getItemName() + "代码</td>");
                        }
                        out.println("<td id=\"locked\"  class=locked_top nowrap >" + header[i].getItemName() + "</td>");
                    } else {
                        out.println("<td id=\"locked\"  class=locked_top nowrap >" + header[i].getItemName() + "</td>");
                    }
                }
            }
            out.println("</tr> ");

            //先按行循环
            // 处理主键
            if (keyName == null || "".equals(keyName)) {
                if (table.getSetId() != null && !"".equals(table.getSetId())) {
                    keyName = table.getSetPk();//子集的主键
                } else if (rownum > 0) {
                    String setType = rows[0].getCell()[0].getSetId().substring(0, 1);//子集是A类还是B类
                    keyName = InfoSetBO.getPkType(setType);
                }
            }

            for (int i = 0; i < rownum; i++) {
                RecordVO row = rows[i]; //得到某一行
                out.println("<tr onclick=" + trFubc + ">");
                String rowId = "[" + i + "]";
                if (rownum == 1) {
                    rowId = "";
                }

                String backValue = "";
                // 再按列
                for (int j = 0; j < colnum; j++) {
                    Hashtable tmphash = row.cellArray2Hash();//得到某列
                    CellVO cell = row.getCell()[j];
                    int right = cell.getPermission();//指标的权限

                    String idValue = "";

                    //得到主键的值
                    idValue = ((CellVO) tmphash.get(keyName)).getValue();
                    backValue = ((CellVO) tmphash.get(keyName)).getValue();

                    //得到这一列的值
                    String value = CommonFuns.filterNull(cell.getValue());
                    switch (right) {
                        case 1:
                            value = "*****";
                            break;
                        case 2:
                        case 3:
                            break;
                    }

                    //第一列画checkBox或者radioButton ，和维护函数
                    if (j == 0) {
                        //画维护函数，在前部
                        if (editName != null && editName.length > 0) {
                            for (int e = 0; e < editName.length; e++) {
                                out.println("<td align=center class=td_middle nowrap>");
                                String oper = editFuncName[e] + "('"+table.getSetId()+"','"+idValue+"')";
                                out.println("<input type='button' class='button01' onclick=\"return " + oper + "\" value='"+editName[e]+"'>");
                                out.println("</td>");
                            }
                        }
                    }

                    //如果允许在列表页面编辑
                    //不允许编辑列表
                    String func = "";
                    String styleEvent = "onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)";
                    String align = "";
                    // 数值型采用右对齐
                    if (InfoItemBO.DATA_TYPE_FLOAT.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_INT.equals(cell.getItemDataType())) {
                        align = "align=right";
                    }
                    if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[j].getItemProperty())) {
                        if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType())) {
                            if (cell.isShowId()) {   //高级查询使用
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                if (value.length() > 4) {
                                    out.println(value.substring(4, value.length()));
                                } else {
                                    out.println(CommonFuns.filterNull(value));
                                }
                                out.println("&nbsp;</td>");
                                out.println("<td class=td_middle  nowrap " + styleEvent + "  onclick=\"javascript:" + func + "\" >");
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode(CommonFuns.filterNull(cell.getItemCodeSet()), value)));
                                out.println("&nbsp;</td>");
                            } else {
                                out.println("<td class=td_middle  nowrap " + styleEvent + "  onclick=\"javascript:" + func + "\" >");
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode(CommonFuns.filterNull(cell.getItemCodeSet()), value)));
                                out.println("&nbsp;</td>");
                            }
                        } else
                        if (InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_WAGE.equals(cell.getItemDataType())) {
                            if (cell.isShowId()) { //高级查询使用
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(value));
                                out.println("&nbsp;</td>");
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode("OU", value)));
                                out.println("&nbsp;</td>");
                            } else {
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                if ("C001010".equals(cell.getItemId())) {
                                    out.println(CommonFuns.filterNull(OrgTool.getOrgByDeptName(value)));
                                } else {
                                    out.println(CommonFuns.filterNull(CodeUtil.interpertCode("OU", value)));
                                }
                                out.println("&nbsp;</td>");
                            }
                        } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType())) {
                            if (cell.isShowId()) {
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(value));
                                out.println("&nbsp;</td>");
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PE", value)));
                                out.println("&nbsp;</td>");
                            } else {
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PE", value)));
                                out.println("&nbsp;</td>");
                            }
                        } else if (InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType())) {
                            if (cell.isShowId()) {
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(value));
                                out.println("&nbsp;</td>");
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PO", value)));
                                out.println("&nbsp;</td>");
                            } else {
                                out.println("<td class=td_middle nowrap  " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PO", value)));
                                out.println("&nbsp;</td>");
                            }
                        } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())) {
                            if (cell.isShowId()) {
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(value));
                                out.println("&nbsp;</td>");
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PA", value)));
                                out.println("&nbsp;</td>");
                            } else {
                                out.println("<td class=td_middle nowrap " + styleEvent + " onclick=\"javascript:" + func + "\" > ");
                                out.println(CommonFuns.filterNull(CodeUtil.interpertCode("PA", value)));
                                out.println("&nbsp;</td>");
                            }
                        } else if (InfoItemBO.DATA_TYPE_CLOB.equals(cell.getItemDataType())) {
                            continue;
                        }
                        else if (InfoItemBO.DATA_TYPE_IMAG.equals(cell.getItemDataType())) {   // 图片
                            out.println("<td class=td_middle"  + align + " nowrap  " + styleEvent + " onclick='return viewPhotoField(\""+value+"\",\""+cell.getItemId()+"\",\""+idValue+"\")'>查看图片</td>");
                        }
                        else if ("A815712".equals(cell.getItemId())) {  //实发工资(A815712)
                            if (value.indexOf("-") >= 0) {  // 负值
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + "<img src='/images/common/unvalidate.gif'><font color='red'>" + value + "&nbsp;</font></td>");
                            } else {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                            }
                        } else if ("A001001".equals(cell.getItemId())) {  //A001735	A001	员工编号
                            if (idValue.startsWith("@")) {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\"><font color=red>" + value + "(兼职)" + "</font>&nbsp;</td>");
                            } else if (idValue.startsWith("#")) {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\"><font color=red>" + value + "(副本)" + "</font>&nbsp;</td>");
                            } else {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                            }
                        } else if (InfoItemBO.DATA_TYPE_WAGEDEPT.equals(cell.getItemDataType())) {  //A001743	A001	薪资部门
                            if (value.length() > Integer.parseInt(Constants.WAGE_DEPT_CODELEN)) {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value.substring(Integer.parseInt(Constants.WAGE_DEPT_CODELEN)) + "&nbsp;</td>");
                            } else {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                            }
                        } else {
                            out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                        }
                    }
                }
                out.println("</tr>");
            }

            out.println("</table>");
            out.println("</div>");
            // 列锁定
            out.println("<script language=javascript>setFixCol(2);</script>");
        }
    %>

    <script language=javascript>
        window.setInterval("setFix()", 500);
        try {
            if (screen.width == 800 && screen.height == 600) {
                document.all("datatable").style.pixelHeight = 280;
            }
        } catch(err) { }

    </script>

</body>
