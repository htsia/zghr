<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport"%>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>
<%@ page import="com.hr319wg.common.Constants" %>
<script type="text/javascript">
  function selPost(){
    var deptId=document.all("form1:A016030").code;
    PopUpPostDlgByDept(document.all("form1:A001715"),null,deptId);
  }
</script>
    <x:saveState value="#{emp_PersonDismissBB}"/>
    <h:form id="form1">
        <h:inputHidden value="#{emp_PersonDismissBB.pageInit}"/>
        <%
            String ids = (String)request.getAttribute("perIds");
        %>
        <c:verbatim>
        <input type="hidden" name="pids" value="<%=ids%>">
        <br>
        <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
            <tr><td colspan=4> <strong><%=LanguageSupport.getResource("RYGL-2227", "以下人员要办理划转业务")%></strong><br>
               <%
                   String UnitID="";
                   String Namelist="";
                   String []pelist=ids.split(",");
                   for(int i=0;i<pelist.length;i++){
                       PersonBO pb=SysCacheTool.findPersonById(pelist[i]);
                       if (i==0) UnitID=pb.getOrgId();
                       if (Namelist.equals("")){
                         Namelist=pb.getName();
                      }
                      else{
                         Namelist=Namelist+","+ pb.getName();
                      }
                   }
                   Namelist="&nbsp;&nbsp;&nbsp;&nbsp;"+ Namelist;
                   out.println(Namelist);
               %>
               </td>
            </tr>
             <tr nowrap>
                <td class="td_form01 td_form_required"><%=LanguageSupport.getResource("RYGL-2228", "调入机构")%></td>
                <td class="td_form02" colspan="3">
</c:verbatim>
                    <h:inputText styleClass="input" id="A016030" value="#{emp_PersonDismissBB.chgs}" dict="yes" dict_num="OU"  code=""
                            readonly="true"    alt="调入机构|0|s|50||"/>
<c:verbatim>
                    <input type="button" class="button_select" onclick="PopUpOrgDlg('form1:A016030',2,'')">
                </td>

            </tr>

        <tr nowrap>
           <td class=td_form01 id="td_A001715" >调入岗位</td>
           <td class=td_form02 colspan="3">
       </c:verbatim>
        <h:inputText styleClass="input" id="A001715" value="#{emp_PersonDismissBB.posts}" dict="yes" dict_num="PO"  code=""
                readonly="true"    alt="新岗位|1|s|50||"/>

       <c:verbatim>
               <input type="button" class="button_select" onclick="selPost()">
           </td>
       </tr>
       </table>
        <br>
        <table width=95% border=0 align=center cellpadding=0 cellspacing=0 >
            <tr>
                <td align="center">
 </c:verbatim>
                      <h:commandButton id="save" styleClass="button01" value="保存" onclick="return forsubmit(document.forms(0))" action="#{emp_PersonDismissBB.saveDispatch}" /></td>
<c:verbatim>
            </tr>
        </table>
 </c:verbatim>
    </h:form>
<script type="text/javascript">
<%
    InfoItemBO A001715=SysCacheTool.findInfoItem("","A001715");
    if (A001715!=null && "1".equals(A001715.getItemNotNull())){
        out.println("document.all('td_A001715').className='td_form01 td_form_required';");
        out.println("document.all('form1:A001715').alt='新岗位|0|s|50||';");
    }
    if ("1".equals(Constants.C001020toA001716)){
       out.println("document.all('postLevel').style.display='none';");
    }
%>
</script>
