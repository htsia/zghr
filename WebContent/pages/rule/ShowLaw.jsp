<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@ include file="/pages/include/taglib.jsp" %>

<x:saveState value="#{law_infobb}"/>
<c:verbatim><base target="_self"></c:verbatim>
 <h:form>
 <h:inputHidden value="#{law_infobb.initShowLaw}"/>
     <c:verbatim>
     <table width="100%" cellspacing=0 cellpadding=0>
         <tr>
         <td class="td_title">
              <img src="/images/tips.gif" alt=""> 显示政策法规
         </td>
         <td class="td_title" align="right">
     </c:verbatim>
             <h:commandButton value="关闭窗口" type="button" onclick="window.close();"  styleClass="button01" />
     <c:verbatim>
         </td>
         </tr>
     </table>
     <br>
     <table class="table03" width="98%" align="center">
         <tr>
            <td class="td_form01">标题
            </td>
            <td class="td_form02" colspan="3">
</c:verbatim>
             <h:outputText value="#{law_infobb.rfinfo.title}"  />
<c:verbatim>
            </td>
         </tr>

         <tr>
            <td class="td_form01" width="20%">版布时间
            </td>
            <td class="td_form02" width="30%">
</c:verbatim>
             <h:outputText value="#{law_infobb.rfinfo.publicDate}"  />
<c:verbatim>
            </td>

             <td class="td_form01" width="20%"> 生效时间
             </td>
             <td class="td_form02" width="30%">
</c:verbatim>
              <h:outputText value="#{law_infobb.rfinfo.actDate}"  />
<c:verbatim>
             </td>
         </tr>

         <tr>
            <td colspan="4" class=td_form02 align="left" valign="top">
</c:verbatim>
                <h:outputText escape="false" value="<strong>内容:<br></strong>"  />
                <h:outputText escape="false"  value="#{law_infobb.rfinfo.content}"  />
<c:verbatim>
            </td>
         </tr>
         <tr>
             <td colspan="4" class=td_form02 align="left" valign="top">
</c:verbatim>
                 <h:outputText escape="false" value="<strong>附件:<br></strong>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{law_infobb.rfinfo.att1FileName}'>#{law_infobb.rfinfo.att1Title}</a><br>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{law_infobb.rfinfo.att2FileName}'>#{law_infobb.rfinfo.att2Title}</a><br>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{law_infobb.rfinfo.att3FileName}'>#{law_infobb.rfinfo.att3Title}</a><br>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{law_infobb.rfinfo.att4FileName}'>#{law_infobb.rfinfo.att4Title}</a><br>"  />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;<a target=_blank href='#{law_infobb.rfinfo.att5FileName}'>#{law_infobb.rfinfo.att5Title}</a><br>"  />
<c:verbatim>
             </td>
         </tr>
     </table>
</c:verbatim>
</h:form>