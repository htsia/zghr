<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
    function check(){
        if (document.all('form1:stattime').value=="" ){
            alert("��ѡ��ʱ��!")
            return false;
        }
        if (document.all('form1:unitID').value=="" ){
            alert("��ѡ��λ!")
            return false;
        }
        showProcessBar();
        return true;
    }
    function showProcessBar() {
       x = document.body.clientWidth / 2 - 150;
       y = document.body.clientHeight / 2;
       document.all('processbar').style.top = y;
       document.all('processbar').style.left = x;
       document.all('processbar').style.display = "";
    }

</script>
<x:saveState value="#{lead_publishbb}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{lead_publishbb.pageInit}"></h:inputHidden>
    <h:panelGrid styleClass="td_title" width="100%" border="0" cellpadding="0" cellspacing="6" bgcolor="#FFFFFF" columns="2">
       <h:panelGroup>
        <h:graphicImage value="/images/tips.gif" />
        <h:outputText value=" ϵͳ���� ->   �����뷢��"/>
        </h:panelGroup>
    </h:panelGrid>

    <c:verbatim>
    <br>
    <table  border="0" width="800" align="center" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="3" align="left">
            <strong>˵����</strong><br><br>
                     1���¶�Ƶ�ʵ��زļ������ͳ��ʱ��Ϊ׼�γɵ������ݣ���ǰ���ݱ�Ϊ��ʷ���ݡ�<br>
                     2��ͳ��ʱ��Ϊ3��6��9��12ʱ��Ҫ���ɼ���Ƶ�ʵ��زġ�<br>
                     3��ͳ��ʱ��Ϊ6��12ʱ��Ҫ���ɰ���Ƶ�ʵ��زġ�<br>
                     4��ͳ��ʱ��Ϊ12ʱ��Ҫ������Ƶ�ʵ��زġ� <br>
                     5����������ʱ����Ҫʱ����ԱȽϳ������Ժ�<br>
            </td>
        </tr>
        <tr >
            <td height=40 valign="middle">
        </c:verbatim>
             <h:inputHidden id="unitID" value="#{lead_publishbb.unitID}"></h:inputHidden>
<c:verbatim>
             <strong>
             ��������:
             </strong>
</c:verbatim>
    <h:inputText readonly="true" id="unitName" value="#{lead_publishbb.unitName}"></h:inputText>
<c:verbatim>

            <input onclick="fPopUpLeadUnitDlg2('form1:unitID','form1:unitName')" class="button_select"  type="button">
            </td>
            <td height=40 valign="middle"><strong>ͳ��ʱ��</strong>
 </c:verbatim>
                <h:inputText styleClass="input" id="stattime" value="#{lead_publishbb.statictime}"
                             readonly="true" alt="ͳ��ʱ��|1|d6|50||"/>
<c:verbatim>
                <input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:stattime')">
            </td>
            <td height=40 valign="middle">
 </c:verbatim>
                <h:commandButton  styleClass="button01" value="��ʼ����" onclick="return check();" action ="#{lead_publishbb.saveDrawout}"/>
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
<marquee id="processbar" style="position:absolute;display:none;border:1px solid #000000" direction="right" width="300"
         scrollamount="5" scrolldelay="10"
         bgcolor="#ECF2FF">
    <table cellspacing="1" cellpadding="0">
        <tr height=8>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
            <td bgcolor=#3399FF width=8></td>
            <td></td>
        </tr>
    </table>
</marquee>
