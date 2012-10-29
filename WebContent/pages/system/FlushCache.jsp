<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.util.CommonFuns"%>
<%@ page import="com.hr319wg.sys.cache.SysCache"%>
<%@ page import="com.hr319wg.sys.dao.ParameterDAO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<%@ page import="com.hr319wg.common.pojo.vo.User" %>
<%@ page import="com.hr319wg.common.Constants" %>

<html>
<head>
    <title></title>
    <link href="../../css/style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
    <script type="text/javascript">
        //document.oncontextmenu=function(e){return false;}
    </script>
    
</head>
<%
    User user = (User) session.getAttribute(Constants.USER_INFO);
    String act = CommonFuns.filterNull(request.getParameter("act"));
    String type = CommonFuns.filterNull(request.getParameter("type"));
    try {
        if ("sys".equals(type) && "refresh".equals(act)) {
            ParameterDAO dao = (ParameterDAO) SysContext.getBean("sys_parameterDAO");
            dao.syncParameterFromDB();
            LanguageSupport.LoadStrings();
            LanguageSupport.LoadParamters();

            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }

        if ("org".equals(type) && "refresh".equals(act)) {
            SysCache.loadOrgMap();
            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }
        else if ("wage".equals(type) && "refresh".equals(act)) {
            SysCache.loadWageUnitMap();
            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }
        else if ("party".equals(type) && "refresh".equals(act)) {
            SysCache.loadPartyMap();
            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }
        else if ("post".equals(type) && "refresh".equals(act)) {
            SysCache.loadPostMap();
            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }
        else if ("info".equals(type) && "refresh".equals(act)) {
            SysCache.loadInfoSetMap();
            SysCache.loadInfoItemMap();
            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }
        else if ("code".equals(type) && "refresh".equals(act)) {
            SysCache.loadCodeSetMap();
            SysCache.loadCodeItemMap();
            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }
        else if ("allperson".equals(type) && "refresh".equals(act)) {
            //SysCache.loadPersonMap();
            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }
        else if ("person".equals(type) && "refresh".equals(act)) {
            SysCache.setPerson(request.getParameter("pid"), SysCache.OPER_UPDATE);
            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }
        else if ("releaseperson".equals(type) && "refresh".equals(act)) {
            SysCache.personCodeMap.clear();
            SysCache.personMap.clear();
            out.println("<script>alert('ˢ�³ɹ�');</script>");
        }
        else if ("releaseWageSet".equals(type) && "refresh".equals(act)) {
            SysCache.wageSetMap.clear();
            out.println("<script>alert('ˢ��н�����׳ɹ�');</script>");
        }
        else if ("releaseFont".equals(type) && "refresh".equals(act)) {
            SysCache.loadSeldomFont();
            out.println("<script>alert('ˢ�����������ɹ�');</script>");
        }
        else if ("releaseOperate".equals(type) && "refresh".equals(act)) {
            SysCache.loadOperatorMap();
            SysCache.loadSelfOperatorMap();
            out.println("<script>alert('ˢ�¹������ɹ�');</script>");
        }
        else if ("releaseDataInterface".equals(type) && "refresh".equals(act)) {
            SysCache.loadDataInterface();
            out.println("<script>alert('ˢ�����ݽӿڽṹ�ɹ�');</script>");
        }
    }
    catch (Exception e) {
        out.println("<script>alert('" + e.getMessage() + "');</script>");
    }
%>
<body topmargin="0" leftmargin="0">
<table width="100%" border="0" cellspacing="6" cellpadding="0">
    <tr>
        <td class="td_title">
            <img src="/images/tips.gif" alt="">
            <%=LanguageSupport.getResource("XTGL-1014","�������",user.getLoginLang())%>
          </td>
    </tr>
</table>
<br>
<center>
    <table class="table03" border="1" width="800">
        <tr class="td_top" >
            <td >&nbsp;</td>
            <td> <%=LanguageSupport.getResource("XTGL-1015","����",user.getLoginLang())%>  </td>
            <td><%=LanguageSupport.getResource("YXGL-1026"," ����",user.getLoginLang())%>  </td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>0</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
               <%=LanguageSupport.getResource("XTGL-1016","����ϵͳ����",user.getLoginLang())%>
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=sys&act=refresh'" ></td>
        </tr>

        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>1</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
             <%=LanguageSupport.getResource("XTGL-1017","������������������",user.getLoginLang())%>
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=org&act=refresh'" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>2</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
             <%=LanguageSupport.getResource("XTGL-1018","���ص���֯������",user.getLoginLang())%>
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=party&act=refresh'" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)> 3</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
             <%=LanguageSupport.getResource("XTGL-1019","���ط�н����������",user.getLoginLang())%>
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=wage&act=refresh'" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>4</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
              <%=LanguageSupport.getResource("XTGL-1020"," ���ظ�λ������",user.getLoginLang())%>
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=post&act=refresh'" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>5</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
             <%=LanguageSupport.getResource("XTGL-1021"," ����ָ�꼯ָ�������",user.getLoginLang())%>
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=info&act=refresh'" ></td>
        </tr>
        <tr class="td_middle" >
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>6</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
              <%=LanguageSupport.getResource("XTGL-1022","���ش��뼯���������",user.getLoginLang())%>
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=code&act=refresh'" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>7</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
              <%=LanguageSupport.getResource("XTGL-1025","�ͷ�ȫ����Ա����",user.getLoginLang())%>
           
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=releaseperson&act=refresh'" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>8</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
              <%=LanguageSupport.getResource("XTGL-1023","������Ա���棺��Ա����",user.getLoginLang())%>
            <input type="text" name="pe" size="10"></td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=person&act=refresh&pid='+document.all('pe').value" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>9</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
                ��������
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=releaseWageSet&act=refresh'" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>10</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
                ���������ֿ�
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=releaseFont&act=refresh'" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>11</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
                ���¹�����
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=releaseOperate&act=refresh'" ></td>
        </tr>
        <tr class="td_middle">
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>12</td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)>
                �������ݽӿڽṹ
            </td>
            <td onMouseOver=tdlinkOver(this) onMouseOut=tdlinkOut(this)><input type="button" class='button01'value="ִ��" onclick="location.href='FlushCache.jsp?type=releaseDataInterface&act=refresh'" ></td>
        </tr>

    </table>
</center>
</body>
</html>