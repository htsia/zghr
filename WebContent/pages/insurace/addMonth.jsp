<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
      response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
    <c:verbatim>
        <script type="text/javascript">
            function addMonth() {
                 PopUpCalendarDlg_OnlyMonth('form1:b735701');
                 if (document.all('form1:b735701').value!=""){
                     showProcessBar();
                     document.all('form1:addmonth').click();
                 }
             }
            function calePersoncountB735705() {
                    document.all('form1:calcB735705').click();
            }
            function showProcessBar() {
               x = document.body.clientWidth / 2 - 150;
               y = document.body.clientHeight / 2;
               document.all('processbar').style.top = y;
               document.all('processbar').style.left = x;
               document.all('processbar').style.display = "";
            }

        </script>
    </c:verbatim>

    <x:saveState value="#{ins_PersonCountBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{ins_PersonCountBB.pageInit}"/>
        <c:verbatim>
        <br>
        <table  align=center border=0 cellpadding=0 cellspacing=0 width=95% >
            <tr>
                <td width="90" class=td_form01>月份</td>
                <td  class=td_form02>
        </c:verbatim>
                    <h:inputText styleClass="input" id="b735701" value="#{ins_PersonCountBB.personcount.b735701}"
                                 alt="增加日期|0|s|50||"/>
                    <h:commandButton id="addmonth" style="display:none" value="刷新" action="#{ins_PersonCountBB.getInsuraceCount}" />
                    <h:commandButton id="calcB735705" style="display:none" value="刷新" action="#{ins_PersonCountBB.caleB735705}" />
        <c:verbatim>
                    <input type="button" class="button_select" onclick="addMonth();">
                </td>
           </tr>

            <tr>
                 <td width="90" class=td_form01>上月基数</td>
                 <td  class=td_form02>
</c:verbatim>
                        <h:inputText styleClass="input" id="b735702"   onchange="calePersoncountB735705();"
                                     value="#{ins_PersonCountBB.personcount.b735702}"
                                     alt="上月基数|1|s|50||"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                 <td width="90" class=td_form01>本月增加</td>
                 <td  class=td_form02>
</c:verbatim>
                        <h:inputText styleClass="input" id="b735703"  readonly="true"
                                     value="#{ins_PersonCountBB.personcount.b735703}"
                                     alt="本月增加|1|s|50||"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                 <td width="90" class=td_form01>本月减少</td>
                 <td  class=td_form02>
</c:verbatim>
                        <h:inputText styleClass="input" id="b735704"  readonly="true"
                                     value="#{ins_PersonCountBB.personcount.b735704}"
                                     alt="本月减少|1|s|50||"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                 <td width="90" class=td_form01>本月期末数</td>
                 <td  class=td_form02>
</c:verbatim>
                        <h:inputText styleClass="input" id="b735705"  readonly="true"
                                     value="#{ins_PersonCountBB.personcount.b735705}"
                                     alt="本月减少|1|s|50||"/>
<c:verbatim>
                </td>
            </tr>

            <tr>
                <td colspan=2 align="right">
</c:verbatim>
                    <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{ins_PersonCountBB.add}" />
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
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
            <td bgcolor=#3388FF width=9></td>
            <td></td>
        </tr>
    </table>
</marquee>
