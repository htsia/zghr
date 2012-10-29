<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoSetBO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.common.ucc.impl.AttachmentUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.user.pojo.bo.SelfInfoPowerBO" %>
<%
    //------------------------------  ��ͼ¼��ҳ�� ---------------------------------
    //�Ƿ�鿴
    String tableId = request.getParameter("tableId");
    if (tableId == null || "".equals(tableId.trim())) {
        tableId = Constants.OBJECT_DETAIL;
    }
    TableVO table = (TableVO) request.getAttribute(tableId);
    if (table == null)
        table = (TableVO) session.getAttribute(tableId);

    String setId = CommonFuns.filterNull(request.getParameter("setId"));
    String fk = CommonFuns.filterNull(request.getParameter("fk"));
    String pk = request.getParameter("pk");
    String zpphoto = "display:none";
    String sfzphoto = "display:none";
    String imageValue = "";
    String zpValue = "";
    String sfzValue = "";
    if (table != null) {
        int tableright = table.getPermission();

        String tableRt = "";
        switch (tableright) {
            case TableVO.PERMISSON_READ://����Ȩ��
                tableRt = "disabled";
                break;
            case TableVO.PERMISSON_WRITE://д��Ȩ��
                tableRt = "";
                break;
        }

        //1:1 ��
        RecordVO[] rsv = table.getRowData();
        CellVO[] row = null;
        //���TableVO���м�¼û�����ݣ����TableVO��ͷ������RecordVO
        if (rsv == null || rsv.length == 0) {
            rsv = new RecordVO[1];
            rsv[0] = new RecordVO(table.getHeader());
            table.setRowData(rsv);
        }
        row = rsv[0].getCell();
        int colnum = row.length;
        int count = 0;
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

        //�޸Ĳ���
        RecordVO[] rows = table.getRowData();

        String rsType = table.getSet_rsType();

        if (InfoSetBO.RS_TYPE_SINGLE.equals(rsType)) {   //�Ӽ��ǵ���¼
            pk = ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).getValue();
            if (pk == null) {
                ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).setValue(fk);
                pk = fk;
            } else {
                fk = pk;
            }
        } else {                                                 //�Ӽ��Ƕ��¼
            pk = ((CellVO) rows[0].cellArray2Hash().get(table.getSetPk())).getValue();
        }

        if (tableright == TableVO.PERMISSON_REFUSE) {
            //�ܾ���Ȩ��
            out.println("<font color=#0033CC>�Բ�����û��Ȩ�޲鿴��ָ�꼯��</font>");
            return;
        }
        if (tableright == TableVO.PERMISSON_WRITE) {
            out.println("<table width=95% align=center>");
            out.println("<tr><td align='left'><input type='button' class='button01' value='�����޸�' onclick=\"ModiInfo('" + setId + "','" + pk + "')\"><input type='button' class='button01' value='�����޸�' onclick=\"BatchModiInfo('" + setId + "','" + pk + "')\"><input type='button' value='�޸���ʷ��¼' class='button01' onclick=\"showChkList('"+pk+"')\">");

            CellVO zpCell =null;
            for(int j=0;j<table.getHeader().length;j++){
                if ("A001780".equals(table.getHeader()[j].getItemId())) {
                    zpCell=table.getHeader()[j];
                    break;
                }
            }
            if (zpCell!=null && zpCell.getPermission() == Integer.parseInt(SelfInfoPowerBO.PERMISSION_WRITE)){
               out.print("<input type='button' class='button01' value='������Ƭ' onclick='forSavePhoto();'>");
            }
            out.println("</td></tr>");
            out.println("</table>");
        }

        out.println("<br><table width=95% align=center border=0 cellpadding=0 cellspacing=0 class='table03'>");
        //�����

        // ��ָ�����ѭ��
        for (int j = 0; j < colnum; j++) {
            CellVO cell = row[j];
            cellType = cell.getItemDataType();//ָ�����������
            property = cell.getItemProperty();//ָ�������
            itemId = CommonFuns.filterNull(cell.getItemId());//ָ������ݿ����
            itemName = CommonFuns.filterNull(cell.getItemName());//ָ�����������
            maskValue = CommonFuns.filterNull(cell.getValue());//ָ���ֵ

            if (InfoItemBO.DATA_TYPE_IMAG.equals(cell.getItemDataType())) {
                imageValue = maskValue;
            }
            if ("A001780".equals(cell.getItemId())) {
                zpValue = maskValue;
                if (zpValue != null && !"".equals(zpValue)) {
                    zpphoto = "";  //��ʾ��Ƭ
                    //����Ƭ���ݴ����ݿ���ȡ������
                    try {
                        AttachmentUCC aucc = (AttachmentUCC) SysContext.getBean("common_attachmentUCC");
                        String basepath = application.getRealPath("/");
                        if (!aucc.checkAttachFileExist(basepath, zpValue)) {
                            aucc.getFileContentToFile(basepath, zpValue);
                        }
                    }
                    catch (Exception e) {

                    }
                }
            }
            if ("A001786".equals(cell.getItemId())) {
                sfzValue = maskValue;
                if (sfzValue != null && !"".equals(sfzValue)) {
                    sfzphoto = "";  //��ʾ��Ƭ
                    //����Ƭ���ݴ����ݿ���ȡ������
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
            formula = " formula='" + CommonFuns.filterNull(cell.getItemFormula()) + "' ";//ָ���Ӧ��Ҫ���õ�javascript����
            if (cell.getValue() == null) {
                maskValue = CommonFuns.filterNull(cell.getItemDefaultValue());
            }
            realValue = maskValue;

            if (InfoItemBO.DATA_TYPE_ORG.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, maskValue);  //���������ָ��
            } else if (InfoItemBO.DATA_TYPE_CODE.equals(cell.getItemDataType())) {
                if (maskValue != null && !"".equals(maskValue)) {
                    maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_CODE, maskValue);//���������ָ��
                }
            } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_PERSON, maskValue);  //������Ա��ָ��
            } else if (InfoItemBO.DATA_TYPE_POST.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_POST, maskValue);//�����λ��ָ��
            } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_PARTY, maskValue);//���뵳��֯��ָ��
            } else if (InfoItemBO.DATA_TYPE_WAGE.equals(cell.getItemDataType())) {
                maskValue = CodeUtil.interpertCode(CodeUtil.TYPE_ORG, maskValue); //���뷢н����
            }

            String msg = " <font color=red>" + CommonFuns.filterNull(cell.getItemDesc()) + "</font>";//ָ���ע��
            String nextType = "";
            String operRight = "";

            //ָ��Ĳ�ͬȨ�ޣ���ҳ�治ͬ��ʾ(���ء�ֻ������д)
            cellRight = " readonly ";
            operRight = "disabled";
            check.delete(0, check.length());//ָ���У�飨�ǿա����֡����ڵȣ�
            //ָ��ĳ���
            String length = cell.getItemDataLength();
            if (length == null || "".equals(length)) {
                if (InfoItemBO.DATA_TYPE_REMARK.equals(cellType)) {
                    length = "1000";
                } else if (InfoItemBO.DATA_TYPE_STRING.equals(cellType)) {
                    length = "100";
                }
            }
            //ָ���У�飨�ǿա����֡����ڵȣ�
            String tdclass = "td_form02";
            String tdfontclass = "td_form01";
            String notNull = CommonFuns.filterNull(cell.getItemNotNull());
            if ("1".equals(notNull)) {
                notNull = "0";
                tdfontclass = "td_form01";
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
            //ָ���Ӧ�ı�����javascript����
            String event = " ";

            if (j < colnum - 1) {
                nextType = row[j + 1].getItemDataType();
                next.append(row[j + 1].getItemId()).append("\"");
            } else if (j == colnum - 1) {
                next.append("\"");
            }

            //����ָ��
            if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(property)) {
                out.print("<input " + id.toString() + " "
                        + next.toString()
                        + " name=\"" + cell.getItemId()
                        + "\" type=\"hidden\" class=\"input\" value='" + CommonFuns.filterNull(realValue) + "'>");
            } else {
                // ÿ������
                if (count % 2 == 0) {
                    out.println("<tr nowrap>");
                }
                input.delete(0, input.length());
                //clob���͵�ָ��,��Ƭ
                if (InfoItemBO.DATA_TYPE_IMAG.equals(cellType)) {
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
                    if (cell.getPermission() == Integer.parseInt(SelfInfoPowerBO.PERMISSION_WRITE)) {
                        out.print("<iframe name=" + itemId + " frameBorder=0 width=\"100%\" height=22 scrolling=no src='/common/UploadPhoto.jsf?pk="+pk+"&imageItemId=" + itemId + "&imageId=" + imageValue + "'></iframe>");
                    } else {
                        out.println("<a href='/pages/common/photo.jsp?id=" + imageValue + "' target='_blank'>�鿴</a>");
                    }
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_CODE.equals(cellType)) {//������ָ�괦��
                        input.append(maskValue);
                        out.println("<td class='" + tdfontclass + "'  >" + itemName + "</td>");
                        out.print("<td class=" + tdclass + "  >");
                        out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_POST.equals(cellType)) {//��λ��ָ��Ĵ���
                    input.append(maskValue);
                    out.println("<td class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_COMPUTE.equals(cellType)) {//������ָ��
                    input.append(maskValue);
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_DATE.equals(cellType)) {//������ָ��
                    input.append(maskValue);
                    out.println("<td  class='" + tdfontclass + "' >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_DATE6.equals(cellType)) {//��λ������ָ��
                    input.append(maskValue);
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else
                if (InfoItemBO.DATA_TYPE_FLOAT.equals(cellType) || InfoItemBO.DATA_TYPE_INT.equals(cellType)) {//��ֵ��
                    input.append(maskValue);
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_ORG.equals(cellType)) { //������ָ��
                    input.append(maskValue);
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_WAGE.equals(cellType)) { //��н������ָ��
                    input.append(maskValue);
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_WAGEDEPT.equals(cellType)) { //��н������ָ��
                    input.append(maskValue);
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cellType)) { //����ָ֯��
                    input.append(maskValue);
                    out.println("<td  class='" + tdfontclass + "'    >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_REMARK.equals(cellType)) { //��ע��ָ��
                    // ȷ����ע���ֶε���һ��
                    if (count % 2 == 1) {
                        out.println("</tr>");
                        out.println("<tr nowrap>");
                    }
                    input.append(maskValue);
                    out.println("<td  class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + " colspan=\"3\">");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                    out.println("</tr>");
                    out.println("<tr nowrap>");
                } else if (InfoItemBO.DATA_TYPE_STRING.equals(cellType)) { //�ַ���ָ��
                    input.append(maskValue);
                    out.println("<td class='" + tdfontclass + "'  >" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cellType)) { //��Ա��ָ��
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
        out.println("<input type=hidden name=fk value='" + CommonFuns.filterNull(fk) + "'>");
        out.println("<input type=hidden name=setId value='" + CommonFuns.filterNull(setId) + "'>");
        out.println("<input type=hidden name=pk value='" + CommonFuns.filterNull(pk) + "'>");
    }
%>
<div id=seryFilterDiv onMouseDown="catchFilter()" onMouseUp="releaseFilter()"
     style="cursor:move;position:absolute;z-index:0;left:650px;top:0px;<%=zpphoto%>;">
    <img id=showZP src="/file/tmp/<%=zpValue%>.jpg" width=<%=Constants.PHOTOWIDTH%> height=<%=Constants.PHOTOHEIGHT%> alt="��Ƭ">
</div>
<div id=seryFilterDiv2 onMouseDown="catchFilter2()" onMouseUp="releaseFilter2()"
     style="cursor:move;position:absolute;z-index:0;left:650px;top:<%=Constants.PHOTOHEIGHT%>px;<%=sfzphoto%>;">
    <img id=showSFZ src="/file/tmp/<%=sfzValue%>.jpg" width=<%=Constants.IDWIDTH%> height=<%=Constants.IDHEIGHT%> alt="���֤">
</div>
<div id=seryFilterDiv3 onMouseDown="catchFilter3()" onMouseUp="releaseFilter3()"
     style="cursor:move;position:absolute;z-index:0;left:650px;top:140px;display:none">
    <TEXTAREA id="imgText" name="imgText" rows=3 cols=30>
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
    document.all.seryFilterDiv.style.left = document.body.scrollWidth - 120;
    document.all.seryFilterDiv2.style.left = document.body.scrollWidth - 120;
    var bIsCatchSery = false;
    var dragClickX = 0;
    var dragClickY = 0;

    var bIsCatchSery2 = false;
    var dragClickX2 = 0;
    var dragClickY2 = 0;

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
</script>
<script language=javascript src="/pages/common/activepage/ActiveDetail.js"></script>

