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
            alert("�������ѯ����!");
            return false;
        }
        return true;
    }
      
      function checkDate(){
          if (document.all("form1:year").value==""){
              alert("��ѡ�����");
              return false;
          }
          if (document.all("form1:code")==null || document.all("form1:code").value==""){
              alert("��ѡ��Ҫ��ѯ����Ա");
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
            <h:outputText value=" н����� ->  ��˰�걨��ѯ"/>
<f:verbatim>
    </td></tr>

    <tr><td>
</f:verbatim>
            <h:outputText value="н�����ף�"></h:outputText>
            <h:selectOneMenu id = "setId" value="#{self_querypaybb.setId}" >
                 <c:selectItems value="#{self_querypaybb.setList}"/>
            </h:selectOneMenu>

            <h:outputText value="    ��¼��Ҫ��ѯ��������Ա�����:" />
            <h:inputText  id="nameStr" value="#{self_querypaybb.nameStr}" style="width:140px"/>
            <h:commandButton value="��ѯ" onclick="return checkquery();" styleClass="button01" id="addMany" action="#{self_querypaybb.addMany}" />
            <h:outputText value="��ѡ��"></h:outputText>
            <h:selectOneMenu id="code" value="#{self_querypaybb.code}">
                <c:selectItems value="#{self_querypaybb.pids}"></c:selectItems>
            </h:selectOneMenu>

             <h:outputText value="��ʱ��" />
             <h:selectOneMenu id="year" value="#{self_querypaybb.beginTime}" >
                  <c:selectItem itemValue='2007' itemLabel='2007���'></c:selectItem>
                 <c:selectItem itemValue='2008' itemLabel='2008���'></c:selectItem>
                 <c:selectItem itemValue='2009' itemLabel='2009���'></c:selectItem>
                 <c:selectItem itemValue='2010' itemLabel='2010���'></c:selectItem>
                 <c:selectItem itemValue='2011' itemLabel='2011���'></c:selectItem>
                 <c:selectItem itemValue='2012' itemLabel='2012���'></c:selectItem>
                 <c:selectItem itemValue='2013' itemLabel='2013���'></c:selectItem>
             </h:selectOneMenu>

            <h:outputText value="  " />
            <h:commandButton value="��ʾ�걨��" onclick ="return checkDate();" styleClass="button01" action="#{self_querypaybb.hr_queryTaxByTime}" />
            <h:commandButton value="��ʾ��ϸ��" onclick ="return showDetail();" styleClass="button01" type="button"/>
<f:verbatim>
         </td></tr>

        <tr><td>
</f:verbatim>
            <h:panelGrid align="center" width="50%">
              <h:outputText value="�����걨��(��λ:Ԫ)"	style="font-weight:bold;font-size:12pt" />
            </h:panelGrid>
<f:verbatim>
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
    </table>
</f:verbatim>
</h:form>

