<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
	   function caclDeptKPI(id){
	        window.showModalDialog("/xys/eva/caclDeptKpi.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
	        return true;
	   }
       function caclPersKPI(id){
            window.showModalDialog("/xys/eva/caclPersonKpiIndex.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function caclPers360(id){
    	   window.showModalDialog("/xys/eva/caclPerson360Index.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.9+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       
       function caclTotal(id){
    	   window.showModalDialog("/xys/eva/caclEvaObjIndex.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.9+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
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

<x:saveState value="#{xys_evaPlanCaclBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{xys_evaPlanCaclBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                        ��Ч���� ->�������
           </td>
        </tr>
    </table>
       <table height=100% width=100% align="center">
       <tr><td height=8>
    </c:verbatim>
    <h:panelGrid width="98%" columns="1">
          <h:panelGrid align="right" columns="2">
             <h:panelGroup>
                <h:outputText value="��ʾȫ��"></h:outputText>
                <h:selectBooleanCheckbox value="#{xys_evaPlanCaclBB.selectAll}" onclick="submit();" valueChangeListener="#{xys_evaPlanCaclBB.queryAll}" />
                <h:outputText value="  "></h:outputText>
                <h:outputText value="��¼��:#{xys_evaPlanCaclBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{xys_evaPlanCaclBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{xys_evaPlanCaclBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{xys_evaPlanCaclBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{xys_evaPlanCaclBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaPlanCaclBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{xys_evaPlanCaclBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{xys_evaPlanCaclBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{xys_evaPlanCaclBB.planList}" var="list" align="center" id="dateList"
                 headerClass="td_top" columnClasses="td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center,td_middle_center"
                 styleClass="table03" width="98%" >
        <h:column>
            <c:facet name="header"><h:outputText value="�ƻ�����"/></c:facet>
            <h:outputText value="#{list.planName}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="���"/></c:facet>
            <h:outputText value="#{list.year}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��ʼʱ��"/></c:facet>
            <h:outputText value="#{list.beginTime}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����ʱ��"/></c:facet>
            <h:outputText value="#{list.endTime}"/>
        </h:column>

        <h:column>
            <c:facet name="header"><h:outputText value="��������"/></c:facet>
            <h:outputText value="#{list.planType}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="�ƻ��ȼ�"/></c:facet>
            <h:outputText value="#{list.planGrade}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="��������λ��"/></c:facet>
            <h:selectOneMenu value="#{list.scorePers}" disabled="true">
                <c:selectItem itemLabel="����" itemValue="0"/>
                <c:selectItem itemLabel="һλС��" itemValue="1"/>
                <c:selectItem itemLabel="��λС��" itemValue="2"/>
            </h:selectOneMenu>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="״̬"/></c:facet>
            <h:outputText value="#{list.statusDes}"/>
        </h:column>
        <h:column>
            <c:facet name="header"><h:outputText value="����"/></c:facet>
            <h:panelGrid columns="3">
            <h:commandButton value="����KPI����" onclick="caclDeptKPI('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            <h:commandButton value="����KPI����" onclick="caclPersKPI('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            <h:commandButton value="����̬�ȼ���" onclick="caclPers360('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            </h:panelGrid>
            <h:panelGrid columns="2">
            <h:commandButton value="�ۺϼ���" onclick="caclTotal('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            <h:commandButton value="�������" styleClass="button01" action="#{xys_evaPlanCaclBB.auditResult}" rendered="#{list.status=='2'}">
            	<x:updateActionListener value="#{list.planId}" property="#{xys_evaPlanCaclBB.planId}"/>
            </h:commandButton>
            </h:panelGrid>
        </h:column>
    </h:dataTable>
    <c:verbatim>
	</div>
	</td></tr>
	</table>
	</c:verbatim>
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
</h:form>
<script type="text/javascript">
   setDataTableOver("form1:dateList");
</script>
