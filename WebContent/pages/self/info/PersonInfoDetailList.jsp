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

        //��ά���������鿴���ȶ��б�ĳ�н��д����չʾ��
        String[] editColName = null;
        String[] editName = null;
        //��ά���������鿴���ȶ��б�ĳ�н��д����javascript����������forView()
        String[] editFuncName = null;

        //�Ƿ������Ȩ��
        boolean isCheckRight = false;
        //�Ƿ��ҳ
        boolean isPage = false;

        //�Ƿ�༭�б�
        boolean isEditList = true;
        //�б�ҳ���Ƿ����
        boolean isScroll = true;

        //��request��õ�TableVO,��ֵrequest.getAttribute(tableId)
        String tableId = request.getParameter("target");
        if (tableId == null || "".equals(tableId.trim())) {
            tableId = Constants.OBJECT_DETAIL;
        }

        //��request�õ�TableVO
        TableVO table = (TableVO) request.getAttribute(tableId);
        //���request��û�У����session��ȡ
        if (table == null) {
            table = (TableVO) session.getAttribute(tableId);
        }

        //������Ӧ���ֶ���
        String keyName = request.getParameter("keyName");

        if (table != null) {
            //�õ��б��ͷ��
            CellVO[] header = table.getHeader();
            //�õ��б�ļ�¼
            RecordVO[] rows = table.getRowData();
            //�б������
            int colnum = header.length;
            //�б�ļ�¼��
            int rownum = rows.length;
            String divId = "";
            //��������б�ҳ������Ļ�������б�λ��div����һ��idֵ
            if (isScroll) {
                divId = "id=datatable";
            }
            out.println("<div " + divId + " style='height:100%;width:100%'>");

            //����Ȩ���趨����
            int tableright = table.getPermission();

            if (tableright == TableVO.PERMISSON_WRITE) {
                out.println("<table width=95% align=center>");
                out.println("<tr><td align='right'><input type='button' class='button01' value='�ύ�������' onclick=\"forAdd('"+table.getSetId()+"')\"><input type='button' value='�޸���ʷ��¼' class='button01' onclick=\"showChkList('"+fk+"')\"></td></tr>");
                out.println("</table>");

                editColName=new String[1];
                editColName[0]="����";

                editName=new String[1];
                editName[0]="�ύ�޸�����";

                editFuncName=new String[1];
                editFuncName[0]="ModiInfo";
            }
            else{
                out.println("<br>");
            }
            out.println("<table width=95% border=0 cellpadding=0 cellspacing=0 align=center class='table03' id='list'>");

            //draw header ���б�ҳ���ͷ����ռ����һ��
            String trFubc = "";

            out.println("<tr> ");
            //�������༭�Ļ������б�ά������,��ǰ��
            if (editColName != null && editColName.length > 0) {
                for (int e = 0; e < editColName.length; e++) {
                    out.println("<td id=\"locked\"  class=locked_top align=center nowrap>");
                    out.println(editColName[e]);
                    out.println("</td>");
                }
            }
            //��ͷ������
            for (int i = 0; i < colnum; i++) {
                if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[i].getItemProperty()) || InfoItemBO.DATA_TYPE_CLOB.equals(header[i].getItemDataType())) {
                    continue;
                } else {
                    if (header[i].isShowId()) {
                        if (InfoItemBO.DATA_TYPE_CODE.equals(header[i].getItemDataType())) {
                            out.println("<td id=\"locked\"  class=locked_top nowrap >" + header[i].getItemName() + "����</td>");
                        }
                        out.println("<td id=\"locked\"  class=locked_top nowrap >" + header[i].getItemName() + "</td>");
                    } else {
                        out.println("<td id=\"locked\"  class=locked_top nowrap >" + header[i].getItemName() + "</td>");
                    }
                }
            }
            out.println("</tr> ");

            //�Ȱ���ѭ��
            // ��������
            if (keyName == null || "".equals(keyName)) {
                if (table.getSetId() != null && !"".equals(table.getSetId())) {
                    keyName = table.getSetPk();//�Ӽ�������
                } else if (rownum > 0) {
                    String setType = rows[0].getCell()[0].getSetId().substring(0, 1);//�Ӽ���A�໹��B��
                    keyName = InfoSetBO.getPkType(setType);
                }
            }

            for (int i = 0; i < rownum; i++) {
                RecordVO row = rows[i]; //�õ�ĳһ��
                out.println("<tr onclick=" + trFubc + ">");
                String rowId = "[" + i + "]";
                if (rownum == 1) {
                    rowId = "";
                }

                String backValue = "";
                // �ٰ���
                for (int j = 0; j < colnum; j++) {
                    Hashtable tmphash = row.cellArray2Hash();//�õ�ĳ��
                    CellVO cell = row.getCell()[j];
                    int right = cell.getPermission();//ָ���Ȩ��

                    String idValue = "";

                    //�õ�������ֵ
                    idValue = ((CellVO) tmphash.get(keyName)).getValue();
                    backValue = ((CellVO) tmphash.get(keyName)).getValue();

                    //�õ���һ�е�ֵ
                    String value = CommonFuns.filterNull(cell.getValue());
                    switch (right) {
                        case 1:
                            value = "*****";
                            break;
                        case 2:
                        case 3:
                            break;
                    }

                    //��һ�л�checkBox����radioButton ����ά������
                    if (j == 0) {
                        //��ά����������ǰ��
                        if (editName != null && editName.length > 0) {
                            for (int e = 0; e < editName.length; e++) {
                                out.println("<td align=center class=td_middle nowrap>");
                                String oper = editFuncName[e] + "('"+table.getSetId()+"','"+idValue+"')";
                                out.println("<input type='button' class='button01' onclick=\"return " + oper + "\" value='"+editName[e]+"'>");
                                out.println("</td>");
                            }
                        }
                    }

                    //����������б�ҳ��༭
                    //������༭�б�
                    String func = "";
                    String styleEvent = "onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)";
                    String align = "";
                    // ��ֵ�Ͳ����Ҷ���
                    if (InfoItemBO.DATA_TYPE_FLOAT.equals(cell.getItemDataType()) || InfoItemBO.DATA_TYPE_INT.equals(cell.getItemDataType())) {
                        align = "align=right";
                    }
                    if (!InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[j].getItemProperty())) {
                        if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType())) {
                            if (cell.isShowId()) {   //�߼���ѯʹ��
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
                            if (cell.isShowId()) { //�߼���ѯʹ��
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
                        else if (InfoItemBO.DATA_TYPE_IMAG.equals(cell.getItemDataType())) {   // ͼƬ
                            out.println("<td class=td_middle"  + align + " nowrap  " + styleEvent + " onclick='return viewPhotoField(\""+value+"\",\""+cell.getItemId()+"\",\""+idValue+"\")'>�鿴ͼƬ</td>");
                        }
                        else if ("A815712".equals(cell.getItemId())) {  //ʵ������(A815712)
                            if (value.indexOf("-") >= 0) {  // ��ֵ
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + "<img src='/images/common/unvalidate.gif'><font color='red'>" + value + "&nbsp;</font></td>");
                            } else {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                            }
                        } else if ("A001001".equals(cell.getItemId())) {  //A001735	A001	Ա�����
                            if (idValue.startsWith("@")) {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\"><font color=red>" + value + "(��ְ)" + "</font>&nbsp;</td>");
                            } else if (idValue.startsWith("#")) {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\"><font color=red>" + value + "(����)" + "</font>&nbsp;</td>");
                            } else {
                                out.println("<td class=td_middle " + align + " nowrap  " + styleEvent + "  onclick=\"javascript:" + func + "\">" + value + "&nbsp;</td>");
                            }
                        } else if (InfoItemBO.DATA_TYPE_WAGEDEPT.equals(cell.getItemDataType())) {  //A001743	A001	н�ʲ���
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
            // ������
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
