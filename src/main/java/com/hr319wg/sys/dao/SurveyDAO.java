package com.hr319wg.sys.dao;

import java.util.Hashtable;
import java.util.List;

import com.hr319wg.common.dao.BaseDAO;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.self.pojo.bo.SurveyAnswerBO;
import com.hr319wg.self.pojo.bo.SurveyDetailBO;
import com.hr319wg.self.pojo.bo.SurveyResultBO;

public class SurveyDAO extends BaseDAO
{
  public List getAllPaper(String orgid)
    throws SysException
  {
    String sql = "select bo from SurveyPaperBO bo where ((bo.isUse='1' and bo.method != '2') or bo.publish='1') and (bo.orgID='" + orgid + "' or bo.orgID='-1')";
    return this.hibernatetemplate.find(sql);
  }
  public List getAllOwnPaperAndModuleid(String orgid, String moduleid) throws SysException {
    String sql = "select bo from SurveyPaperBO bo where bo.moduleid='" + moduleid + "'";
    if(!"-1".equals(orgid)){
    	sql+=" and bo.createOrg='" + orgid + "'";
    }
    return this.hibernatetemplate.find(sql);
  }
  public List getAllOwnPaper(String orgid) throws SysException {
    String sql = "select bo from SurveyPaperBO bo ";
    if(!"-1".equals(orgid)){
    	sql+=" where bo.createOrg='" + orgid + "'";
    }
    return this.hibernatetemplate.find(sql);
  }
  public List getAllQuestionByPaper(String paperID) throws SysException {
    String sql = "select bo from SurveyQuestionBO bo where bo.paperID='" + paperID + "' order by bo.showSeq";
    return this.hibernatetemplate.find(sql);
  }
  public List getAllAnswerByQuestion(String QuestionID) throws SysException {
    String sql = "select bo from SurveyAnswerBO bo where bo.questionID='" + QuestionID + "' order by bo.code";
    return this.hibernatetemplate.find(sql);
  }

  public List getAllResult(String paperID) throws SysException
  {
    String sql = "select bo from SurveyResultBO bo where bo.paperID='" + paperID + "'";
    return this.hibernatetemplate.find(sql);
  }
  public Hashtable getDetailByPerson(String pid) throws SysException {
    Hashtable ht = new Hashtable();
    String sql = "select bo from SurveyDetailBO bo where bo.personID='" + pid + "'";
    List list = this.hibernatetemplate.find(sql);
    for (int i = 0; i < list.size(); i++) {
      SurveyDetailBO bo = (SurveyDetailBO)list.get(i);
      ht.put(bo.getAnswerID(), bo);
    }
    return ht;
  }

  public SurveyResultBO getResult(String paperID, String perID) throws SysException {
    String sql = "select bo from SurveyResultBO bo where bo.personID='" + perID + "' and bo.paperID='" + paperID + "'";
    List li = this.hibernatetemplate.find(sql);
    if ((li == null) || (li.size() == 0)) {
      return null;
    }

    return (SurveyResultBO)li.get(0);
  }

  public SurveyAnswerBO getAnswerBOByID(String qid, String code) throws SysException {
    String sql = "select bo from SurveyAnswerBO bo where bo.questionID='" + qid + "' and bo.code='" + code + "'";
    List list = this.hibernatetemplate.find(sql);
    if ((list == null) || (list.size() == 0)) return null;
    return (SurveyAnswerBO)list.get(0);
  }
  public List getAttList(String qid, String code) throws SysException {
    String sql = "select bo from SurveyDetailBO bo,SurveyAnswerBO so where bo.answerID=so.answerID and bo.selectResult='1' and so.questionID='" + qid + "' and so.code='" + code + "'";
    return this.hibernatetemplate.find(sql);
  }
  public List getReplayList(String qid) throws SysException {
    String sql = "select bo from SurveyDetailBO bo where  bo.selectResult='1' and bo.answerID='" + qid + "'";
    return this.hibernatetemplate.find(sql);
  }
}