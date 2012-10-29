<%@ page import="com.hr319wg.user.util.MenuObj" %>
<%@ page import="com.hr319wg.util.CommonFuns" %>
<%@ page import="javax.servlet.jsp.JspWriter" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>

<%!
    private int subMenuCount = 0;
    private MenuObj menu;
    private String moduleId;
    private Hashtable hashMenus;
    public String url;
    public String lang=LanguageSupport.CN;

    /**
     *
     * @param pMenu         //���˵�����
     * @param pMenuName     //���˵��ڽű���չ�ֵ�����
     * @param out
     * @param isFirstLoad  �Ƿ���һ���˵�����
     */
    private void LoadChildMenu(MenuObj pMenu, String pMenuName, JspWriter out, boolean isFirstLoad) {
        Hashtable ht = new Hashtable();
        CommonFuns.filterNull(pMenuName);
        List list = pMenu.getMenus();

        try {
            StringBuffer sbf;
            if (list == null) return;
            for (int i = 0; i < list.size(); i++) {
                MenuObj cmenu = (MenuObj) list.get(i);
                String showName=CommonFuns.filterNull(cmenu.getName());
                if (LanguageSupport.CN.equals(lang) && cmenu.getNameCN()!=null && !"".equals(cmenu.getNameCN())) showName=cmenu.getNameCN();
                else if (LanguageSupport.TW.equals(lang) && cmenu.getNameTW()!=null && !"".equals(cmenu.getNameTW())) showName=cmenu.getNameTW();
                else if (LanguageSupport.EN.equals(lang) && cmenu.getNameEN()!=null && !"".equals(cmenu.getNameEN())) showName=cmenu.getNameEN();

                sbf = new StringBuffer();
                String newMenuName;
                String target = "";

                if ("".equals(pMenuName)) {                           //��һ�����˵�
                    newMenuName = "m" + cmenu.getOperateId();
                    sbf.append(newMenuName).append("=");
                    if (cmenu.getMenus() != null && cmenu.getMenus().size() != 0) {
                        sbf.append("new mMenu('")
                                .append(showName)
                                .append("', '', 'self', '").append(cmenu.getWebIcon()).append("', '', '', '3');");
                    } else {
                        if ("blank".equals(cmenu.getTarget())) {
                            target = "blank";
                        } else {
                            target = "main";
                        }
                        sbf.append("new mMenu('")
                                .append(showName)
                                .append("', \"")
                                .append(cmenu.getUrl())
                                .append("\", '" + target + "', '").append(cmenu.getWebIcon()).append("', '', '', '3');");
                    }
                    out.println(sbf.toString());
                    LoadChildMenu(cmenu, newMenuName, out, true);
                } else {
                    subMenuCount += 1;
                    //�����˵������ֱ��밴��˳��
                    newMenuName = "msub" + Integer.toString(subMenuCount);
                    ht.put(cmenu.getOperateId(), newMenuName);  // ��¼����
                    sbf.append(newMenuName).append("=");
                    if (cmenu.getMenus() != null && cmenu.getMenus().size() != 0) {
                        //���������߸��¼������Ӳ˵��Ĳ˵�
                        sbf.append("new mMenuItem('")
                                .append(showName)
                                .append("','','self',false,'','1','").append(cmenu.getWebIcon()).append("','','','');");

                    } else {
                        if ("blank".equals(cmenu.getTarget())) {
                            target = "blank";
                        } else {
                            target = "main";
                        }

                        //���������߸��¼���û���Ӳ˵��Ĳ˵�
                        sbf.append("new mMenuItem('")
                                .append(showName)
                                .append("',\"")
                                .append(cmenu.getUrl())
                                .append("\",'" + target + "',false,'")
                                .append(cmenu.getName())
                                .append("',null,'").append(cmenu.getWebIcon()).append("','','','');");
                    }
                    out.println(sbf.toString());
                    if (isFirstLoad) {
                        //���˵�����
                        out.println(pMenuName + ".addItem(" + newMenuName + ");");
                    } else {
                        //�Ӳ˵�����
                        out.println(pMenuName + ".addsubItem(" + newMenuName + ");");
                    }
                    //�������˵�
                    if (i == list.size() - 1) {
                        String tmpNewMenuName;
                        for (int j = 0; j < list.size(); j++) {
                            cmenu = (MenuObj) list.get(j);
                            tmpNewMenuName = ht.get(cmenu.getOperateId()).toString();  //ȡ�ϼ��˵�������
                            LoadChildMenu(cmenu, tmpNewMenuName, out, false);
                        }
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
%>