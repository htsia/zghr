<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.emp.pojo.bo.PersonBO"%>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool"%>
<%@ include file="../include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<x:saveState value="#{sys_personDeleteBB}"/>
<h:form id="form1">
<h:inputHidden value="#{sys_personDeleteBB.pageInit}"/>
    <%
        String ids = (String)request.getAttribute("perIds");
    %>
<c:verbatim>
    <input type="hidden" name="pids" value="<%=ids%>">
    <br>
    <table width=95% align=center border=0 cellpadding=0 cellspacing=0>
        <tr><td colspan=4 height="95" valign="top"> <strong>
         <f:verbatim>
                   <%=LanguageSupport.getResource("XTGL-1187","将要删除以下人员(物理删除)")%> :
       </f:verbatim>
           
        </strong><br>
           <%
               String Namelist="";
               String []pelist=ids.split(",");
               for(int i=0;i<pelist.length;i++){
                  PersonBO pb=SysCacheTool.findPersonById(pelist[i]);
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

        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton id="delete" styleClass="button01" value="删除" action="#{sys_personDeleteBB.delete}" />
                <h:commandButton id="close" styleClass="button01" value="返回" onclick="window.close();" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>    
</h:form>
