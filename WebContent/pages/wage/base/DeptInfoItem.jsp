<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page import="java.util.List"%>
<%@ page import="com.hr319wg.sys.pojo.bo.InfoItemBO" %>

<%@ include file="../../include/taglib.jsp" %>


<html>
<head>
    <title>ѡ����ָ����</title>
</head>

<body>
<div id="dt"></div>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/tree.js"></script>
<script language="javascript">
    //��������ͼƬ����
    var images = new new getTreeImage();
    //��ʼ����
    var tree = new newtree(images, 16, dt);
    root = tree.root;
<%

    String str = "TB732 = tree.add(root,'last','����н�ʷ�����Ϣ�Ӽ�', 'TB732','','','fold','','');";
    out.println(str);

    //��ָ��
    List list=SysCacheTool.queryInfoItemBySetId("B732");
    for(int i=0;i<list.size();i++){
       InfoItemBO ib=(InfoItemBO)list.get(i);
       if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(ib.getItemProperty())) continue;
       String key=ib.getItemId();
       String key2=ib.getSetId()+"."+ib.getItemId()+"|����н�ʷ�����Ϣ�Ӽ�."+ib.getItemName();
       String alt=ib.getItemDataType()+"|"+ib.getItemCodeSet();
       String icon="file";
       str="tree.add(TB732, 'last', '"+ib.getItemName()+"', '"+key+"', '"+key2+"', '"+alt+"', '"+icon+"', '', '');";
       out.println(str);
    }

%>

tree.onclick = function(srcNode) {
    key=srcNode.key2;
    alt=srcNode.alt;
    //setId+"."+itemId | setName+"."+name |   datatype | codeSetId
    window.returnValue=key+"|"+alt;
    window.close();
}
</script>
</body>
</html>