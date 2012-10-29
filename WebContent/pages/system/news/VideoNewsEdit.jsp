<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
  
    <script type="text/javascript">
       function showProcessBar() {
           x = document.body.clientWidth / 2 - 150;
           y = document.body.clientHeight / 2;
           document.all('processbar').style.top = y;
           document.all('processbar').style.left = x;
           document.all('processbar').style.display = "";
        }
        function AddAttech() {
            if (document.all('form1:excelFile').value==""){
                alert("请选择文件");
                return false;
            }
            return true;
         }
         function doCheck(){
            if (document.all('form1:title').value==""){
                alert("请录入标题!");
                return false;
            }
             if (document.all('form1:excelFileInput').value=="" && document.all('form1:excelFile').value==""){
                 alert("请选择视频文件!");
                 return false;
             }
             if (document.all('form1:iconFile').value=="" && document.all('form1:iconFileInput').value==""){
                 alert("请标题图片!");
                 return false;
             }
             showProcessBar();
             return true;
        }
    </script>

<x:saveState value="#{sys_videoNewsBB}"/>
<h:form id="form1" enctype="multipart/form-data">
        <h:inputHidden id="pageInit" value="#{sys_videoNewsBB.initFile}"/>
<c:verbatim>
        <br>

        <table width="98%"  align="center" class="table03">
            <tr>
            <td class="td_form01">
                 <%=LanguageSupport.getResource("XTGL-1315"," 显示单位范围")%>
             </td>
            <td class="td_form02" >
 </c:verbatim>
                <h:panelGroup>
                    <h:selectOneMenu id="orgID" value="#{sys_videoNewsBB.filebo.orgID}">
                        <c:selectItems value="#{sys_videoNewsBB.orgList}"></c:selectItems>
                    </h:selectOneMenu>
                </h:panelGroup>
<c:verbatim>
            </td>
            </tr>
    
            <tr>
                <td class="td_form01">
                 <%=LanguageSupport.getResource("XTGL-1105","标题")%>
                </td>
                <td class="td_form02">
</c:verbatim>
                    <h:inputText  id="title" value="#{sys_videoNewsBB.filebo.title}"></h:inputText>
<c:verbatim>
                </td>
            </tr>

    <tr>
        <td class="td_form01">
             排序码
        </td>
        <td class="td_form02">
</c:verbatim>
            <h:inputText  id="seq" value="#{sys_videoNewsBB.filebo.seq}"></h:inputText>
<c:verbatim>
        </td>
    </tr>

            <tr>
                <td class="td_form01">
                 <%=LanguageSupport.getResource("XTGL-1336","标题图片")%>
                 </td>
                <td class="td_form02" align="left">
        </c:verbatim>
                    <h:graphicImage height="120" width="160" value="/file/videoNews/#{sys_videoNewsBB.filebo.iconfileName}" rendered="#{sys_videoNewsBB.filebo.iconfileName!=null && sys_videoNewsBB.filebo.iconfileName!=''}"></h:graphicImage>
                    <c:verbatim><br></c:verbatim>
                    <h:inputHidden id="iconFileInput" value="#{sys_videoNewsBB.filebo.iconfileName}" ></h:inputHidden>
                    <x:inputFileUpload id="iconFile"   styleClass="input" value="#{sys_videoNewsBB.iconFile}"  storage="file" size="25" />
        <c:verbatim>
                </td>
            </tr>

            <tr>
                <td class="td_form01">
                 <%=LanguageSupport.getResource("XTGL-1336","视频文件")%>
                 </td>
                <td class="td_form02" align="left">
</c:verbatim>
                    <h:inputText id="excelFileInput" style="width:300px" readonly="true" value="#{sys_videoNewsBB.filebo.fileName}"></h:inputText>
                    <c:verbatim><br></c:verbatim>
                    <x:inputFileUpload id="excelFile"   styleClass="input" value="#{sys_videoNewsBB.excelFile}"  storage="file" size="25" />
<c:verbatim>
                </td>
            </tr>
        </table>
    <table width="98%">
        <tr>
            <td align="right">
</c:verbatim>
                <h:commandButton value="发布" onclick="return doCheck();" action="#{sys_videoNewsBB.save}" styleClass="button01" />
                <h:commandButton value="返回"  type="button" onclick="window.close()" styleClass="button01" />
<c:verbatim>
            </td>
        </tr>
    </table>
</c:verbatim>
</h:form>
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
