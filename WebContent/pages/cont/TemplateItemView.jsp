<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");
%>
<html>
<head>
<title></title>
    <link href="/css/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" language="javascript" src="/js/Appclient.js"></script>
</head>

<body>
<table width="100%" border="0" class="td_title" cellspacing="0" cellpadding="0">
  <tr >
    <td><img src="/images/tips.gif" alt="">模板可用指标列表</td>
    <td align="right">
        <input type="button" value="关闭" class="button01" onclick="window.close()">
    </td>
  </tr>
</table>

<table width="300" border="0" align="center" id="dataList">
  <tr>
    <td><strong>名称</strong></td>
    <td><strong>模板指标</strong></td>
    <td><strong>对应指标</strong></td>
  </tr>

  <tr>
    <td><strong>甲方名称</strong></td>
    <td>&lt;甲方名称&gt;</td>
  </tr>

  <tr>
    <td><strong>甲方地址</strong></td>
    <td>&lt;甲方地址&gt;</td>
  </tr>

  <tr>
    <td><strong>法人代表</strong></td>
    <td>&lt;法人代表&gt;</td>
  </tr>
  <tr>
    <td><strong>姓名</strong></td>
    <td>&lt;姓名&gt;</td>
  </tr>
  <tr>
    <td><strong>性别</strong></td>
    <td>&lt;性别&gt;</td>
  </tr>
    <tr>
    <td><strong>文化程度</strong></td>
    <td>&lt;文化程度&gt;</td>
  </tr>
  <tr>
    <td><strong>民族</strong></td>
    <td>&lt;民族&gt;</td>
  </tr>
  <tr>
    <td><strong>出生日期</strong></td>
    <td>&lt;出生日期&gt;</td>
  </tr>

  <tr>
    <td><strong>居民身份证号码</strong></td>
    <td>&lt;居民身份证号码&gt;</td>
    <td>A001077</td>
  </tr>

  <tr>
    <td><strong>其他有效证件名称</strong></td>
    <td>&lt;其他有效证件名称&gt;</td>
      <td>A001710</td>
  </tr>

  <tr>
    <td><strong>其他有效证件号码</strong></td>
    <td>&lt;其他有效证件号码&gt;</td>
      <td>A001711</td>
  </tr>


  <tr>
      <td><strong>户籍类型</strong></td>
      <td>&lt;户籍类型&gt;</td>
      <td>A090700</td>
  </tr>

  <tr>
      <td><strong>户口所在地</strong></td>
      <td>&lt;户口所在地&gt;</td>
      <td>A090701</td>
  </tr>

  <tr>
      <td><strong>本地家庭住址</strong></td>
      <td>&lt;本地家庭住址&gt;</td>
      <td>A080721</td>
  </tr>

  <tr>
      <td><strong>本地邮政编码</strong></td>
      <td>&lt;本地邮政编码&gt;</td>
      <td>A080735</td>
  </tr>

  <tr>
      <td><strong>原籍家庭住址</strong></td>
      <td>&lt;原籍家庭住址&gt;</td>
      <td>A090702</td>
  </tr>

  <tr>
      <td><strong>原籍邮政编码</strong></td>
      <td>&lt;原籍邮政编码&gt;</td>
      <td>A090703</td>
  </tr>

    <tr>
    <td><strong>参加工作时间</strong></td>
    <td>&lt;参加工作时间&gt;</td>
  </tr>
    <tr>
    <td><strong>到公司工作时间</strong></td>
    <td>&lt;到公司工作时间&gt;</td>
  </tr>
    <tr>
    <td><strong>乙方居住地址</strong></td>
    <td>&lt;乙方居住地址&gt;</td>
  </tr>
  <tr>
    <td><strong>邮政编码</strong></td>
    <td>&lt;邮政编码&gt;</td>
  </tr>
  <tr>
    <td><strong>政治面貌</strong></td>
    <td>&lt;政治面貌&gt;</td>
  </tr>
  <tr>
    <td><strong>所在部门</strong></td>
    <td>&lt;所在部门&gt;</td>
  </tr>
  <tr>
    <td><strong>所在机构</strong></td>
    <td>&lt;所在机构&gt;</td>
  </tr>
  <tr>
    <td><strong>合同编号</strong></td>
    <td>&lt;合同编号&gt;</td>
  </tr>
  <tr>
    <td><strong>合同期限类型</strong></td>
    <td>&lt;合同期限类型&gt;</td>
  </tr>
  <tr>
    <td><strong>合同起始时间</strong></td>
    <td>&lt;合同起始时间&gt;</td>
  </tr>
   <tr>
    <td><strong>合同终止时间</strong></td>
    <td>&lt;合同终止时间&gt;</td>
  </tr>
  <tr>
    <td><strong>服务期起始时间</strong></td>
    <td>&lt;服务期起始时间&gt;</td>
  </tr>
  <tr>
    <td><strong>服务期终止时间</strong></td>
    <td>&lt;服务期终止时间&gt;</td>
  </tr>
  <tr>
    <td><strong>见习期终止时间</strong></td>
    <td>&lt;见习期终止时间&gt;</td>
  </tr>
  <tr>
    <td><strong>试用期终止时间</strong></td>
    <td>&lt;试用期终止时间&gt;</td>
  </tr>
  <tr>
    <td><strong>合同履行地</strong></td>
    <td>&lt;合同履行地&gt;</td>
  </tr>
  <tr>
    <td><strong>工作岗位</strong></td>
    <td>&lt;工作岗位&gt;</td>
  </tr>
    <tr>
    <td><strong>岗位禁忌</strong></td>
    <td>&lt;岗位禁忌&gt;</td>
  </tr>
  <tr>
    <td><strong>工作内容</strong></td>
    <td>&lt;工作内容&gt;</td>
  </tr>

  <tr>
    <td><strong>工时制度</strong></td>
    <td>&lt;工时制度&gt;</td>
  </tr>
  <tr>
    <td><strong>劳动报酬形式</strong></td>
    <td>&lt;劳动报酬形式&gt;</td>
  </tr>
  <tr>
    <td><strong>工资构成</strong></td>
    <td>&lt;工资构成&gt;</td>
  </tr>
  <tr>
    <td><strong>发薪日</strong></td>
    <td>&lt;发薪日&gt;</td>
  </tr>
  <tr>
    <td><strong>试用期工资标准</strong></td>
    <td>&lt;试用期工资标准&gt;</td>
  </tr>
  <tr>
    <td><strong>工资标准</strong></td>
    <td>&lt;工资标准&gt;</td>
  </tr>
  <tr>
    <td><strong>基本工资标准</strong></td>
    <td>&lt;基本工资标准&gt;</td>
  </tr>
  <tr>
    <td><strong>绩效工资标准</strong></td>
    <td>&lt;绩效工资标准&gt;</td>
  </tr>
  <tr>
    <td><strong>竞业限制期限</strong></td>
    <td>&lt;竞业限制期限&gt;</td>
  </tr>
  <tr>
    <td><strong>合同违约金额</strong></td>
    <td>&lt;合同违约金额&gt;</td>
  </tr>
  <tr>
    <td><strong>合同期限</strong></td>
    <td>&lt;合同期限&gt;</td>
  </tr>
  <tr>
    <td><strong>见习期期限</strong></td>
    <td>&lt;见习期期限&gt;</td>
  </tr>
  <tr>
    <td><strong>服务期期限</strong></td>
    <td>&lt;服务期期限&gt;</td>
  </tr>
  <tr>
    <td><strong>经济补偿金额</strong></td>
    <td>&lt;经济补偿金额&gt;</td>
  </tr>
  <tr>
    <td><strong>医疗补助费</strong></td>
    <td>&lt;医疗补助费&gt;</td>
  </tr>
  <tr>
    <td><strong>一次性补贴金额</strong></td>
    <td>&lt;一次性补贴金额&gt;</td>
  </tr>
  <tr>
    <td><strong>其他费用</strong></td>
    <td>&lt;其他费用&gt;</td>
  </tr>
  <tr>
    <td><strong>实际应付金额</strong></td>
    <td>&lt;实际应付金额&gt;</td>
  </tr>
  <tr>
    <td><strong>主合同生效时间</strong></td>
    <td>&lt;主合同生效时间&gt;</td>
  </tr>
  <tr>
    <td><strong>主合同编号</strong></td>
    <td>&lt;主合同编号&gt;</td>
  </tr>
  <tr>
    <td><strong>终止或解除合同时间</strong></td>
    <td>&lt;终止或解除合同时间&gt;</td>
  </tr>
  <tr>
    <td><strong>合同变更时间</strong></td>
    <td>&lt;合同变更时间&gt;</td>
  </tr>
  <tr>
    <td><strong>中止合同约定起始时间</strong></td>
    <td>&lt;中止合同约定起始时间&gt;</td>
  </tr>
  <tr>
    <td><strong>中止合同约定结束时间</strong></td>
    <td>&lt;中止合同约定结束时间&gt;</td>
  </tr>
  <tr>
    <td><strong>恢复履行中止合同时间</strong></td>
    <td>&lt;恢复履行中止合同时间&gt;</td>
  </tr>
   
</table>
<script type="text/javascript">
   setDataTableOver("dataList");
</script>
</body>
</html>
