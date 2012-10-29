<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="com.hr319wg.sys.pojo.vo.TableVO" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.sys.pojo.vo.RecordVO" %>
<%@ page import="com.hr319wg.sys.pojo.vo.CellVO" %>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.util.CodeUtil" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.wage.ucc.IWageItemSetUCC" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.wage.pojo.bo.WageCostFieldBO" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%@ include file="/pages/include/taglib.jsp" %>

<script language=javascript src="/js/hashtable.js"></script>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    // ȡ�ñ�
    TableVO table = (TableVO) session.getAttribute(Constants.OBJECT);
    String pk=request.getParameter("ID");
    String setId=request.getParameter("setId");
    if (setId!=null && !"".equals(setId)){
        session.setAttribute("setId",setId);
    }
    else{
       setId=(String)session.getAttribute("setId");
    }
    int pos=0;
    if (request.getParameter("POS")!=null){
        pos=Integer.parseInt((String)request.getParameter("POS"));
    }
    else if (pk!=null && pk!=""){  // ��λ��ָ����Ա
        //pk = ((CellVO) rowdata.cellArray2Hash().get("ID")).getValue();
        RecordVO[] rows = table.getRowData();
        for(int j=0;j<rows.length;j++){
            String pid = ((CellVO) rows[j].cellArray2Hash().get("ID")).getValue();
            if (pid.equals(pk)){
                pos=j;
                break;
            }
        }
    }
    if (pos>=0){
        String pid = ((CellVO) table.getRowData()[pos].cellArray2Hash().get("ID")).getValue();
        session.setAttribute("RosterAddConditon"," A001.ID='"+pid+"' ");
    }
    int prePage=0;
    if (pos>0){
        prePage=pos-1;
    }
    int countPage=0;
    if (table!=null){
        countPage=table.getRowData().length;
    }
    int nextPage=countPage-1;
    if (pos<countPage-1){
        nextPage=pos+1;
    }
%>
<script language="javascript">
    var setId;
    <%
         out.print("   setId="+setId+";");
    %>
    function doPrint(){
         var url="/pages/report/ClientReportShow.jsp?RptCode="+document.all("ReportID").value+"&ID=&Parameter="+setId;
         window.open(url);
         return false;
     }
 </script>
<c:verbatim>
<table width="100%" align=center border=0 cellpadding=0 cellspacing=0>
    <tr>
        <td class="td_title">
            <img src="/images/tips.gif" alt=""> н�ʿ�Ƭ(<% out.print((pos+1)+"/"+countPage);%>)
        </td>
        <td  class="td_title">
</c:verbatim>
            <h:selectOneMenu id="reportID" value="#{wage_deptPrintBB.reportID}">
                <f:selectItems value="#{wage_deptPrintBB.cardRptList}"></f:selectItems>
            </h:selectOneMenu>
            <h:commandButton value="��ʾ" styleClass="button01" onclick="doPrint();" type="button"></h:commandButton>
<c:verbatim>
        </td>

        <td class="td_title" align="right">
            <a href="/wage/payoff/ShowCard.jsf?POS=0">��λ</a>
            <a href="/wage/payoff/ShowCard.jsf?POS=<%=prePage%>">��һ��</a>
            <a href="/wage/payoff/ShowCard.jsf?POS=<%=nextPage%>">��һ��</a>
            <a href="/wage/payoff/ShowCard.jsf?POS=<%out.print(countPage-1);%>">ĩλ</a>
            <input type="button" value="�ر�" class="button01" onclick="window.close()">
        </td>
    </tr>
</table>
</c:verbatim>
<%
    if (table != null) {
        RecordVO[] rsv = table.getRowData();
        CellVO[] row = null;
        RecordVO rowdata = null;
        //���TableVO���м�¼û�����ݣ����TableVO��ͷ������RecordVO
        if (rsv == null || rsv.length == 0) {
            rowdata = new RecordVO(table.getHeader());
        } else {
            rowdata = rsv[pos];
        }
        row = rowdata.getCell();

        out.println("<br><table width=95% align=center border=0 cellpadding=0 cellspacing=0 class='table03'>");
        //�����
        StringBuffer input = new StringBuffer();
        StringBuffer id = new StringBuffer();
        StringBuffer value = new StringBuffer();
        String itemId = null;
        String itemName = null;
        String cellRight = "";
        String cellType = "";
        String property = null;
        String maskValue = null;
        String realValue = null;
        String datatype = null;

        // ��ָ�����ѭ��
        int colnum = row.length;
        Hashtable fieldHash = new Hashtable();
        IWageItemSetUCC wageitemsetucc = (IWageItemSetUCC) SysContext.getBean("wage_wageItemSetUccImpl");
        for (int j = 0; j < colnum; j++) {
            CellVO cell = row[j];
            String costtype="System";
            if (cell.getItemId().startsWith("A815")){
                 WageCostFieldBO bo = wageitemsetucc.findWageItemSet(cell.getItemId(), String.valueOf(WageCostFieldBO.TYPE_POST));
                 if (bo!=null && bo.getCostType()!=null)    costtype=bo.getCostType();
            }
            if (fieldHash.get(costtype) == null) {
                ArrayList al = new ArrayList();
                al.add(cell);
                fieldHash.put(costtype, al);
            } else {
                ArrayList al = (ArrayList) fieldHash.get(costtype);
                al.add(cell);
                fieldHash.put(costtype, al);
            }
        }
        // ������Ϣ������ͷ��
        String []typearray=new String[fieldHash.size()];
        int index=0;
        typearray[index]="System";
        Iterator it = fieldHash.keySet().iterator();
        while(it.hasNext()){
           String setkey=it.next().toString();
           if (!"System".equals(setkey)){
               index++;
               typearray[index]=setkey;
           }
        }
        for(int k=0;k<typearray.length;k++){
            ArrayList cells = (ArrayList)fieldHash.get(typearray[k]);
            out.print("<tr><td colspan=4 align='center' bgcolor=\"#2074C5\"><font color='white'>");
            if ("System".equals(typearray[k])){
                out.print("������Ϣ");
            }
            else{
                out.print(CodeUtil.interpertCode("0280",typearray[k]));
            }
            out.println("<font></td><tr>");
            int count = 0;
            for(int j=0;j<cells.size();j++){
                CellVO cell=(CellVO)cells.get(j);
                cellType = cell.getItemDataType();//ָ�����������
                property = cell.getItemProperty();//ָ�������
                itemId = CommonFuns.filterNull(cell.getItemId());//ָ������ݿ����
                itemName = CommonFuns.filterNull(cell.getItemName());//ָ�����������
                maskValue = CommonFuns.filterNull(cell.getValue());//ָ���ֵ

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

                cellRight = " readonly ";
                operRight = "disabled";

                //ָ��ĳ���
                String length = cell.getItemDataLength();
                if (length == null || "".equals(length)) {
                    if (InfoItemBO.DATA_TYPE_REMARK.equals(cellType)) {
                        length = "1000";
                    } else if (InfoItemBO.DATA_TYPE_STRING.equals(cellType)) {
                        length = "100";
                    }
                }

                String tdclass = "td_form02";
                String tdfontclass = "td_form01";
                String notNull = CommonFuns.filterNull(cell.getItemNotNull());
                if ("1".equals(notNull)) {
                    notNull = "0";
                    // tdclass = "td_form_required";
                    tdfontclass = "td_form01 td_form_required";
                } else {
                    notNull = "1";
                }

                id.delete(0, id.length());
                id.append(" id=\"").append(cell.getItemId()).append("\"");


                value.delete(0, value.length());
                value.append(" value=\"").append(maskValue).append("\"");

                //ָ���Ӧ�ı�����javascript����
                //����ָ��
                if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(property)) {
                    out.print("<input " + id.toString() + " "
                            + " name=\"" + cell.getItemId()
                            + "\" type=\"hidden\" class=\"input\" value='" + CommonFuns.filterNull(realValue) + "'>");
                } else {

                // ÿ������
                if (count % 2 == 0) {
                    out.println("<tr nowrap>");
                }
                input.delete(0, input.length());

                if (InfoItemBO.DATA_TYPE_CODE.equals(cellType)) {//������ָ�괦��
                    if ("1".equals(cell.getItemIsSelect())) {
                        out.println("<td class='" + tdfontclass + "' width=160 align=left>" + itemName + "</td>");
                        out.print("<td class=" + tdclass + "  >");
                        out.println("<select name=" + itemId + " style='width:140'   " + cellRight + ">");
                        if ("readonly".equals(cellRight)) {   //�����ֻ����
                            if ("".equals(CommonFuns.filterNull(realValue))) {
                                out.println("<option  value=\"\">---��ѡ��---</option>");
                            } else {
                                out.println("<option  value=" + realValue + ">" + value + "</option>");
                            }

                        } else { //�ɱ༭��
                            List list = SysCacheTool.queryCodeItemBySetId(cell.getItemCodeSet());
                            out.println("<option  value=\"\">---��ѡ��---</option>");
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
                    } else { // ����ָ��
                        input.append("<input name=\"")
                                .append(itemId).append("\"")
                                .append(" type=\"text\" style=\"behavior:url('/js/mytextbox.htc');\" class=\"input\" ")
                                .append(cellRight)
                                .append(id)
                                .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                                .append(" code=\"").append(realValue).append("\" ")
                                .append(value)
                                .append(">");

                        out.println("<td class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                        out.print("<td class=" + tdclass + "  >");
                        out.print(input.toString());
                    }
                    out.println(msg);
                    out.println("</td>");

                } else if (InfoItemBO.DATA_TYPE_POST.equals(cellType)) {//��λ��ָ��Ĵ���
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                            .append(" code=\"").append(realValue).append("\" ")
                            .append(value)
                            .append(">");
                    out.println("<td class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                    out.print("<td class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_COMPUTE.equals(cellType)) {//������ָ��
                    input.append("<input  name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_DATE.equals(cellType)) {//������ָ��
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "' width=160 align=left>" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_DATE6.equals(cellType)) {//��λ������ָ��
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else
                if (InfoItemBO.DATA_TYPE_FLOAT.equals(cellType) || InfoItemBO.DATA_TYPE_INT.equals(cellType)) {//��ֵ��
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" ")
                            .append(cellRight)
                            .append(id)
                            .append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_ORG.equals(cellType)) { //������ָ��
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(cellRight)
                            .append(id)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append("OU").append("\"")
                            .append(" code=\"").append(realValue).append("\" ").append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_WAGE.equals(cellType)) { //��н������ָ��
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(cellRight)
                            .append(id)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append("WA").append("\"")
                            .append(" code=\"").append(realValue).append("\" ").append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_WAGEDEPT.equals(cellType)) { //��н������ָ��
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(cellRight)
                            .append(id)
                            .append(" readOnly ").append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_PARTY.equals(cellType)) { //����ָ֯��
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\"")
                            .append(cellRight)
                            .append(id)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append("PA").append("\"")
                            .append(" code=\"").append(realValue).append("\" ").append(value)
                            .append(">");
                    out.println("<td  class='" + tdfontclass + "'    width=160 align=left>" + itemName + "</td>");
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
                    input.append("<textarea name=\"")
                            .append(itemId).append("\"")
                            .append(" cols=\"80\" rows=\"3\" ")
                            .append(cellRight)
                            .append(id)
                            .append(">")
                            .append(maskValue)
                            .append("</textarea>");
                    out.println("<td  class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + " colspan=\"3\">");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                    out.println("</tr>");
                    out.println("<tr nowrap>");
                } else if (InfoItemBO.DATA_TYPE_STRING.equals(cellType)) { //�ַ���ָ��
                    if ("A001077".equals(itemId)) {
                        input.append("<input name=\"")
                                .append(itemId).append("\"")
                                .append(" type=\"text\" class=\"input\" ")
                                .append(cellRight)
                                .append(id)
                                .append(value)
                                .append(" size='22'>");
                    } else {
                        input.append("<input name=\"")
                                .append(itemId).append("\"")
                                .append(" type=\"text\" class=\"input\" ")
                                .append(cellRight)
                                .append(id)
                                .append(value)
                                .append(">");
                    }
                    out.println("<td class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
                    out.print("<td  class=" + tdclass + "  >");
                    out.print(input.toString());
                    out.println(msg);
                    out.println("</td>");
                } else if (InfoItemBO.DATA_TYPE_PERSON.equals(cellType)) { //��Ա��ָ��
                    input.append("<input name=\"")
                            .append(itemId).append("\"")
                            .append(" type=\"text\" class=\"input\" readOnly")
                            .append(id)
                            .append(" dict=\"yes\"").append(" dict_num=\"").append(CommonFuns.filterNull(cell.getItemCodeSet())).append("\"")
                            .append(" code=\"").append(realValue).append("\" ")
                            .append(value)
                            .append(">");
                    out.println("<td class='" + tdfontclass + "'  width=160 align=left>" + itemName + "</td>");
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
        }
        out.println("</table><br>");
        //�޸�parentҳ�����
        out.println("<script language=\"javascript\">");
        out.println("</script >");
    }
%>
<script language=javascript>
    function selPost(idf, org) {
        obj = document.all(org);
        if (obj.value == null || obj.value == "") {
            alert("��ѡ��λʱ�����Ų���Ϊ��");
            return;
        }
        var arg = parent.CSApp;
        fPopUpPostDlgByOrg(idf, obj.code, arg);
    }
    function selPostNo(idf) {
        var arg = parent.CSApp;
        fPopUpPostDlg(idf, arg);
    }
</script>
<!--ָ�����-->
<script type="text/javascript">
    //more javascript from http://www.smallrain.net
    <!--
    var pltsPop = null;
    var pltsoffsetX = 10;   // ��������λ������������Ҳ�ľ��룻3-12 ����
    var pltsoffsetY = 15;  // ��������λ������·��ľ��룻3-12 ����
    var pltsPopbg = "#FFFFEE"; //����ɫ
    var pltsPopfg = "#111111"; //ǰ��ɫ
    var pltsTitle = "";
    document.write('<div id=pltsTipLayer style="display: none;position: absolute; z-index:10001"></div>');
    function pltsinits()
    {
        document.onmouseover = plts;
        document.onmousemove = moveToMouseLoc;
    }
    function plts()
    {
        var o = event.srcElement;
        if (o.title != null && o.title != "") {
            o.dypop = o.title;
            o.title = ""
        }
        ;
        pltsPop = o.dypop;
        if (pltsPop != null && pltsPop != "" && typeof(pltsPop) != "undefined")
        {
            pltsTipLayer.style.left = -1000;
            pltsTipLayer.style.display = '';
            var Msg = pltsPop.replace(/\n/g, "<br>");
            Msg = Msg.replace(/\0x13/g, "<br>");
            var re = /\{(.[^\{]*)\}/ig;
            if (!re.test(Msg))pltsTitle = "<font color=#ffffff>ָ�����</font>";
            else {
                re = /\{(.[^\{]*)\}(.*)/ig;
                pltsTitle = Msg.replace(re, "$1") + " ";
                re = /\{(.[^\{]*)\}/ig;
                Msg = Msg.replace(re, "");
                Msg = Msg.replace("<br>", "");
            }
            var attr = (document.location.toString().toLowerCase().indexOf("list.asp") > 0?"nowrap":"");
            var content =
                    '<table style="FILTER:alpha(opacity=100) shadow(color=#bbbbbb,direction=135);" id=toolTipTalbe border=0><tr><td><table  cellspacing="1" cellpadding="0" style="width:100%;background-color: #1e4e62">' +
                    '<tr id=pltsPoptop ><th height=18 valign=bottom class=th1 ><b><p id=topleft align=left><font color=#ffffff>�I</font>' + pltsTitle + '</p><p id=topright align=right style="display:none">' + pltsTitle + '<font color=#ffffff>�J</font></b></th></tr>' +
                    '<tr><td "+attr+" class=tablebody7 style="padding-left:14px;padding-right:14px;padding-top: 6px;padding-bottom:6px;line-height:135%">' + Msg + '</td></tr>' +
                    '<tr id=pltsPopbot style="display:none"><th height=18 valign=bottom class=th1><b><p id=botleft>' + pltsTitle + '</p><p id=botright align=right style="display:none">' + pltsTitle + '<font color=#ffffff>�K</font></b></th></tr>' +
                    '</table></td></tr></table>';
            pltsTipLayer.innerHTML = content;
            toolTipTalbe.style.width = Math.min(pltsTipLayer.clientWidth, document.body.clientWidth / 2.2);
            moveToMouseLoc();
            return true;
        }
        else
        {
            pltsTipLayer.innerHTML = '';
            pltsTipLayer.style.display = 'none';
            return true;
        }
    }

    function moveToMouseLoc()
    {
        if (pltsTipLayer.innerHTML == '')return true;
        var MouseX = event.x;
        var MouseY = event.y;
        //window.status=event.y;
        var popHeight = pltsTipLayer.clientHeight;
        var popWidth = pltsTipLayer.clientWidth;
        if (MouseY + pltsoffsetY + popHeight > document.body.clientHeight)
        {
            popTopAdjust = -popHeight - pltsoffsetY * 1.5;
            pltsPoptop.style.display = "none";
            pltsPopbot.style.display = "";
        }
        else
        {
            popTopAdjust = 0;
            pltsPoptop.style.display = "";
            pltsPopbot.style.display = "none";
        }
        if (MouseX + pltsoffsetX + popWidth > document.body.clientWidth)
        {
            popLeftAdjust = -popWidth - pltsoffsetX * 2;
            topleft.style.display = "none";
            botleft.style.display = "none";
            topright.style.display = "";
            botright.style.display = "";
        }
        else
        {
            popLeftAdjust = 0;
            topleft.style.display = "";
            botleft.style.display = "";
            topright.style.display = "none";
            botright.style.display = "none";
        }
        pltsTipLayer.style.left = MouseX + pltsoffsetX + document.body.scrollLeft + popLeftAdjust;
        pltsTipLayer.style.top = MouseY + pltsoffsetY + document.body.scrollTop + popTopAdjust;
        return true;
    }
    pltsinits();

    //-->
</script>
