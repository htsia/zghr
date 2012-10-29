<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

  <script language="javascript">
      function refreshStar(){
          if (document.all('form1:pID').value!=null && document.all('form1:pID').value!=""){
            document.all('ifPhoto').src="/self/ShowStars.jsf?ID="+document.all('form1:pID').value;
          }
          return false;
      }
   </script>

  <x:saveState value="#{self_starsBB}"></x:saveState>
  <h:form id="form1">
  <c:verbatim>
        <table>
            <tr>
                <td >
</c:verbatim>
                    <h:selectOneListbox id="pID" onchange="refreshStar();" style="width:200px; height:250px">
                        <c:selectItems value="#{self_starsBB.starsPerList}"></c:selectItems>
                    </h:selectOneListbox>
<c:verbatim>
                </td>
                <td width="250px" align="center">
                    <iframe id="ifPhoto" src="/self/ShowStars.jsf" frameBorder="0"  width="244px" scrolling="no" height="250"></iframe>
                </td>
            </tr>
        </table>
</c:verbatim>
    </h:form>
  <script language="javascript">
      if (document.all('ifPhoto').src.indexOf("ID")<0){
          document.all('form1:pID').selectedIndex=0;
          refreshStar(); // 第一次进入
      }
  </script>
