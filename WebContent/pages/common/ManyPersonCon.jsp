<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp"%>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
      <script type="text/javascript">
          function doOK() {
              var ret="";
              if (Rtrim(document.all("form1:text1").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text1").value);
              }
              if (Rtrim(document.all("form1:text2").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text2").value);
              }
              if (Rtrim(document.all("form1:text3").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text3").value);
              }
              if (Rtrim(document.all("form1:text4").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text4").value);
              }
              if (Rtrim(document.all("form1:text5").value)!=""){
                  ret+=","+document.all("form1:text5").value;
              }
              if (Rtrim(document.all("form1:text6").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text6").value);
              }
              if (Rtrim(document.all("form1:text7").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text7").value);
              }
              if (Rtrim(document.all("form1:text8").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text8").value);
              }
              if (Rtrim(document.all("form1:text9").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text9").value);
              }
              if (Rtrim(document.all("form1:text10").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text10").value);
              }
              if (Rtrim(document.all("form1:text11").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text11").value);
              }
              if (Rtrim(document.all("form1:text12").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text12").value);
              }
              if (Rtrim(document.all("form1:text13").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text13").value);
              }
              if (Rtrim(document.all("form1:text14").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text14").value);
              }
              if (Rtrim(document.all("form1:text15").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text15").value);
              }
              if (Rtrim(document.all("form1:text16").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text16").value);
              }
              if (Rtrim(document.all("form1:text17").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text17").value);
              }
              if (Rtrim(document.all("form1:text18").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text18").value);
              }
              if (Rtrim(document.all("form1:text19").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text19").value);
              }
              if (Rtrim(document.all("form1:text20").value)!=""){
                  ret+=","+Rtrim(document.all("form1:text20").value);
              }
              //alert(ret);
              window.returnValue=ret;
              window.close();
          }
          function doCancel() {
              window.returnValue="";
              window.close();
          }
          function doClear(){
              document.all("form1:text1").value="";
              document.all("form1:text2").value="";
              document.all("form1:text3").value="";
              document.all("form1:text4").value="";
              document.all("form1:text5").value="";
              document.all("form1:text6").value="";
              document.all("form1:text7").value="";
              document.all("form1:text8").value="";
              document.all("form1:text9").value="";
              document.all("form1:text10").value="";
              document.all("form1:text11").value="";
              document.all("form1:text12").value="";
              document.all("form1:text13").value="";
              document.all("form1:text14").value="";
              document.all("form1:text15").value="";
              document.all("form1:text16").value="";
              document.all("form1:text17").value="";
              document.all("form1:text18").value="";
              document.all("form1:text19").value="";
              document.all("form1:text20").value="";
          }
       </script>

  <h:form id="form1">
  <c:verbatim>
  <table width="98%" height=98%>
      <tr><td align="right" height=8>
</c:verbatim>
          <h:commandButton value="Çå¿Õ" styleClass="button01" type="button" onclick="doClear();"></h:commandButton>
          <h:commandButton value="È·¶¨" styleClass="button01" type="button" onclick="doOK();"></h:commandButton>
          <h:commandButton value="È¡Ïû" styleClass="button01" type="button" onclick="doCancel();"></h:commandButton>
  <c:verbatim>
      </td></tr>
      <tr><td>
          <div style='width:100%;height:100%;overflow:auto' id=datatable>
              <table border="0"  align="center" cellspacing="2"    id="setlist" class="table03" cellpadding="0"	>
                  <tr>
                      <td class="td_form01">
   </c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´1" />
  <c:verbatim>
                      </td>
                      <td class="td_form02">
   </c:verbatim>
                        <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text1" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´2" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text2" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´3" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text3" styleClass="input"/>
<c:verbatim>
                  </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´4" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text4" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´5" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text5" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´6" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                          <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text6" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´7" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text7" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´8" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                          <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text8" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´9" />
<c:verbatim>
                       </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text9" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´10" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text10" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´11" />
<c:verbatim>
                       </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text11" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´12" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text12" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´13" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text13" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´14" />
<c:verbatim>
                       </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text14" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´15" />
<c:verbatim>
                     </td>
                     <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text15" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´16" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text16" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´17" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text17" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´18" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text18" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´19" />
<c:verbatim>
                       </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text19" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
                  <tr>
                      <td class="td_form01">
</c:verbatim>
                      <h:outputText value="ÐÕÃû¡¢±àºÅ»ò¼òÆ´20" />
<c:verbatim>
                      </td>
                      <td class="td_form02">
</c:verbatim>
                      <h:inputText style="behavior:url('/js/mytextbox.htc')" id="text20" styleClass="input"/>
<c:verbatim>
                      </td>
                  </tr>
               </table>
          </div>
      </td></tr>
  </table>
  </c:verbatim>
  </h:form>

  <script type="text/javascript">
      setTableInputOver("setlist");
  </script>
