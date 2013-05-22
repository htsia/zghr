<%@ page import="com.hr319wg.sys.pojo.bo.CodeItemBO" %>
<%@ page import="com.hr319wg.sys.cache.SysCacheTool" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("progma", "no-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

    CodeItemBO c02020001 = SysCacheTool.findCodeItem("","02020001");
    CodeItemBO c02020002 = SysCacheTool.findCodeItem("","02020002");
    CodeItemBO c02020003 = SysCacheTool.findCodeItem("","02020003");
%>

    <script type="text/javascript">
        function hide(tdname){
            var td=document.all(tdname);
            var i=0;
            for(i=0;i<td.length;i++) td[i].style.display="none";
        }
        function doCheck(){
            if (document.all('form1:name').innerText=="单位名称:"){
                alert("没有选择单位!");
                return false;
            }
			
            var wrong=false;
            var ratetr=$(".table03 tr");
            ratetr.each(function(tr, trdate){
            	if(tr>1 && !wrong){
            		var ratetd=$(trdate).find("td:visible");
            		var insname=null;
            		ratetd.each(function(td, tddate){
            			if(td==0){
            				insname=$(tddate).html();
            			}else if(td==1){
            				if($(tddate).find("select").val()==-1){
            					alert("请选择"+insname+"计算精度");
            					wrong=true;
            					return false;
            				}
            			}else if(td>1){
            				var v=$(tddate).find("input").val().trim();
            				$(tddate).find("input").val(v);
            				var title="";
            				if(td==2){
            					title="单位交费比例";
            				}else if(td==3){
            					title="个人交费比例";            					
            				}else if(td==4){
            					title="上限";            					
            				}else if(td==5){
            					title="下限";            					
            				}
            				if(v=='' || isNaN(v)){
            					alert(insname+title+"应为数字");
            					wrong=true;
            					return false;
            				}
            			}
            		});
            	}
            });
            return !wrong;
        }
   </script>

<x:saveState value="#{wage_unitBB}"/>
<h:form id="form1">
    <h:inputHidden  value="#{wage_unitBB.rateSet}"/>
    <f:verbatim>
    <table  width=98%>
      <tr>
        <td align="left" height=30 valign="middle">
    </f:verbatim>
            <h:outputText id="name"  escape="false" value="<strong>单位名称:</strong>#{wage_unitBB.unit.name}" />
     <f:verbatim>
        </td>
        <td align="right"  height=30 valign="middle">
      </f:verbatim>
           <h:commandButton styleClass="button01" value="保存" action="#{wage_unitBB.saveRate}"
                         onclick="return doCheck();"/>
            <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;"/>
     <f:verbatim>
        </td>
      </tr>
  </table>
  <table class="table03">
            <tr>
                <td  rowspan="2" class="td_top" width="100" align="center"><strong>项目</strong></td>
                <td  rowspan="2" align="center" width="100" class="td_top"><strong>计算精度</strong></td>
                <%
                    out.println("<td  id='c02020001' align=\"center\" class=\"td_top\" colspan='4'><strong>"+c02020001.getItemName()+"</strong></td>");
                    out.println("<td  id='c02020002' align=\"center\" class=\"td_top\" colspan='4'><strong>"+c02020002.getItemName()+"</strong></td>");
                    out.println("<td  id='c02020003' align=\"center\" class=\"td_top\" colspan='4'><strong>"+c02020003.getItemName()+"</strong></td>");
                %>
            </tr>

            <tr>
                <td id='c02020001' width="100" align="center" class="td_top">单位交费比例</td>
                <td id='c02020001' width="100" align="center" class="td_top">个人交费比例</td>
                <td id='c02020001' width="100" align="center" class="td_top">上限(元)</td>
                <td id='c02020001' width="100" align="center" class="td_top">下限(元)</td>

                <td id='c02020002' width="100" align="center" class="td_top">单位交费比例</td>
                <td id='c02020002' width="100" align="center" class="td_top">个人交费比例</td>
                <td id='c02020002' width="100" align="center" class="td_top">上限(元)</td>
                <td id='c02020002' width="100" align="center" class="td_top">下限(元)</td>

                <td align="center" width="100" id='c02020003' class="td_top">单位交费比例</td>
                <td align="center" width="100" id='c02020003' class="td_top">个人交费比例</td>
                <td align="center" width="100" id='c02020003'class="td_top">上限(元)</td>
                <td align="center" width="100" id='c02020003' class="td_top">下限(元)</td>
           </tr>

            <tr>
                <td width="90px" class="td_top" align="center">养老保险</td>
                <td width="80px">
            </f:verbatim>
                    <h:selectOneMenu id="precise_end"  value="#{wage_unitBB.unit.precise_end}">
                        <c:selectItem itemValue="-1" itemLabel="--请选择--"></c:selectItem>
                        <c:selectItem itemValue="0" itemLabel="元"></c:selectItem>
                        <c:selectItem itemValue="1" itemLabel="角"></c:selectItem>
                        <c:selectItem itemValue="2" itemLabel="分"></c:selectItem>
                    </h:selectOneMenu>
<f:verbatim>
                </td>

                <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="endowment_unit"  style="width:60px" value="#{wage_unitBB.unit.endowment_unit}" />
<f:verbatim>
                </td>
                <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="endowment_person"  style="width:60px" value="#{wage_unitBB.unit.endowment_person}" />
<f:verbatim>
                </td>
                <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="maxRate"  style="width:60px" value="#{wage_unitBB.unit.maxRate_end}" />
 <f:verbatim>
                </td>
                <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="minRate"  style="width:60px" value="#{wage_unitBB.unit.minRate_end}" />
<f:verbatim>
                </td>
                <td id='c02020002' >
</f:verbatim>
                    <h:inputText id="endowment_unit_rl"  style="width:60px" value="#{wage_unitBB.unit.endowment_unit_rl}" />
    <f:verbatim>
                    </td>
                    <td id='c02020002' >
    </f:verbatim>
                    <h:inputText id="endowment_person_rl"  style="width:60px" value="#{wage_unitBB.unit.endowment_person_rl}" />
        <f:verbatim>
                        </td>
                        <td id='c02020002' >
        </f:verbatim>
                    <h:inputText id="maxRate_rl"  style="width:60px" value="#{wage_unitBB.unit.maxRate_end_rl}" />
            <f:verbatim>
                            </td>
                            <td id='c02020002' >
            </f:verbatim>
                    <h:inputText id="minRate_rl"  style="width:60px" value="#{wage_unitBB.unit.minRate_end_rl}" />
                <f:verbatim>
                                </td>
                       <td id='c02020003'>
                </f:verbatim>
                    <h:inputText id="endowment_unit_al"  style="width:60px" value="#{wage_unitBB.unit.endowment_unit_al}" />
                    <f:verbatim>
                                    </td>
                   <td id='c02020003'>
                    </f:verbatim>
                    <h:inputText id="endowment_person_al"  style="width:60px" value="#{wage_unitBB.unit.endowment_person_al}" />
               <f:verbatim>
                    </td>
                    <td id='c02020003'>
                </f:verbatim>
                    <h:inputText id="maxRate_al"  style="width:60px" value="#{wage_unitBB.unit.maxRate_end_al}" />
                <f:verbatim>
                     </td>
                   <td id='c02020003'>
                 </f:verbatim>
                    <h:inputText id="minRate_al"  style="width:60px" value="#{wage_unitBB.unit.minRate_end_al}" />
<f:verbatim>
                </td>
           </tr>

            <tr>
                <td width=90px class="td_top" align="center">医疗保险</td>
                <td>
</f:verbatim>
                    <h:selectOneMenu id="precise_med"  value="#{wage_unitBB.unit.precise_med}">
                        <c:selectItem itemValue="-1" itemLabel="--请选择--"></c:selectItem>
                        <c:selectItem itemValue="0" itemLabel="元"></c:selectItem>
                        <c:selectItem itemValue="1" itemLabel="角"></c:selectItem>
                        <c:selectItem itemValue="2" itemLabel="分"></c:selectItem>
                    </h:selectOneMenu>
<f:verbatim>
                </td>
                <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="medicare_unit" style="width:60px"  value="#{wage_unitBB.unit.medicare_unit}" />
    <f:verbatim>
                    </td>
                    <td id='c02020001' >
    </f:verbatim>
                    <h:inputText id="medicare_person" style="width:60px"  value="#{wage_unitBB.unit.medicare_person}" />
        <f:verbatim>
                        </td>
                        <td id='c02020001' >
        </f:verbatim>
                     <h:inputText id="medicare_max" style="width:60px"  value="#{wage_unitBB.unit.maxRate_med}" />
            <f:verbatim>
                            </td>
                            <td id='c02020001' >
            </f:verbatim>
                    <h:inputText id="medicare_min" style="width:60px"  value="#{wage_unitBB.unit.minRate_med}" />
                <f:verbatim>
                                </td>
                                <td id='c02020002' >
                </f:verbatim>

                    <h:inputText id="medicare_unit_rl" style="width:60px"  value="#{wage_unitBB.unit.medicare_unit_rl}" />
<f:verbatim>
            </td>
            <td id='c02020002' >
</f:verbatim>
                    <h:inputText id="medicare_person_rl" style="width:60px"  value="#{wage_unitBB.unit.medicare_person_rl}" />
    <f:verbatim>
                </td>
                <td id='c02020002' >
    </f:verbatim>
                     <h:inputText id="medicare_max_rl" style="width:60px"  value="#{wage_unitBB.unit.maxRate_med_rl}" />
        <f:verbatim>
                    </td>
                    <td id='c02020002' >
        </f:verbatim>
                    <h:inputText id="medicare_min_rl" style="width:60px"  value="#{wage_unitBB.unit.minRate_med_rl}" />
<f:verbatim>
    </td>
    <td id='c02020003'>
</f:verbatim>
                    <h:inputText id="medicare_unit_al" style="width:60px"  value="#{wage_unitBB.unit.medicare_unit_al}" />
    <f:verbatim>
        </td>
        <td id='c02020003'>
    </f:verbatim>
                    <h:inputText id="medicare_person_al" style="width:60px"  value="#{wage_unitBB.unit.medicare_person_al}" />
        <f:verbatim>
            </td>
            <td id='c02020003'>
        </f:verbatim>
                     <h:inputText id="medicare_max_al" style="width:60px"  value="#{wage_unitBB.unit.maxRate_med_al}" />
            <f:verbatim>
                </td>
                <td id='c02020003'>
            </f:verbatim>
                    <h:inputText id="medicare_min_al" style="width:60px"  value="#{wage_unitBB.unit.minRate_med_al}" />
<f:verbatim>
                </td>
           </tr>

            <tr>
                <td width=90px class="td_top" align="center">失业保险</td>
                <td>
</f:verbatim>
                    <h:selectOneMenu id="precise_unemployment"  value="#{wage_unitBB.unit.precise_unemployment}">
                        <c:selectItem itemValue="-1" itemLabel="--请选择--"></c:selectItem>
                        <c:selectItem itemValue="0" itemLabel="元"></c:selectItem>
                        <c:selectItem itemValue="1" itemLabel="角"></c:selectItem>
                        <c:selectItem itemValue="2" itemLabel="分"></c:selectItem>
                    </h:selectOneMenu>
<f:verbatim>
                </td>
                <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="unemployment_unit" style="width:60px"  value="#{wage_unitBB.unit.unemployment_unit}" />
    <f:verbatim>
                    </td>
                    <td id='c02020001' >
    </f:verbatim>
                    <h:inputText id="unemployment_person" style="width:60px"  value="#{wage_unitBB.unit.unemployment_person}" />
        <f:verbatim>
                        </td>
                        <td id='c02020001' >
        </f:verbatim>
                    <h:inputText id="unemp_max" style="width:60px"  value="#{wage_unitBB.unit.maxRate_unemp}" />
            <f:verbatim>
                            </td>
                            <td id='c02020001' >
            </f:verbatim>
                    <h:inputText id="unemp_min" style="width:60px"  value="#{wage_unitBB.unit.minRate_unemp}" />
<f:verbatim>
                </td>
                <td id='c02020002' >
</f:verbatim>
                    <h:inputText id="unemployment_unit_rl" style="width:60px"  value="#{wage_unitBB.unit.unemployment_unit_rl}" />
    <f:verbatim>
                    </td>
                    <td id='c02020002' >
    </f:verbatim>
                    <h:inputText id="unemployment_person_rl" style="width:60px"  value="#{wage_unitBB.unit.unemployment_person_rl}" />
        <f:verbatim>
                        </td>
                        <td id='c02020002' >
        </f:verbatim>
                    <h:inputText id="unemp_max_rl" style="width:60px"  value="#{wage_unitBB.unit.maxRate_unemp_rl}" />
            <f:verbatim>
                            </td>
                            <td id='c02020002' >
            </f:verbatim>
                    <h:inputText id="unemp_min_rl" style="width:60px"  value="#{wage_unitBB.unit.minRate_unemp_rl}" />
                <f:verbatim>
                                </td>
                                <td id='c02020003'>
                </f:verbatim>
                    <h:inputText id="unemployment_unit_al" style="width:60px"  value="#{wage_unitBB.unit.unemployment_unit_al}" />
<f:verbatim>
            </td>
            <td id='c02020003'>
</f:verbatim>
                    <h:inputText id="unemployment_person_al" style="width:60px"  value="#{wage_unitBB.unit.unemployment_person_al}" />
    <f:verbatim>
                </td>
                <td  id='c02020003'>
    </f:verbatim>
                    <h:inputText id="unemp_max_al" style="width:60px"  value="#{wage_unitBB.unit.maxRate_unemp_al}" />
        <f:verbatim>
                    </td>
                    <td id='c02020003'>
        </f:verbatim>
                    <h:inputText id="unemp_min_al" style="width:60px"  value="#{wage_unitBB.unit.minRate_unemp_al}" />
 <f:verbatim>
                </td>
           </tr>

            <tr>
                <td width=90px class="td_top" align="center">生育保险</td>
                <td>
 </f:verbatim>
                    <h:selectOneMenu id="precise_procreate"  value="#{wage_unitBB.unit.precise_procreate}">
                        <c:selectItem itemValue="-1" itemLabel="--请选择--"></c:selectItem>
                        <c:selectItem itemValue="0" itemLabel="元"></c:selectItem>
                        <c:selectItem itemValue="1" itemLabel="角"></c:selectItem>
                        <c:selectItem itemValue="2" itemLabel="分"></c:selectItem>
                    </h:selectOneMenu>
 <f:verbatim>
                </td>
                <td id='c02020001' >
 </f:verbatim>
                    <h:inputText id="procreate_unit"  style="width:60px" value="#{wage_unitBB.unit.procreate_unit}" />
 <f:verbatim>
                </td>
                <td align="center" id='c02020001' >
                    -
                </td>
                <td id='c02020001' >
 </f:verbatim>
                    <h:inputText id="proc_max"  style="width:60px" value="#{wage_unitBB.unit.maxRate_proc}" />
<f:verbatim>
            </td>
            <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="proc_min"  style="width:60px" value="#{wage_unitBB.unit.minRate_proc}" />
    <f:verbatim>
                </td>
                <td id='c02020002' >
    </f:verbatim>
                    <h:inputText id="procreate_unit_rl"  style="width:60px" value="#{wage_unitBB.unit.procreate_unit_rl}" />
<f:verbatim>
                </td>
                <td align="center" id='c02020002' >
                    -
                </td>
                <td id='c02020002' >
</f:verbatim>
                    <h:inputText id="proc_max_rl"  style="width:60px"  value="#{wage_unitBB.unit.maxRate_proc_rl}" />
<f:verbatim>
                </td>
                <td id='c02020002'>
</f:verbatim>
                    <h:inputText id="proc_min_rl" style="width:60px"  value="#{wage_unitBB.unit.minRate_proc_rl}" />
<f:verbatim>
                </td>
                <td id='c02020003'>
</f:verbatim>
                    <h:inputText id="procreate_unit_al"  style="width:60px"  value="#{wage_unitBB.unit.procreate_unit_al}" />
<f:verbatim>
                </td>
                <td align="center" id='c02020003'>
                    -
                </td>
                <td id='c02020003'>
</f:verbatim>
                    <h:inputText id="proc_max_al"  style="width:60px"  value="#{wage_unitBB.unit.maxRate_proc_al}" />
<f:verbatim>
                </td>
                <td id='c02020003'>
</f:verbatim>
                    <h:inputText id="proc_min_al"  style="width:60px"  value="#{wage_unitBB.unit.minRate_proc_al}" />
<f:verbatim>
                </td>
           </tr>

            <tr>
                <td width=90px class="td_top" align="center">工伤保险</td>
                <td>
</f:verbatim>
                    <h:selectOneMenu id="precise_compo"  value="#{wage_unitBB.unit.precise_compo}">
                        <c:selectItem itemValue="-1" itemLabel="--请选择--"></c:selectItem>
                        <c:selectItem itemValue="0" itemLabel="元"></c:selectItem>
                        <c:selectItem itemValue="1" itemLabel="角"></c:selectItem>
                        <c:selectItem itemValue="2" itemLabel="分"></c:selectItem>
                    </h:selectOneMenu>
<f:verbatim>
                </td>
                <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="compo_unit"  style="width:60px" value="#{wage_unitBB.unit.compo_unit}" />
<f:verbatim>
                </td>
                <td align="center" id='c02020001' >
                    -
                </td>
                <td id='c02020001' >
</f:verbatim>
                     <h:inputText id="compo_max"  style="width:60px" value="#{wage_unitBB.unit.maxRate_compo}" />
<f:verbatim>
                </td>
                <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="compo_min"  style="width:60px" value="#{wage_unitBB.unit.minRate_compo}" />
<f:verbatim>
                </td>
                <td id='c02020002' >
</f:verbatim>
                    <h:inputText id="compo_unit_rl"  style="width:60px" value="#{wage_unitBB.unit.compo_unit_rl}" />
<f:verbatim>
                </td>
                <td align="center" id='c02020002' >
                    -
                </td>
                <td id='c02020002' >
</f:verbatim>
                     <h:inputText id="compo_max_rl"  style="width:60px" value="#{wage_unitBB.unit.maxRate_compo_rl}" />
<f:verbatim>
                </td>
                <td id='c02020002' >
</f:verbatim>
                    <h:inputText id="compo_min_rl"  style="width:60px" value="#{wage_unitBB.unit.minRate_compo_rl}" />
    <f:verbatim>
                    </td>
                    <td id='c02020003'>
    </f:verbatim>
                    <h:inputText id="compo_unit_al" style="width:60px"  value="#{wage_unitBB.unit.compo_unit_al}" />
<f:verbatim>
                </td>
                <td align="center" id='c02020003'>
                    -
                </td>
                <td  id='c02020003'>
</f:verbatim>
                     <h:inputText id="compo_max_al" style="width:60px"  value="#{wage_unitBB.unit.maxRate_compo_al}" />
<f:verbatim>
                </td>
                <td id='c02020003'>
</f:verbatim>
                    <h:inputText id="compo_min_al"  style="width:60px" value="#{wage_unitBB.unit.minRate_compo_al}" />
<f:verbatim>
                </td>
           </tr>

            <tr>
                <td width=90px class="td_top" align="center">住房公积金</td>
                <td>
</f:verbatim>
                    <h:selectOneMenu id="precise_housing"  value="#{wage_unitBB.unit.precise_housing}">
                        <c:selectItem itemValue="-1" itemLabel="--请选择--"></c:selectItem>
                        <c:selectItem itemValue="0" itemLabel="元"></c:selectItem>
                        <c:selectItem itemValue="1" itemLabel="角"></c:selectItem>
                        <c:selectItem itemValue="2" itemLabel="分"></c:selectItem>
                    </h:selectOneMenu>
<f:verbatim>
                </td>
                <td id='c02020001' >
</f:verbatim>
                    <h:inputText id="housing_unit"  style="width:60px" value="#{wage_unitBB.unit.housing_unit}" />
    <f:verbatim>
                    </td>
                    <td id='c02020001' >
    </f:verbatim>
                    <h:inputText id="housing_person"  style="width:60px" value="#{wage_unitBB.unit.housing_person}" />
        <f:verbatim>
                        </td>
                        <td id='c02020001' >
        </f:verbatim>
                    <h:inputText id="housing_max"  style="width:60px" value="#{wage_unitBB.unit.maxRate_house}" />
            <f:verbatim>
                            </td>
                            <td id='c02020001' >
            </f:verbatim>
                    <h:inputText id="housing_min"  style="width:60px" value="#{wage_unitBB.unit.minRate_house}" />
                <f:verbatim>
                                </td>
                                <td id='c02020002' >
                </f:verbatim>
                    <h:inputText id="housing_unit_rl"  style="width:60px" value="#{wage_unitBB.unit.housing_unit_rl}" />
                    <f:verbatim>
                                    </td>
                                    <td id='c02020002' >
                    </f:verbatim>
                    <h:inputText id="housing_person_rl"  style="width:60px" value="#{wage_unitBB.unit.housing_person_rl}" />
<f:verbatim>
                </td>
                <td id='c02020002' >
</f:verbatim>
                    <h:inputText id="housing_max_rl"  style="width:60px" value="#{wage_unitBB.unit.maxRate_house_rl}" />
    <f:verbatim>
                    </td>
                    <td id='c02020002'>
    </f:verbatim>
                    <h:inputText id="housing_min_rl"  style="width:60px" value="#{wage_unitBB.unit.minRate_house_rl}" />
        <f:verbatim>
                        </td>
                 <td id='c02020003'>
        </f:verbatim>
                    <h:inputText id="housing_unit_al"  style="width:60px" value="#{wage_unitBB.unit.housing_unit_al}" />
            <f:verbatim>
                            </td>
                 <td id='c02020003'>
            </f:verbatim>
                    <h:inputText id="housing_person_al"  style="width:60px" value="#{wage_unitBB.unit.housing_person_al}" />
                <f:verbatim>
                 </td>
                 <td id='c02020003'>
                </f:verbatim>
                    <h:inputText id="housing_max_al"  style="width:60px" value="#{wage_unitBB.unit.maxRate_house_al}" />
<f:verbatim>
                </td>
                <td id='c02020003'>
</f:verbatim>
                    <h:inputText id="housing_min_al"  style="width:60px" value="#{wage_unitBB.unit.minRate_house_al}" />
<f:verbatim>
                </td>
           </tr>

        </table>


</f:verbatim>
</h:form>
<script type="text/javascript">
    <%
       if (c02020001==null || "0".equals(c02020001.getItemStatus())) out.println("hide('c02020001');");
       if (c02020002==null || "0".equals(c02020002.getItemStatus())) out.println("hide('c02020002');");
       if (c02020003==null || "0".equals(c02020003.getItemStatus())) out.println("hide('c02020003');");
    %>


</script>