<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.Vector" %>
<%@ include file="../include/taglib.jsp" %>

<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    Vector table = (Vector) request.getAttribute("list");
    String[]heads=(String [])request.getAttribute("heads");
    int maxlen = 0;
    try{
      maxlen=Integer.parseInt(request.getAttribute("collen").toString());//����еĳ���
    }
    catch(Exception e){
        
    }
%>

    <script type="text/javascript">
        function fnPreHandle(str)                         {
            var iCount;
            //���Ϊ���ٸ���
            var strData;
            //ԭʼ����
            var iMaxChars = 50000;
            //���ǵ�����Ϊ˫�ֽڣ��������ַ�������Ϊ50K
            var iBottleNeck = 2000000;
            //������³���2M�֣���Ҫ��ʾ�û�
            var strHTML;

            //ԭʼ����
            strData = str;
            //alert(strData);
            //alert(strData.length);
            iCount = parseInt(strData.length / iMaxChars) + 1;
            //hdnCount��¼ԭ��������Ϊ���ٸ�����
            strHTML = "<input type=hidden name=hdnCount value=" + iCount + ">";

            //���ɸ������HTML����
            for (var i = 1; i <= iCount; i++)
            {
                strHTML = strHTML + "\n" + "<input type='hidden' name='hdnBigField" + i + "'>";
            }
           // alert(strHTML);

            //��Form��DIV(divHidden)�ڶ�̬�����hidden���HTML����
            document.all.divHidden.innerHTML = strHTML;

            //��������ֵ
            for (var i = 1; i <= iCount; i++)
            {
                document.forms(0).elements["hdnBigField" + i].value = strData.substring((i - 1) * iMaxChars, i * iMaxChars);
            }
        }

        function forExport() {
            document.forms(0).target = "_blank";
            document.all("content").value = document.all("exporttable").innerHTML;
            document.forms(0).action = "/pages/common/ExpSheet.jsp";
            document.forms(0).submit();
        }
    </script>

    <input type="hidden" name="content" value="">
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right">
               <%
                   if (table!=null){
                        out.println("<input type='button' class='button01' value='����' onclick='forExport()'>");
                   }
                %>
            </td>
        </tr>
        <tr><td height=12></td></tr>
    </table>

<div id="exporttable">
<table width="95%" border="1" align="center" cellpadding="0" cellspacing="0" class="table03">
<tr class="td_form01" id="locked">
    <%
       if (heads!=null){
           for(int i=0;i<heads.length;i++){
               out.println("<td nowrap>"+heads[i]+"</td>");
           }
       }
    %>
</tr>
<tr class="td_form02">
    <%
      if (table!=null){
        for (int i = 0; i < table.size(); i++) {
            if (table.get(i) == null) {
    %>
    <td>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <%
                for (int j = 0; j < maxlen; j++) {
            %>
            <tr>
                <td height="22" nowrap>&nbsp;</td>
            </tr>
            <%
                }
            %>
            <tr>
                <td height="22" nowrap>0&nbsp;��</td>
            </tr>
        </table>
    </td>
    <%
        } else {
              PersonBO[] rec = (PersonBO[]) table.get(i);
              int reclen = rec.length;
    %>
    <td>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <%
                int spacelen = maxlen - reclen;//���еĳ���
                for (int j = 0; j < spacelen; j++) {
            %>
            <tr>
                <td height="22" nowrap>&nbsp;</td>
            </tr>
            <%
                }
                for (int j = 0; j < maxlen - spacelen; j++) {
                    if (rec[j].getBirth().equals("")) {
            %>
            <tr>
                <td height="22" nowrap><%=CommonFuns.filterNull(rec[j].getName())%></td>
            </tr>
            <%
                    } else {
                        String year = rec[j].getBirth().trim().substring(0, 4);
                        String mon = rec[j].getBirth().trim().substring(5, 7);
                        String day = rec[j].getBirth().trim().substring(8);
            %>
            <tr>
                <td height="22" nowrap><%=CommonFuns.filterNull(rec[j].getName())%>(<%=year%>-<%=mon%>-<%=day%>)</td>
            </tr>
            <%
                    }
                }
            %>
            <tr>
                <td height="22" nowrap><%=reclen%>��</td>
            </tr>
        </table>
    </td>
    <%
            }
        }
     }
    %>
</tr>
</table>
</div>

<script type="text/javascript">
    function setFix() {
        if (document.getElementById('exporttable') == null) return false;
        if (document.getElementById('datatable')  == null) return false;
        var itop = parseInt(document.getElementById('datatable').scrollTop - 2);
        var obj = document.all("locked");
        if (null != obj) {
            for (i = 0; i < obj.length; i++) {
                obj[i].style.position = "relative";
                obj[i].style.top = parseInt(itop);
            }
        }
    }
    window.setInterval("setFix()", 500);
    try {
        if (screen.width == 800 && screen.height == 600) {
            document.all("exporttable").style.pixelHeight = 280;
        }
    }
    catch(err) {
    }
</script>
