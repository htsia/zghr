<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>

    <script type="text/javascript">
      
       function dataCtr(id){
            window.showModalDialog("/xys/eva/DeptKpiDataCtr.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return true;
       }
       function queryScore(id){
           window.showModalDialog("/xys/eva/DeptKpiScoreQry.jsf?planId="+id, null, "dialogWidth:"+screen.width*0.8+"px;dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
      }
       function ctrScore(id){
    	   window.showModalDialog("/xys/eva/ScoreCtrList.jsf?type=1&planId="+id, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
           return true;
       }
       function showError(id){
	 	   window.showModalDialog("/xys/eva/ShowGradeError.jsf?objType=1&planId="+id, null, "dialogWidth:"+screen.width*0.6+"px;dialogHeight:"+screen.height*0.6+"px;center:center;resizable:no;status:no;scroll:yes;");
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

<x:saveState value="#{dept_KpiAuditCtrBB}"></x:saveState>
<h:form id="form1">
    <h:inputHidden value="#{dept_KpiAuditCtrBB.pageInit}"></h:inputHidden>
     <c:verbatim>
       <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
        <tr>
            <td class="td_title"><img src="/images/tips.gif">
                 ��Ч���� ->����KPI���˼��
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
                <h:selectBooleanCheckbox value="#{dept_KpiAuditCtrBB.selectAll}" onclick="submit();" valueChangeListener="#{dept_KpiAuditCtrBB.queryAll}" />
                <h:outputText value="  "></h:outputText>
                <h:outputText value="��¼��:#{dept_KpiAuditCtrBB.mypage.totalRecord}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ҳ��:#{dept_KpiAuditCtrBB.mypage.totalPage}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="ÿҳ��#{dept_KpiAuditCtrBB.mypage.pageSize}"></h:outputText>
	            <h:outputText value="  "></h:outputText>
	            <h:outputText value="��ǰΪ��#{dept_KpiAuditCtrBB.mypage.currentPage}ҳ"></h:outputText>
           		<h:commandButton value="��ҳ" action="#{dept_KpiAuditCtrBB.first}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{dept_KpiAuditCtrBB.pre}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="��ҳ" action="#{dept_KpiAuditCtrBB.next}" styleClass="button01"></h:commandButton>
	            <h:commandButton value="βҳ" action="#{dept_KpiAuditCtrBB.last}" styleClass="button01"></h:commandButton>
            </h:panelGroup>
          </h:panelGrid>

    </h:panelGrid>
    <c:verbatim>
	  </td></tr>
	   <tr><td>
	  <div style='width:100%;height:100%;overflow:auto' id=datatable>
	</c:verbatim>
    <h:dataTable value="#{dept_KpiAuditCtrBB.planList}" var="list" align="center" id="dateList"
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
            <h:panelGrid columns="3" align="center">
            <h:commandButton value="�ȼ���������" onclick="ctrScore('#{list.planId}')" styleClass="button01" type="button" rendered="#{list.status=='2'}"></h:commandButton>
            <h:commandButton value="��ʼ���" action="#{dept_KpiAuditCtrBB.beginGrade}" styleClass="button01" 
            rendered="#{list.status=='2'&&list.deptKpiStatus!='1'}" onclick="showProcessBar()">
                  <x:updateActionListener property="#{dept_KpiAuditCtrBB.planId}" value="#{list.planId}"/>
            </h:commandButton>
            <h:commandButton value="�������" action="#{dept_KpiAuditCtrBB.endGrade}" styleClass="button01" rendered="#{list.status=='2'&&list.deptKpiStatus=='1'}">
                  <x:updateActionListener property="#{dept_KpiAuditCtrBB.planId}" value="#{list.planId}"/>
            </h:commandButton>
            <h:commandButton value="������־" onclick="showError('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            </h:panelGrid>
            <h:panelGrid columns="2" align="center">
            <h:commandButton value="���ݺϷ��Լ��" onclick="dataCtr('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
            <h:commandButton value="�鿴������" onclick="queryScore('#{list.planId}')" styleClass="button01" type="button" ></h:commandButton>
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
