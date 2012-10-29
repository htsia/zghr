<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.Constants" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgBO" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="java.util.*" %>
<%@ page import="com.hr319wg.org.pojo.bo.OrgTemplateItemBO" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.hr319wg.org.ucc.impl.OrgTemplateUCC" %>

<%
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
    response.setContentType("text/xml;charset=GBK");

    String superId = request.getParameter("superId");                           // �ϼ�
    String rightFlag = CommonFuns.filterNull(request.getParameter("rightFlag"));     // Ȩ�޷�ʽ  //   0-��ʹ�� 1-ʹ�ò�ѯȨ�޹���,2-ʹ��ά��Ȩ�޹���
    String rootId = CommonFuns.filterNull(request.getParameter("rootId"));           // ���ڵ�
    String cancelFlag = CommonFuns.filterNull(request.getParameter("cancelFlag"));   // �Ƿ���ʾ��������
    String showGroup = CommonFuns.filterNull(request.getParameter("showGroup"));    //   �Ƿ���ʾ����
    String onlyOrg= CommonFuns.filterNull(request.getParameter("onlyOrg"));          //  ֻ��ʾ����
    List  list = new ArrayList();
    String templateId=(String)session.getAttribute("templateId");
    
    OrgTemplateUCC rc = null;
    try {
        rc = (OrgTemplateUCC) SysContext.getBean("orgtemplateucc");
	    if ("-1".equals(superId)&&null!=templateId&&!"".equals(templateId)){
	       
	    	OrgTemplateItemBO o= rc.getRootOrgTemplateItemByTemplatId(templateId);
	        list.add(o);
	    }
	    else{
	        list = rc.getAllOrgTemplateItemBOBySuperId(superId);
	    }
    }
    catch (Exception e) {
		e.printStackTrace();
    }
    OrgTemplateItemBO org=rc.findOrgTemplateItemBOById(superId);
    String icon = "";
    String childnum = "";
    out.println("<?xml version=\"1.0\" encoding=\"GBK\" ?>");
    out.println("<tree>");

    // ���ؽ��
    if (list != null) {
        for (int i = 0; i < list.size(); i++) {
        	OrgTemplateItemBO o = (OrgTemplateItemBO) list.get(i);
            if (!"1".equals(showGroup) && OrgBO.GROUPTYPE.equals(o.getOrgType())){  // ���˵�����
                continue;
            }
            if ("1".equals(onlyOrg) && !OrgBO.UNITTYPE.equals(o.getOrgType())){      // ���˲���
                continue;
            }
            childnum = "0";
            out.println("<org>");

            //�ж��¼��Ƿ��нڵ�,�����������ʾ�������� �����¼��Ƿ��ǳ�������
            if (o != null) {
                List list1 =rc.getAllOrgTemplateItemBOBySuperId(o.getOrgId());
                
                if (OrgBO.UNITTYPE.equals(o.getOrgType())){
                    icon="org";
                }
                else if (OrgBO.DEPTTYPE.equals(o.getOrgType())){
                    icon="dept";
                }
                else if (OrgBO.GROUPTYPE.equals(o.getOrgType())){
                    icon="group";
                }
                else if (OrgBO.VIRTUALTYPE.equals(o.getOrgType())){
                    icon="virtual";
                }
                else{
                    icon="folder";
                }
                out.println("<key>" + o.getOrgId() + "</key>");
                out.println("<name>" + o.getOrgName() + "</name>");
                out.println("<id>" + o.getOrgId() + "</id>");
                out.println("<cancel>" + "0" + "</cancel>");
                out.println("<icon>" + icon + "</icon>");
                out.println("<childnum>" + list1.size() + "</childnum>");

            }
            out.println("</org>");
        }
    }

    if (org != null) {
        out.println("<supertree>");
        out.println("<treeid>" + org.getOrgId() + "</treeid>");
        out.println("</supertree>");
    }

    out.println("</tree>");
%>