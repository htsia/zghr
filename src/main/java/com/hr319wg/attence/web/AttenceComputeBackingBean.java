package com.hr319wg.attence.web;

import com.hr319wg.common.web.BaseBackingBean;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.wage.ucc.*;
import com.hr319wg.wage.pojo.bo.WageSetItemBO;
import com.hr319wg.wage.pojo.bo.WageSetBO;
import com.hr319wg.wage.pojo.bo.WageDeptPowerBO;
import com.hr319wg.wage.pojo.bo.WageDeptBO;
import com.hr319wg.user.ucc.IUserReportUCC;
import com.hr319wg.user.ucc.IUserQryUCC;
import com.hr319wg.sys.api.WageAPI;
import com.hr319wg.sys.api.QueryAPI;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.emp.ucc.IPersonUCC;
import com.hr319wg.insurace.ucc.IBaseSetUCC;
import com.hr319wg.insurace.pojo.bo.BaseSetBO;
import com.hr319wg.util.CommonFuns;
import com.hr319wg.util.CodeUtil;
import com.hr319wg.qry.util.QueryConstants;

import javax.faces.model.SelectItem;
import javax.faces.event.ValueChangeEvent;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.HashMap;

public class AttenceComputeBackingBean extends BaseBackingBean {
    private final String BXOperID="1411";
    private String setId;
    private String setName;
    private String unitId;
    private String unitName;
    private String dept;
    private String dateId;
    private String payoffDate;
    private boolean operCompute = true;
    private boolean bysort=false;

    private List sortList;
    private String sortField;
    private List exportFieldList;
    private String[] exportField;
    private List allList;
    private List showList;
    private List reportList;
    private List bxreportList;

    private List deptList; // �����б�
    private List displaySetList;// ��������
    private String qryID;       // ��ѯ����
    private String beginTime;  //���ջ�����������Ŀ�ʼʱ��
    private String endTime;    //���ջ�����������Ľ���ʱ��
    private List caclFieldList; // �����ֶ�
    private String caclField; // �����ֶ�
    private String precise;

    private IWageComputeUCC wagecomputeucc;
    private IWagePersonQueryUCC wagepersonqueryucc;
    private IWageSetUCC wagesetucc;
    private IWageSetItemUCC wagesetitemucc;
    private IUserReportUCC userreportucc;
    private IWageSetPersonUCC wagesetpersonucc;
    private WageAPI wageapi;
    private IPersonUCC personucc;
    private IUserQryUCC userqryucc;
    private QueryAPI queryapi;
    private IWageDeptUCC wagedeptucc;
    private IWageManyDeptUCC wagemanyucc;
    private IBaseSetUCC basesetucc;
    private IWageItemPowerUCC wagepowerucc;

    private int pageNum;
    private int rowNum;
    private boolean orderByName;



    public String getPrecise(){
        return precise;
    }
    public void setPrecise(String id){
       precise=id;
    }

    public String getCaclField(){
        return caclField;
    }
    public void setCaclField(String id){
       caclField=id;
    }

    public List getCaclFieldList(){
        if (caclFieldList==null){
            caclFieldList=new ArrayList();
            SelectItem si0=new SelectItem();
            si0.setLabel("--��ѡ��--");
            si0.setValue("");

            String []fs= Constants.INS_BASESET_FIELDS.split(",");
            for(int i=0;i<fs.length;i++){
                InfoItemBO ib= SysCacheTool.findInfoItem("",fs[i]);
                SelectItem si=new SelectItem();
                si.setLabel(ib.getItemNameEx());
                si.setValue(ib.getItemId());
                caclFieldList.add(si);
            }
        }
        return caclFieldList;
    }
    public void setCaclFieldList(List list){
        caclFieldList=list;
    }

    // ��������
    private String beginRateSet;
    private BaseSetBO bsb=new BaseSetBO();

    public IBaseSetUCC getBasesetucc(){
        return basesetucc;
    }
    public void setBasesetucc(IBaseSetUCC ucc){
        basesetucc=ucc;
    }

    public String getBeginTime() {
        return beginTime;
    }
    public void setBeginTime(String beginTime) {
        this.beginTime = beginTime;
    }

    public String getEndTime() {
        return endTime;
    }
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public  BaseSetBO getBsb(){
        return bsb;
    }
    public void setBsb(BaseSetBO bs){
       bsb=bs;
    }
    public String beginQueryInsurace(String startDate,String endDate){
        try{
            int months= CommonFuns.betweenMonths(endDate,startDate)+1;
            String select="A001735,A001001";
            CellVO[] header=new CellVO[months+16];
            header[0]=new CellVO();
            header[0].setItemId("A001735");
            header[0].setItemName("Ա�����");

            header[1]=new CellVO();
            header[1].setItemId("A001001");
            header[1].setItemName("����");

            for(int i=0;i<months;i++){
                header[i+2]=new CellVO();
                header[i+2].setItemId("month"+String.valueOf(i+1));
                header[i+2].setItemName(CommonFuns.plusMonth(startDate,i));
                select +=","+"month"+String.valueOf(i+1);
            }

            header[months+2]=new CellVO();
            header[months+2].setItemId("pay_count");
            header[months+2].setItemName("���Ŵ���");
            select+=",pay_count";

            header[months+3]=new CellVO();
            header[months+3].setItemId("avgresult");
            header[months+3].setItemName("ƽ��ֵ");
            select+=",avgresult";

            header[months+4]=new CellVO();
            header[months+4].setItemId("max_end");
            header[months+4].setItemName("���ϱ�������");
            select+=",max_end";

            header[months+5]=new CellVO();
            header[months+5].setItemId("min_end");
            header[months+5].setItemName("���ϱ�������");
            select+=",min_end";

            header[months+6]=new CellVO();
            header[months+6].setItemId("max_med");
            header[months+6].setItemName("ҽ�Ʊ�������");
            select+=",max_med";

            header[months+7]=new CellVO();
            header[months+7].setItemId("min_med");
            header[months+7].setItemName("ҽ�Ʊ�������");
            select+=",min_med";

            header[months+8]=new CellVO();
            header[months+8].setItemId("max_unemp");
            header[months+8].setItemName("ʧҵ��������");
            select+=",max_unemp";

            header[months+9]=new CellVO();
            header[months+9].setItemId("min_unemp");
            header[months+9].setItemName("ʧҵ��������");
            select+=",min_unemp";

            header[months+10]=new CellVO();
            header[months+10].setItemId("max_compo");
            header[months+10].setItemName("���˱�������");
            select+=",max_compo";

            header[months+11]=new CellVO();
            header[months+11].setItemId("min_compo");
            header[months+11].setItemName("���˱�������");
            select+=",min_compo";

            header[months+12]=new CellVO();
            header[months+12].setItemId("max_proc");
            header[months+12].setItemName("������������");
            select+=",max_proc";

            header[months+13]=new CellVO();
            header[months+13].setItemId("min_proc");
            header[months+13].setItemName("������������");
            select+=",min_proc";

            header[months+14]=new CellVO();
            header[months+14].setItemId("max_house");
            header[months+14].setItemName("ס������");
            select+=",max_house";

            header[months+15]=new CellVO();
            header[months+15].setItemId("min_house");
            header[months+15].setItemName("ס������");
            select+=",min_house";

            String sql="select "+select+" from ins_basedetail a ,wage_set_pers_r b,a001 c where a.person_id=b.id and a.person_id=c.id and A815700='"+this.setId+"'";
            TableVO table=new TableVO();
            table.setHeader(header);
            wageapi.querySql(table, sql, null, 0, 0, false);
            super.getHttpSession().removeAttribute("ShowTable");
            super.getHttpSession().setAttribute("ShowTable",table);
        }
        catch(Exception e){

        }
        return "";
    }



    public String getQryID(){
        return qryID;
    }
    public void setQryID(String id){
       qryID=id;
    }

    public QueryAPI getQueryapi() {
        return queryapi;
    }
    public void setQueryapi(QueryAPI queryapi) {
        this.queryapi = queryapi;
    }

    public WageAPI getWageapi(){
        return wageapi;
    }
    public void setWageapi(WageAPI api){
        wageapi=api;
    }

    public String getSortField(){
        return sortField;
    }
    public void setSortField(String sort){
        sortField=sort;
    }

    public boolean getBysort(){
        return bysort;
    }
    public void setBysort(boolean b){
        bysort=b;
    }

    public boolean getOrderByName(){
        return orderByName;
    }
    public void setOrderByName(boolean b){
        orderByName=b;
    }

    public IWageItemPowerUCC getWagepowerucc(){
        return wagepowerucc;
    }
    public void setWagepowerucc(IWageItemPowerUCC ucc){
        wagepowerucc=ucc;
    }

    public IWageSetPersonUCC getWagesetpersonucc() {
        return wagesetpersonucc;
    }
    public void setWagesetpersonucc(IWageSetPersonUCC wagesetpersonucc) {
        this.wagesetpersonucc = wagesetpersonucc;
    }

    public IWageManyDeptUCC getWagemanyucc(){
        return wagemanyucc;
    }
    public void setWagemanyucc(IWageManyDeptUCC ucc){
        wagemanyucc=ucc;
    }

    public String getPageInit() {
        if (!"isPostBack".equals(pageInit)){
            orderByName=true;
            try{
               User user = (User) (getHttpSession().getAttribute(Constants.USER_INFO));
               bxreportList=userreportucc.queryUserRptToWeb(user.getUserId(),BXOperID);
            }
            catch(SysException ee){
            }
            pageInit="isPostBack";
        }

        //-----------------  �����һ��ҳ�淵��ʱ���µ�����   -----------
        super.getHttpSession().removeAttribute("activeSql2");
        super.getHttpSession().removeAttribute("rowNum2");
        super.getHttpSession().removeAttribute("pageNum2");
        super.getHttpSession().removeAttribute(Constants.OBJECT2);
        //--------------------------------------------------------------

        String pageFlag = super.getServletRequest().getParameter("pageFlag");
        if ("1".equals(pageFlag)) { //����ҳ
            this.turnPageQuery(null, null, 0, 0);
        }
        return pageInit;
    }


    /**
     * ������Ա���� ��ѯ���ʼ������
     *
     * @return н�ʼ���ҳ��
     */
    public String queryPersonByNameStr() {
        try {
            String showField="";
            String Source=wagepowerucc.getAttencePayoffFields(super.getUserInfo().getUserId(),this.setId);
            List li=wagesetitemucc.queryItemBySetId(setId);
            for(int i=0;i<li.size();i++){
                WageSetItemBO item=(WageSetItemBO)li.get(i);
                if (Source.indexOf(item.getField())>=0){
                    if (showField.equals("")) showField=item.getField();
                    else showField+=","+item.getField();
                }
            }
            String[] showItem=(!"".equals(showField))?showField.split(","):null;
            String nameStr = super.getRequestParameter("form1:nameStr");
            TableVO table = new TableVO();
            String sql = "";
            if (this.bysort && this.sortField!=null && !"".equals(sortField) && !"-1".equals(sortField)){
               sql=wagepersonqueryucc.getSQLQueryPersonSalaryByName(null,false,table, setId, nameStr, showItem,sortField+"+0","");
            }
            else{
               sql=wagepersonqueryucc.getSQLQueryPersonSalaryByName(null,false,table, setId, nameStr, showItem,"","");
            }

            String Power="";
            if (!"".equals(Power)){   // ��н��Ȩ��
               sql=" select * from ("+sql+") a where a.id in (select id from a001 where "+Power+")";
            }

            this.turnPageQuery(table, sql, 1, 0);
        } catch (Exception e) {
            super.showMessageDetail("����" + e.getMessage());
        }
        return "personList";
    }

    /**
     * �߼���ѯ��Ա
     * ���� wagecomputeucc.queryPersonDetailBySql()
     *
     * @return ��Աн�ʼ���ҳ��
     */
    public String queryAdvance() {
        try {
            HttpSession session = super.getHttpSession();

            String tableName = "A815_SET_" + setId;
            String setIdFiled = tableName + "." + Constants.WAGE_PERSON_R_SETID;

            String select = (String) session.getAttribute(QueryConstants.SQL_SELECT_PART);
            String from = CommonFuns.filterNull((String) session.getAttribute(QueryConstants.SQL_FROM_PART)).toUpperCase();
            String where = CommonFuns.filterNull((String) session.getAttribute(QueryConstants.SQL_WHERE_PART));
            String order = CommonFuns.filterNull((String) session.getAttribute(QueryConstants.SQL_ORDER_PART));

            from = from.replaceAll(Constants.WAGE_PAYOFF_TABLE + " ", tableName + " ");
            from = from.replaceAll("AND " + Constants.WAGE_PAYOFF_TABLE + "000 = '" + Constants.YES + "'", "");
            from = from.replaceAll("AND " + Constants.WAGE_PAYOFF_TABLE + "000 = '" + Constants.NO + "'", "");
            from = from.replaceAll(Constants.WAGE_PAYOFF_TABLE + "\\.", tableName + "\\.");
            where = where.replaceAll(Constants.WAGE_PAYOFF_TABLE + "\\.", tableName + "\\.");
            order = order.replaceAll(Constants.WAGE_PAYOFF_TABLE + "\\.", tableName + "\\.");

            WageSetBO set = wagesetucc.findSetBySetId(setId);
            setName = set.getName();
            String showField="";
            String Source=wagepowerucc.getAttencePayoffFields(super.getUserInfo().getUserId(),this.setId);
            List li=wagesetitemucc.queryItemBySetId(setId);
            for(int i=0;i<li.size();i++){
                WageSetItemBO item=(WageSetItemBO)li.get(i);
                if (Source.indexOf(item.getField())>=0){
                    if (showField.equals("")) showField=item.getField();
                    else showField+=","+item.getField();
                }
            }
            String[] showItem=(!"".equals(showField))?showField.split(","):null;
            if (showItem != null && showItem.length > 0) {
                int count = showItem.length;
                for (int i = 0; i < count; i++) {
                    if (!select.matches(showItem[i])) {
                        select += "," + showItem[i];
                    }
                }
            }
            TableVO table = new TableVO();
            String[] items = select.split(",");
            CellVO[] header = new CellVO[items.length];
            int count = items.length;
            for (int i = 0; i < count; i++) {
                header[i] = new CellVO();
                if ("A001.ID".equals(CommonFuns.filterNull(items[i]).trim())) {
                    CommonFuns.copyProperties(header[i], SysCacheTool.findInfoItem("A001", "ID"));
                } else {
                    CommonFuns.copyProperties(header[i], SysCacheTool.findInfoItem("", CommonFuns.filterNull(items[i]).trim()));
                }	
            }
            table.setHeader(header);
            String wageCond = setIdFiled + "='" + setId + "'";
            if (from.indexOf(tableName) < 0) {
                from += " LEFT JOIN " + tableName + " ON A001.ID = " + tableName + ".ID ";
            }
            if (where != null && where.length() > 0) {
                where += " AND " + wageCond;
            } else {
                where = wageCond;
            }

            String Power="";
            if (!"".equals(Power)){   // ��н��Ȩ��
                if (where != null && where.length() > 0) {
                    where += " AND " + Power;
                } else {
                    where = Power;
                }
            }

            String sql = "SELECT " + select;
            sql += " FROM " + from;
            sql += " WHERE " + where;
            if (order.length() > 0) {
                sql += " ORDER BY " + order;
            }
            this.turnPageQuery(table, sql, 1, 0);
        } catch (SysException e) {
            super.showMessageDetail("����:" + e.getMessage());
        }
        return "personList";
    }

    public void queryByCondition(){
        if (!"-1".equals(qryID)){
            try {
                Hashtable hash = queryapi.getQuerySqlHash(null, qryID);

                String tableName = "A815_SET_" + setId;
                String setIdFiled = tableName + "." + Constants.WAGE_PERSON_R_SETID;

                String select = (String) hash.get(QueryConstants.SQL_SELECT_PART);
                String from = CommonFuns.filterNull((String) hash.get(QueryConstants.SQL_FROM_PART)).toUpperCase();
                String where = CommonFuns.filterNull((String) hash.get(QueryConstants.SQL_WHERE_PART));
                String order = CommonFuns.filterNull((String) hash.get(QueryConstants.SQL_ORDER_PART));

                from = from.replaceAll(Constants.WAGE_PAYOFF_TABLE + " ", tableName + " ");
                from = from.replaceAll("AND " + Constants.WAGE_PAYOFF_TABLE + "000 = '" + Constants.YES + "'", "");
                from = from.replaceAll("AND " + Constants.WAGE_PAYOFF_TABLE + "000 = '" + Constants.NO + "'", "");
                from = from.replaceAll(Constants.WAGE_PAYOFF_TABLE + "\\.", tableName + "\\.");
                where = where.replaceAll(Constants.WAGE_PAYOFF_TABLE + "\\.", tableName + "\\.");
                order = order.replaceAll(Constants.WAGE_PAYOFF_TABLE + "\\.", tableName + "\\.");

                WageSetBO set = wagesetucc.findSetBySetId(setId);
                String showField = set.getShowField();
                String[] showItem;
                if (showField != null && showField.trim().length() > 0)
                    showItem = showField.split(",");
                else {
                    showField = set.getAllField();
                    showItem = showField.split(",");
                }
                if (showItem != null && showItem.length > 0) {
                    int count = showItem.length;
                    for (int i = 0; i < count; i++) {
                        if (!select.matches(showItem[i])) {
                            select += "," + showItem[i];
                        }
                    }
                }
                TableVO table = new TableVO();
                String[] items = select.split(",");
                CellVO[] header = new CellVO[items.length];
                int count = items.length;
                for (int i = 0; i < count; i++) {
                    header[i] = new CellVO();
                    if ("A001.ID".equals(CommonFuns.filterNull(items[i]).trim())) {
                        CommonFuns.copyProperties(header[i], SysCacheTool.findInfoItem("A001", "ID"));
                    } else {
                        CommonFuns.copyProperties(header[i], SysCacheTool.findInfoItem("", CommonFuns.filterNull(items[i]).trim()));
                    }
                }
                table.setHeader(header);
                String wageCond = setIdFiled + "='" + setId + "'";
                if (from.indexOf(tableName) < 0) {
                    from += " LEFT JOIN " + tableName + " ON A001.ID = " + tableName + ".ID ";
                }
                if (where != null && where.length() > 0) {
                    where += " AND " + wageCond;
                } else {
                    where = wageCond;
                }
                String sql = "SELECT " + select;
                sql += " FROM " + from;
                sql += " WHERE " + where;
                if (order.length() > 0) {
                    sql += " ORDER BY " + order;
                }
                this.turnPageQuery(table, sql, 1, 0);
            } catch (SysException e) {
                //e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
                super.showMessageDetail("����:" + e.getMessage());
            }
        }
    }

    // ������Ϣ
    public String queryInsuranceBySetId() {
        try {
            super.getHttpSession().removeAttribute(Constants.OBJECT);
            super.getHttpSession().removeAttribute("activeSql");
            super.getHttpSession().removeAttribute("pageNum");
            super.getHttpSession().removeAttribute("rowNum");
            String showField="";
            String Source=wagepowerucc.getAttencePayoffFields(super.getUserInfo().getUserId(),this.setId);;
            List li=wagesetitemucc.queryItemBySetId(setId);
            for(int i=0;i<li.size();i++){
                WageSetItemBO item=(WageSetItemBO)li.get(i);
                if (Source.indexOf(item.getField())>=0){
                    if (showField.equals("")) showField=item.getField();
                    else showField+=","+item.getField();
                }
            }
            String[] showItem=(!"".equals(showField))?showField.split(","):null;
            TableVO table = new TableVO();
            String sql = wagepersonqueryucc.getSQLQueryPersonSalaryBySetId(table, setId, showItem);
            this.turnPageQuery(table, sql, 1, 0);
        } catch (Exception e) {
            super.showMessageDetail("����" + e.getMessage());
        }
        return "personList";
    }

   public String delete(){
        String str = super.getRequestParameter("form1:deletePerson");
        try{
            wagecomputeucc.deletePersonfromTmpTable(this.setId,this.dateId,this.payoffDate,this.unitId,str);
        } catch (Exception e) {

            super.showMessageDetail("����" + e.getMessage());
        }
        this.turnPageQuery(null, null, 0, 0);
        return "personList";
   }
   public String reinforce(){
       String str = super.getRequestParameter("form1:addPerson");
       try{
           wagecomputeucc.addPersonToTmpTable(this.setId,this.dateId,this.payoffDate,this.unitId,str);
       } catch (Exception e) {
           super.showMessageDetail("����" + e.getMessage());
       }
       this.turnPageQuery(null, null, 0, 0);
       return "personList";
   }
   /*
    * Ϊ�����������Ա��������
    */
   public String supplyData(){
       try {
           String inputField="";
           List liitem=wagesetitemucc.queryItemBySetId(setId);
           for(int i=0;i<liitem.size();i++){
                WageSetItemBO item=(WageSetItemBO)liitem.get(i);
                if (inputField.equals("")){
                    inputField=item.getField();
                }
                else {
                    inputField += ","+item.getField();
                }
           }
           String[] Field=inputField.split(",");
           super.getHttpSession().setAttribute("field", Field);

           String[] persId = wagepersonqueryucc.getReiforcePersonSetId(setId);
           if (persId==null || persId.length==0 ){
               super.showMessageDetail("û�в�����Ա�����벹�����ݣ�");
               return "";
           }
           super.getHttpSession().setAttribute("persId",persId);
           HashMap hash = wagesetpersonucc.queryPersonItemByItemId(setId, persId, Field,true);
           super.getHttpSession().setAttribute("value", hash);
       } catch (SysException e) {
           super.showMessageDetail("����:" + e.getMessage());
       }
       return "inputEdit";
   }

   public String queryPieceByNameStr() {
        try {
            super.getHttpSession().removeAttribute(Constants.OBJECT);
            super.getHttpSession().removeAttribute("activeSql");
            super.getHttpSession().removeAttribute("pageNum");
            super.getHttpSession().removeAttribute("rowNum");
            String showField="";
            List li=SysCacheTool.queryInfoItemBySetId("A002");
            for(int i=0;i<li.size();i++){
               InfoItemBO ib=(InfoItemBO)li.get(i);
               if (ib.getItemProperty().equals(InfoItemBO.SYSITEM_HIDDEN)) continue;
               if (showField.equals("")){
                   showField=ib.getItemId();
               }
               else{
                   showField+=","+ib.getItemId();
               }
            }
            String[] showItem=showField.split(",");
            TableVO table = new TableVO();
            String nameStr = super.getRequestParameter("form1:nameStr");
            String whereStr = "";
            whereStr="(A001735 like '%"+nameStr+"%' or A001001 like '%"+nameStr+"%' or A001002 like '%"+nameStr.toLowerCase()+"%')";
            String sql = wagepersonqueryucc.getSQLQueryPieceBySetId(table,this.setId, this.dateId,showItem,whereStr);
            this.turnPageQuery(table, sql, 1, 0);
        } catch (Exception e) {
            super.showMessageDetail("����" + e.getMessage());
        }
        return "personList";

    }


    /**
     * ������ʾ������
     *
     * @return н�ʼ���ҳ��
     */
    public String saveShowItem() {
        try {
            WageSetBO set = wagesetucc.findSetBySetId(setId);
            String str = super.getRequestParameter("form1:str");
            String[]tmp = str.split("\\|");
            String allField = tmp[0];//CommonFuns.StrArray2String(allItem, ",");
            String showField = tmp[1];
            set.setAllField(allField);
            set.setShowField(showField);
            wagesetucc.updateSet(set);

            TableVO table = new TableVO();
            String sql = wagepersonqueryucc.getSQLQueryPersonSalaryBySetId(table, setId, showField.split(","));
            this.turnPageQuery(table, sql, 0, 0);
        } catch (SysException e) {
            //e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
            super.showMessageDetail("����:" + e.getMessage());
        }
        return "personList";
    }

    public String turnPageQuery() {
        return turnPageQuery(null, null, 0, 0);
    }

    public String turnPageQuery(TableVO table, String sql, int pageNum, int rowNum) {
        try {
            if (pageNum == 0)
                pageNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("pageNum")));
            if (pageNum == 0)
                pageNum = Integer.parseInt(CommonFuns.filterNullToZero((String) super.getHttpSession().getAttribute("pageNum")));
            if (pageNum == 0)
                pageNum = 1;
            if (rowNum == 0)
                rowNum = Integer.parseInt(CommonFuns.filterNullToZero(super.getRequestParameter("rowNum")));
            if (rowNum == 0)
                rowNum = Integer.parseInt(CommonFuns.filterNullToZero((String) super.getHttpSession().getAttribute("rowNum")));
            if (rowNum == 0)
                rowNum = Constants.ACTIVE_PAGE_SIZE;
            if (table == null)
                table = (TableVO) super.getHttpSession().getAttribute(Constants.OBJECT);
            if (sql == null)
                sql = (String) super.getHttpSession().getAttribute("activeSql");

            table = wagepersonqueryucc.queryPersonBySql(table, sql, pageNum, rowNum);
            super.getHttpSession().setAttribute("activeSql", sql);
            super.getHttpSession().setAttribute("rowNum", String.valueOf(rowNum));
            super.getHttpSession().setAttribute("pageNum", String.valueOf(pageNum));
            super.getHttpSession().setAttribute(Constants.OBJECT, table);
        } catch (Exception e) {
            super.showMessageDetail("����" + e.getMessage());
        }
        return null;
    }

    public List getReportList(){
       return reportList;
    }
    public void setReportList(List list){
      reportList=list;
    }

    public List getBxreportList(){
       return bxreportList;
    }
    public void setBxreportList(List list){
      bxreportList=list;
    }

    public String getSetId() {
        return setId;
    }
    public void setSetId(String setId) {
        this.setId = setId;
    }

    public String getDateId() {
        return dateId;
    }
    public void setDateId(String dateId) {
        this.dateId = dateId;
    }

    public String getSetName() {
        return setName;
    }
    public void setSetName(String setName) {
        this.setName = setName;
    }

    public String getUnitId() {
        return unitId;
    }
    public void setUnitId(String unitId) {
        this.unitId = unitId;
    }

    public String getDept() {
        return dept;
    }
    public void setDept(String ID) {
        this.dept = ID;
    }

    public String getUnitName() {
        return unitName;
    }
    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    public IWageComputeUCC getWagecomputeucc() {
        return wagecomputeucc;
    }
    public void setWagecomputeucc(IWageComputeUCC wagecomputeucc) {
        this.wagecomputeucc = wagecomputeucc;
    }

    public IWagePersonQueryUCC getWagepersonqueryucc() {
        return wagepersonqueryucc;
    }
    public void setWagepersonqueryucc(IWagePersonQueryUCC wagepersonqueryucc) {
        this.wagepersonqueryucc = wagepersonqueryucc;
    }

    public void setUserreportucc(IUserReportUCC iur) {
        this.userreportucc = iur;
    }
    public IUserReportUCC getUserreportucc() {
        return userreportucc;
    }

    public IWageSetUCC getWagesetucc() {
        return wagesetucc;
    }
    public void setWagesetucc(IWageSetUCC wagesetucc) {
        this.wagesetucc = wagesetucc;
    }

    public IWageSetItemUCC getWagesetitemucc() {
        return wagesetitemucc;
    }
    public void setWagesetitemucc(IWageSetItemUCC wagesetitemucc) {
        this.wagesetitemucc = wagesetitemucc;
    }

    public IPersonUCC getPersonucc() {
        return personucc;
    }
    public void setPersonucc(IPersonUCC personucc) {
        this.personucc = personucc;
    }

    public  IUserQryUCC getUserqryucc(){
        return userqryucc;
    }
    public void setUserqryucc(IUserQryUCC iu){
       userqryucc=iu;
    }

    public IWageDeptUCC getWagedeptucc() {
        return wagedeptucc;
    }
    public void setWagedeptucc(IWageDeptUCC ucc) {
        this.wagedeptucc = ucc;
    }

    /**
     * �õ����е�н����
     */
    public List getAllList() {
        if (setId==null || "".equals(setId)) {   // �ط�ҳ��û�иò���
           setId = super.getServletRequest().getParameter("setId");
        }
        try {
            if (this.orderByName){
                allList = wagesetitemucc.queryItemBySetIdOrderByName(setId);
            }
            else {
                 allList = wagesetitemucc.queryItemBySetId(setId);
            }
            if (allList != null && allList.size() > 0) {
                int count = allList.size();
                for (int i = 0; i < count; i++) {
                    SelectItem st = new SelectItem();
                    WageSetItemBO wt = (WageSetItemBO) allList.get(i);
                    st.setLabel(CodeUtil.interpertCode("INFOITEM", wt.getField()));
                    st.setValue(wt.getField());
                    allList.set(i, st);
                }
                // ����˰��ϵͳ��Ŀ
                SelectItem tax = new SelectItem();
                tax.setLabel(CodeUtil.interpertCode("INFOITEM", "A815714"));
                tax.setValue("A815714");
                if (!allList.contains(tax)){
                    allList.add(tax);
                }
            } else {
                allList = new ArrayList();
            }
        } catch (SysException e) {
            //e.printStackTrace();
            super.showMessageDetail("����" + e.getMessage());
        }
        return allList;
    }
    public void setAllList(List allList) {
        this.allList = allList;
    }

    /**
     * �õ�������ʾ��
     */
    public List getShowList() {
        try {
            if (setId==null || "".equals(setId)) {   // �ط�ҳ��û�иò���
               setId = super.getServletRequest().getParameter("setId");
            }
            WageSetBO set = wagesetucc.findSetBySetId(setId);
            String showField = set.getShowField();
            if (showField != null && !"".equals(showField)) {
                String[] field = showField.split(",");
                if (field != null && field.length > 0) {
                    int count = field.length;
                    showList = new ArrayList();
                    for (int i = 0; i < count; i++) {
                        SelectItem st = new SelectItem();
                        st.setLabel(CodeUtil.interpertCode("INFOITEM", field[i]));
                        st.setValue(field[i]);
                        showList.add(st);
                    }
                }
            } else {
                showList = new ArrayList();
            }
        } catch (SysException e) {
            super.showMessageDetail("����" + e.getMessage());

        }
        return showList;
    }
    public void setShowList(List showList) {
        this.showList = showList;
    }

    public List getSortList() {
        if (setId==null || "".equals(setId)) {   // �ط�ҳ��û�иò���
           setId = super.getServletRequest().getParameter("setId");
        }
        if (sortList!=null){    // �ط�ʱ
            return sortList;
        }
        try {
            sortList = wagesetitemucc.queryItemBySetIdOrderByName(setId);

            if (sortList != null && sortList.size() > 0) {
                for (int i = 0; i < sortList.size(); i++) {
                    SelectItem st = new SelectItem();
                    WageSetItemBO wt = (WageSetItemBO) sortList.get(i);
                    st.setLabel(CodeUtil.interpertCode("INFOITEM", wt.getField()));
                    st.setValue(wt.getField());
                    sortList.set(i, st);
                }
                // ����˰��ϵͳ��Ŀ
                SelectItem tax = new SelectItem();
                tax.setLabel(CodeUtil.interpertCode("INFOITEM", "A815714"));
                tax.setValue("A815714");
                if (!sortList.contains(tax)){
                    sortList.add(tax);
                }
            } else {
                sortList = new ArrayList();
            }
        } catch (SysException e) {
            //e.printStackTrace();
            super.showMessageDetail("����" + e.getMessage());
        }
        SelectItem si=new SelectItem();
        si.setLabel(" ");
        si.setValue("-1");
        sortList.add(0,si);
        return sortList;
    }
    public void setSortList(List allList) {
        this.sortList = allList;
    }

    public List getDeptList(){
        deptList=new ArrayList();
        SelectItem s1=new SelectItem();
        s1.setLabel("--ȫ������--");
        s1.setValue("-1");
        deptList.add(s1);
        try{
            String [] depstr=null;
            List powerList=wagedeptucc.getAllPowerByPerson(super.getUserInfo().getUserId(),this.setId);
            if (powerList==null || powerList.size()==0){ // û�ж���н��Ȩ��
                 depstr=wagepersonqueryucc.getDeptList(setId);
            }
            else{
                depstr=new String [powerList.size()];
                for(int i=0;i<powerList.size();i++){
                    WageDeptPowerBO wpo=(WageDeptPowerBO)powerList.get(i);
                    WageDeptBO wdo=wagedeptucc.getDeptBOByID(wpo.getDeptID());
                    depstr[i]=wdo.getName();
                }
            }
            int len=Integer.parseInt(Constants.WAGE_DEPT_CODELEN);
            if (depstr!=null){
                 for(int i=0;i<depstr.length;i++){
                     SelectItem s2=new SelectItem();
                     if (depstr[i]!=null && depstr[i].length()>len){
                        s2.setLabel(depstr[i].substring(len));
                     }
                     else{
                         s2.setLabel(depstr[i]);
                     }
                     s2.setValue(depstr[i]);
                     deptList.add(s2);
                 }
             }
        }
        catch(Exception e){

        }
        return deptList;
    }
    public void setDeptList(List dept){
        deptList=dept;
    }

    public int getPageNum() {
        return pageNum;
    }
    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getRowNum() {
        return rowNum;
    }
    public void setRowNum(int rowNum) {
        this.rowNum = rowNum;
    }

    public boolean isOperCompute() {
        return operCompute;
    }
    public void setOperCompute(boolean operCompute) {
        this.operCompute = operCompute;
    }

    public String getPayoffDate() {
        return payoffDate;
    }
    public void setPayoffDate(String payoffDate) {
        this.payoffDate = payoffDate;
    }

    // ����ǰ�ķ��ż�¼���½��л��ܼ���
    public void gatherCount(){

    }
    public void changeOrder(ValueChangeEvent event){
        if (event.getNewValue().toString().equals("true")){
            orderByName=true;
        }
        else{
           orderByName=false;
        }
    }
    // ------------------ ���Ź��� ---------------------------
    // ���˼�����ϸ�Ĳ��Ź���
    public String changePieceDept(ValueChangeEvent event){
        try {
            super.getHttpSession().removeAttribute(Constants.OBJECT);
            super.getHttpSession().removeAttribute("activeSql");
            super.getHttpSession().removeAttribute("pageNum");
            super.getHttpSession().removeAttribute("rowNum");
            String showField="";
            List li=SysCacheTool.queryInfoItemBySetId("A002");
            for(int i=0;i<li.size();i++){
               InfoItemBO ib=(InfoItemBO)li.get(i);
               if (ib.getItemProperty().equals(InfoItemBO.SYSITEM_HIDDEN)) continue;
               if (showField.equals("")){
                   showField=ib.getItemId();
               }
               else{
                   showField+=","+ib.getItemId();
               }
            }
            String[] showItem=showField.split(",");
            TableVO table = new TableVO();
            String whereStr = "";
            if (event.getNewValue().toString().equals("-1")){
                whereStr="1=1";
            }
            else{
                whereStr="A001743='"+event.getNewValue().toString()+"'";
            }
            String sql = wagepersonqueryucc.getSQLQueryPieceBySetId(table,this.setId, this.dateId,showItem,whereStr);
            this.turnPageQuery(table, sql, 1, 0);
        } catch (Exception e) {
            super.showMessageDetail("����" + e.getMessage());
        }
        return "personList";
    }
    public String queryNagetive(){
        try {
            WageSetBO set = wagesetucc.findSetBySetId(setId);
            String showField = set.getShowField();
            String[] showItem;
            if (showField != null && showField.trim().length() > 0)
                showItem = showField.split(",");
            else {
                showField = set.getAllField();
                showItem = showField.split(",");
            }
            //A815712	A815	ʵ������
            String whereStr = " isnull(A815712,0)<0 ";
            TableVO table = new TableVO();
            String sql = wagepersonqueryucc.getQuerySalarySqlByConditon(null,false,table,setId,showItem,whereStr,"");
            this.turnPageQuery(table, sql, 1, 0);
        } catch (Exception e) {
            super.showMessageDetail("����" + e.getMessage());
        }
        return "personList";
    }


    public String beginSort(ValueChangeEvent event){
        if (event.getNewValue().toString().equals("true")){
            this.bysort = true;
        }
        else{
            this.bysort=false;
        }
        return "";
    }


    //-------------------------------- ������excel--------------
    public String [] getExportField(){
        return exportField;
    }
    public void setExportField(String [] st){
         exportField=st;
    }

    public List getExportFieldList(){
        exportFieldList=new ArrayList();
        TableVO table=(TableVO)super.getHttpSession().getAttribute(Constants.OBJECT);
        for(int i=0;i<table.getHeader().length;i++){
            SelectItem si=new SelectItem();
            si.setLabel(table.getHeader()[i].getItemNameEx());
            si.setValue(table.getHeader()[i].getItemId());
            exportFieldList.add(si);
        }
        return exportFieldList;
    }
    public void setExportFieldList(List l){
        exportFieldList=l;
    }
    public String exportToExcel(){
        String strField="";
        for(int i=0;i<exportField.length;i++){
            strField += ","+exportField[i];
        }
        TableVO table=(TableVO)super.getHttpSession().getAttribute(Constants.OBJECT);
        for(int i=0;i<table.getHeader().length;i++){
            if (strField.indexOf(table.getHeader()[i].getItemId())>=0){
               table.getHeader()[i].setSelected(true);
            }
            else{
               table.getHeader()[i].setSelected(false);
            }
        }
        return "toExcel";
    }
}
