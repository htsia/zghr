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
              alter("��ѡ�����");
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
                <td align="center" width="30%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQueryByMonth.jsf">н�ʲ�ѯ�����·ݲ�ѯ���ʷ�����ϸ</a></td>
                <td align="center" width="30%" class=tab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\PayQuerySum.jsf">н�ʲ�ѯ����ʱ��β�ѯ���ʻ������</a></td>
                <td align="center" width="30%" class=activeTab><img src="/images/common/handtip.gif">&nbsp;<a href="\desktop\TaxQuerySum.jsf">н�ʲ�ѯ-��������˰�걨��ѯ</a></td>
            </tr>
      <tr>
          <td colspan=3>
              <div class="tabbody" height="100%" width="100%"  id=datatable>

            <table width="90%" align="center">
                <tr><td>
        </c:verbatim>
                     <h:outputText value="�걨ʱ��" />
                     <h:selectOneMenu id='year' value="#{self_querypaybb.beginTime}" >
                         <c:selectItems value="#{self_querypaybb.years}"></c:selectItems>
                     </h:selectOneMenu>

                    <h:outputText value="  " />
                      <h:outputText value="������֤��:" rendered="#{sys_commonInfoBB.enableWageQueryCheck}"></h:outputText>
                      <h:inputText value="#{self_querypaybb.inputCode}"></h:inputText>
  
                    <h:commandButton value="��ʾ�걨��" onclick ="return checkDate();" styleClass="button01" action="#{self_querypaybb.queryTaxByTime}" />
                    <h:commandButton value="��ʾ��ϸ��" onclick ="return showDetail();" styleClass="button01" type="button"/>
        <c:verbatim>
                 </td></tr>

                <tr><td>
         </c:verbatim>
                    <h:panelGrid align="center" width="50%">
                      <h:outputText value="��������˰�걨��ѯ��(��λ:Ԫ)"	style="font-weight:bold;font-size:12pt" />
                    </h:panelGrid>
        <c:verbatim>
                </td></tr>

                <tr><td align="center">
                   <table class="table03" >
                       <tr>
                           <td class=td_top align="center" rowspan=2>������Ŀ</td>
                           <td class=td_top align="center" colspan=3>�����ö�</td>
                           <td class=td_top align="center" rowspan=2>Ӧ��˰���ö�</td>
                           <td class=td_top align="center" rowspan=2>Ӧ��˰��</td>
                           <td class=td_top align="center" rowspan=2>�ѽɣ��ۣ�˰��</td>
                           <td class=td_top align="center" rowspan=2>�ֿ�˰��</td>
                           <td class=td_top align="center" rowspan=2>����˰��</td>
                           <td class=td_top align="center" rowspan=2>Ӧ��˰��</td>
                           <td class=td_top align="center" rowspan=2>Ӧ��˰��</td>
                           <td class=td_top align="center" rowspan=2>��ע</td>
                       </tr>
                       <tr>
                           <td class=td_top align="center" >����</td>
                           <td class=td_top align="center" >����</td>
                           <td class=td_top align="center" >�ϼ�</td>
                       </tr>
                       <tr onmouseover=trlinkOver(this) onmouseout=trlinkOut(this)>
                           <td class=td_top >1�����ʡ�н������</td>
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
                           <td class=td_top >2�����幤�̻�����������Ӫ����</td>
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
                           <td class=td_top >3��������ҵ��λ�ĳа���Ӫ�����⾭Ӫ����</td>
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
                           <td class=td_top >4�����񱨳�����</td>
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
                           <td class=td_top >5���������</td>
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
                           <td class=td_top >6������Ȩʹ�÷�����</td>
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
                           <td class=td_top >7����Ϣ����Ϣ����������</td>
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
                           <td class=td_top >8���Ʋ���������</td>
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
                           <td class=td_top >9���Ʋ�ת������</td>
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
                           <td class=td_top >&nbsp;&nbsp;&nbsp;&nbsp;���У���Ʊת������</td>
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
                           <td class=td_top >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;���˷���ת������</td>
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
                           <td class=td_top > 10��żȻ����</td>
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
                           <td class=td_top >11����������</td>
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

