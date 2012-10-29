<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
      <script type="text/javascript">
         function forEdit(){
             var ID=getFirstSelectValue(form1.chk);
             if (ID==null || ID==""){
                 alert("请先选择修改项目！");
                 return false;
             }                       
             window.showModalDialog("/org/info/EditOrgInfoDetail.jsf?setId="+document.all('form1:selectSet').value+"&flag=2&fk="+document.all('form1:unitId').value+"&pk="+ID, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
             return true;
         }
         function forGroup(){
             var ID=getFirstSelectValue(form1.chk);
             if (ID==null || ID==""){
                 alert("请先选择汇总时间！");
                 return false;
             }
             document.all('form1:selectID').value=ID;
             showProcessBar();
             return true;
         }

         function showProcessBar() {
            x = document.body.clientWidth / 2 - 150;
            y = document.body.clientHeight / 2;
            document.all('processbar').style.top = y;
            document.all('processbar').style.left = x;
            document.all('processbar').style.display = "";
            return true;
         }
      </script>

  <x:saveState value="#{wage_OrgSumItemShowBB}"/>
  <h:form id="form1">
  <h:inputHidden value="#{wage_OrgSumItemShowBB.pageInit}"/>
  <h:inputHidden id="unitId" value="#{wage_OrgSumItemShowBB.unitId}"/>
  <h:inputHidden id="dateId" value="#{wage_OrgSumItemShowBB.dateId}"/>
  <h:inputHidden id="payoffdate" value="#{wage_OrgSumItemShowBB.payoffdate}"/>
  <h:inputHidden id="selectID" value="#{wage_OrgSumItemShowBB.selectID}"/>

  <c:verbatim>
  <table width="98%" height="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td class="td_title"  height=2>
  </c:verbatim>
            <h:outputText value="发薪单位：#{wage_OrgSumItemShowBB.unitName}"/>
            <h:outputText value="发薪时间：#{wage_OrgSumItemShowBB.payoffdate}"/>
  <c:verbatim>
        </td>
   </tr>

   <tr>
        <td  height=30 align="right" valign="middle">
  </c:verbatim>
            <h:outputText value="选择显示的信息集合："/>
            <h:selectOneMenu onchange="submit();"  id="selectSet" value="#{wage_OrgSumItemShowBB.selectSet}" valueChangeListener="#{wage_OrgSumItemShowBB.findInfo}" >
                <c:selectItems value="#{wage_OrgSumItemShowBB.selitem}" />
            </h:selectOneMenu>

            <h:commandButton value="修改" styleClass="button01" onclick="return forEdit();" action="#{wage_OrgSumItemShowBB.queryOrgSum}"></h:commandButton>
            <h:commandButton value="汇总数据"  styleClass="button01"  onclick="return forGroup();" action="#{wage_OrgSumItemShowBB.doSumCalc}"></h:commandButton>
            <h:commandButton value="导出"  styleClass="button01" onclick="doExport2();" type="button"></h:commandButton>
<c:verbatim>
        </td>
    </tr>

    <tr>
      <td >
          <jsp:include page="/pages/common/activepage/SecondActiveList.jsp">
              <jsp:param name="hasOperSign" value="true"/>
              <jsp:param name="operSignType" value="checkbox"/>
              <jsp:param name="hasEdit" value="false"/>
              <jsp:param name="isEditList" value="false"/>
              <jsp:param name="isCheckRight" value="false"/>
              <jsp:param name="keyName" value="SUBID"/>
          </jsp:include>
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
