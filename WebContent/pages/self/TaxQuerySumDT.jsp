<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
					
<script>
      function checkDate(){
          if (document.all("form1:year").value==""){
              alter("请选择年度");
              return false;
          }
          return true;
      }
      function showDetail(){
         if (checkDate()){
            window.showModalDialog("/wage/payoff/ShowTaxDetail.jsf?year="+document.all("form1:year").value, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
         }
      }
</script>

<x:saveState id="bb"  value="#{self_querypaybb}"/>
<h:form id="form1">
  <c:verbatim>
        <br>
        <table width="90%"  cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td align="center" width="30%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQueryByMonth.jsf">薪资查询－按月份查询工资发放明细</a></td>
                <td align="center" width="30%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQuerySum.jsf">薪资查询－按时间段查询工资汇总情况</a></td>
                <td align="center" width="30%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\TaxQuerySum.jsf">薪资查询-个人所得税申报查询</a></td>
            </tr>
      <tr>
          <td colspan=3>
              <div class="tabbody" height="100%" width="100%"  id=datatable>

            <table width="90%" align="center">
                <tr><td>
        </c:verbatim>
                     <h:outputText value="申报时间" />
                     <h:selectOneMenu id='year' value="#{self_querypaybb.beginTime}" >
                         <c:selectItems value="#{self_querypaybb.years}"></c:selectItems>
                     </h:selectOneMenu>

                    <h:outputText value="  " />
                      <h:outputText value="输入验证码:" rendered="#{sys_commonInfoBB.enableWageQueryCheck}"></h:outputText>
                      <h:inputText value="#{self_querypaybb.inputCode}"></h:inputText>
  
                    <h:commandButton value="显示申报表" onclick ="return checkDate();" styleClass="button01" action="#{self_querypaybb.queryTaxByTime}" />
                    <h:commandButton value="显示明细表" onclick ="return showDetail();" styleClass="button01" type="button"/>
        <c:verbatim>
                 </td></tr>

                <tr><td>
         </c:verbatim>
                    <h:panelGrid align="center" width="50%">
                      <h:outputText value="个人所得税申报查询表(单位:元)"	style="font-weight:bold;font-size:12pt" />
                    </h:panelGrid>
        <c:verbatim>
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
        </c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.wage}" />
        <c:verbatim>
            </td>
                           <td class=td_middle_right></td>
                           <td class=td_middle_right>
        </c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.wage}" />
        <c:verbatim>
          </td>
                           <td class=td_middle_right>
        </c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.wage_taxincome}" />
        <c:verbatim>
         </td>
                           <td class=td_middle_right>
        </c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.wage_tax}" />
        <c:verbatim>
                           </td>
                           <td class=td_middle_right>
        </c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.wage_tax}" />
        <c:verbatim>
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
        <c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.labor}" />
        </c:verbatim>
                           </td>
                           <td class=td_middle_right></td>
                           <td class=td_middle_right>
        <c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.labor}" />
        </c:verbatim>
                           </td>
                           <td class=td_middle_right>
        <c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.labor_taxincome}" />
        </c:verbatim>
                           </td>
                           <td class=td_middle_right>
        <c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.labor_tax}" />
        </c:verbatim>
        </td>
                           <td class=td_middle_right>
        <c:verbatim>
                           <h:outputText value="#{self_querypaybb.taxtable.labor_tax}" />
        </c:verbatim>
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

                <tr><td>
         </c:verbatim>
                    <h:outputText escape="false" value="#{self_querypaybb.taxmemo}"></h:outputText>
        <c:verbatim>
                </td></tr>
            </table>
            </div>

        </td>
        </tr>
            
        </table>



</c:verbatim>
</h:form>

