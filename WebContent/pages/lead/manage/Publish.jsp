<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<script type="text/javascript">
    function check(){
        if (document.all('form1:stattime').value=="" ){
            alert("请选择时间!")
            return false;
        }
        if (document.all('form1:unitID').value=="" ){
            alert("请选择单位!")
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
        <h:outputText value=" 系统管理 ->   计算与发布"/>
        </h:panelGroup>
    </h:panelGrid>

    <c:verbatim>
    <br>
    <table  border="0" width="800" align="center" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="3" align="left">
            <strong>说明：</strong><br><br>
                     1、月度频率的素材计算后以统计时间为准形成当月数据，以前数据变为历史数据。<br>
                     2、统计时间为3、6、9、12时还要生成季度频率的素材。<br>
                     3、统计时间为6、12时还要生成半年频率的素材。<br>
                     4、统计时间为12时还要生成年频率的素材。 <br>
                     5、数据量大时，需要时间相对比较长，请稍候。<br>
            </td>
        </tr>
        <tr >
            <td height=40 valign="middle">
        </c:verbatim>
             <h:inputHidden id="unitID" value="#{lead_publishbb.unitID}"></h:inputHidden>
<c:verbatim>
             <strong>
             所属机构:
             </strong>
</c:verbatim>
    <h:inputText readonly="true" id="unitName" value="#{lead_publishbb.unitName}"></h:inputText>
<c:verbatim>

            <input onclick="fPopUpLeadUnitDlg2('form1:unitID','form1:unitName')" class="button_select"  type="button">
            </td>
            <td height=40 valign="middle"><strong>统计时间</strong>
 </c:verbatim>
                <h:inputText styleClass="input" id="stattime" value="#{lead_publishbb.statictime}"
                             readonly="true" alt="统计时间|1|d6|50||"/>
<c:verbatim>
                <input type="button" class="button_select" onclick="PopUpCalendarDlg_OnlyMonth('form1:stattime')">
            </td>
            <td height=40 valign="middle">
 </c:verbatim>
                <h:commandButton  styleClass="button01" value="开始计算" onclick="return check();" action ="#{lead_publishbb.saveDrawout}"/>
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
