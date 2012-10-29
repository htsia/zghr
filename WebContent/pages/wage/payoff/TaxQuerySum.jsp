<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
					
<script>
    function checkquery(){
        if (document.all("form1:nameStr").value==""){
            alert("请输入查询条件!");
            return false;
        }
        return true;
    }
      
      function checkDate(){
          if (document.all("form1:year").value==""){
              alert("请选择年度");
              return false;
          }
          if (document.all("form1:code")==null || document.all("form1:code").value==""){
              alert("请选择要查询的人员");
              return false;
          }
          return true;
      }
      function showDetail(){
         if (checkDate()){
            window.showModalDialog("/wage/payoff/ShowTaxDetail.jsf?setId="+document.all("form1:setId").value+"&pid="+document.all("form1:code").value+"&year="+document.all("form1:year").value, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
         }
         return false;
      }
</script>

<x:saveState id="bb"  value="#{self_querypaybb}"/>
<h:form id="form1">
<f:verbatim>
    <table width="98%" align="center">
    <tr><td class=td_title>
</f:verbatim>
            <h:graphicImage value="/images/tips.gif" />
            <h:outputText value=" 薪酬管理 ->  个税申报查询"/>
<f:verbatim>
    </td></tr>

    <tr><td>
</f:verbatim>
            <h:outputText value="薪资账套："></h:outputText>
            <h:selectOneMenu id = "setId" value="#{self_querypaybb.setId}" >
                 <c:selectItems value="#{self_querypaybb.setList}"/>
            </h:selectOneMenu>

            <h:outputText value="    请录入要查询的姓名或员工编号:" />
            <h:inputText  id="nameStr" value="#{self_querypaybb.nameStr}" style="width:140px"/>
            <h:commandButton value="查询" onclick="return checkquery();" styleClass="button01" id="addMany" action="#{self_querypaybb.addMany}" />
            <h:outputText value="请选择："></h:outputText>
            <h:selectOneMenu id="code" value="#{self_querypaybb.code}">
                <c:selectItems value="#{self_querypaybb.pids}"></c:selectItems>
            </h:selectOneMenu>

             <h:outputText value="审报时间" />
             <h:selectOneMenu id="year" value="#{self_querypaybb.beginTime}" >
                  <c:selectItem itemValue='2007' itemLabel='2007年度'></c:selectItem>
                 <c:selectItem itemValue='2008' itemLabel='2008年度'></c:selectItem>
                 <c:selectItem itemValue='2009' itemLabel='2009年度'></c:selectItem>
                 <c:selectItem itemValue='2010' itemLabel='2010年度'></c:selectItem>
                 <c:selectItem itemValue='2011' itemLabel='2011年度'></c:selectItem>
                 <c:selectItem itemValue='2012' itemLabel='2012年度'></c:selectItem>
                 <c:selectItem itemValue='2013' itemLabel='2013年度'></c:selectItem>
             </h:selectOneMenu>

            <h:outputText value="  " />
            <h:commandButton value="显示申报表" onclick ="return checkDate();" styleClass="button01" action="#{self_querypaybb.hr_queryTaxByTime}" />
            <h:commandButton value="显示明细表" onclick ="return showDetail();" styleClass="button01" type="button"/>
<f:verbatim>
         </td></tr>

        <tr><td>
</f:verbatim>
            <h:panelGrid align="center" width="50%">
              <h:outputText value="个人申报表(单位:元)"	style="font-weight:bold;font-size:12pt" />
            </h:panelGrid>
<f:verbatim>
        </td></tr>

        <tr><td align="center">
           <table class="table03" >
               <tr>
                   <td class=td_top align="center" rowspan=2>所得项目</td>
                   <td class=td_top align="center" colspan=3>年所得额</td>
                   <td class=td_top align="center" rowspan=2>应纳税所得额</td>
                   <td class=td_top align="center" rowspan=2>应纳税额</td>
                   <td class=td_top align="center" rowspan=2>已缴（扣）税额</td>
                   <td class=td_top align="center" rowspan=2>抵扣税额</td>
                   <td class=td_top align="center" rowspan=2>减免税额</td>
                   <td class=td_top align="center" rowspan=2>应补税额</td>
                   <td class=td_top align="center" rowspan=2>应退税额</td>
                   <td class=td_top align="center" rowspan=2>备注</td>
               </tr>
               <tr>
                   <td class=td_top align="center" >境内</td>
                   <td class=td_top align="center" >境外</td>
                   <td class=td_top align="center" >合计</td>
               </tr>
               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >1、工资、薪金所得</td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.wage}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.wage}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.wage_taxincome}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.wage_tax}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.wage_tax}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >2、个体工商户的生产、经营所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >3、对企事业单位的承包经营、承租经营所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >4、劳务报酬所得</td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.labor}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.labor}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.labor_taxincome}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.labor_tax}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right>
</f:verbatim>
                   <h:outputText value="#{self_querypaybb.taxtable.labor_tax}" />
<f:verbatim>
                   </td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >5、稿酬所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >6、特许权使用费所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >7、利息、股息、红利所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >8、财产租赁所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >9、财产转让所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >&nbsp;&nbsp;&nbsp;&nbsp;其中：股票转让所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;个人房屋转让所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top > 10、偶然所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>

               <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                   <td class=td_top >11、其他所得</td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
                   <td class=td_middle_right></td>
               </tr>
           </table>
        </td></tr>
    </table>
</f:verbatim>
</h:form>

