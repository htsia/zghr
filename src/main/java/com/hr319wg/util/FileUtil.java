package com.hr319wg.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Vector;

import javax.faces.context.FacesContext;
import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.dom.DOMSource;

import jxl.Cell;
import jxl.Range;
import jxl.Workbook;
import jxl.format.CellFormat;
import jxl.write.Label;
import jxl.write.WritableCell;
import jxl.write.WritableImage;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.avalon.framework.logger.ConsoleLogger;
import org.apache.avalon.framework.logger.Logger;
import org.apache.fop.apps.Driver;
import org.apache.fop.tools.DocumentInputSource;
import org.apache.myfaces.custom.fileupload.UploadedFile;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.w3c.dom.Document;
import org.w3c.tidy.Tidy;

import com.hr319wg.ccp.pojo.bo.PartyBO;
import com.hr319wg.common.Constants;
import com.hr319wg.common.exception.SysException;
import com.hr319wg.common.pojo.vo.User;
import com.hr319wg.common.web.SysContext;
import com.hr319wg.emp.pojo.bo.PersonBO;
import com.hr319wg.org.pojo.bo.OrgBO;
import com.hr319wg.post.pojo.bo.PostBO;
import com.hr319wg.sys.api.ActivePageAPI;
import com.hr319wg.sys.cache.SysCacheTool;
import com.hr319wg.sys.pojo.bo.CodeItemBO;
import com.hr319wg.sys.pojo.bo.CodeSetBO;
import com.hr319wg.sys.pojo.bo.InfoItemBO;
import com.hr319wg.sys.pojo.bo.InfoSetBO;
import com.hr319wg.sys.pojo.vo.CellVO;
import com.hr319wg.sys.pojo.vo.RecordVO;
import com.hr319wg.sys.pojo.vo.TableVO;
import com.hr319wg.user.pojo.bo.RoleInfoBO;
import com.hr319wg.wage.pojo.bo.WageBankItemBO;
import com.hr319wg.wage.pojo.bo.WageUnitBO;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class FileUtil {
    public static String getRealPath(String path){
        ServletContext context = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
        String actpath=context.getRealPath(path);
        if (!actpath.endsWith(File.separator)){
            actpath+=File.separator;
        }
        return actpath;
    }
    
    // ��·���г�ȡ�ļ���
    public static String parseFileName(String fullFileName) {
             if(fullFileName==null||fullFileName.equals("")){ return "noname"; }
             int len = fullFileName.length();
             int pos = fullFileName.lastIndexOf('\\');
             return fullFileName.substring(pos+1,len);
    }
    
    public static String addCsvField(String str){
        if(str == null)
            return ",";
        StringBuffer sb ;

        if(str.indexOf("\"") != -1)
            sb = new StringBuffer(str.replaceAll("\"","\"\""));
        else
            sb = new StringBuffer(str);
        if (sb.length()>14){ // ��������ֱ�ɿ�ѧ������
            sb.insert(0,'\t');
        }
        return sb.append(",").toString();
    }
    
    /**
     * �����ļ�
     *
     *  fileContent  �ļ�����
     *  absolutePath �ļ���ž���·��
     *  fileType     �ļ����ͣ����ļ���׺ �� xls �� doc ��
     * ���� ����·�����ļ���
     */
    public static String formatUploadFile(UploadedFile upfile) throws SysException {
        String fileName="";
        String []fpa=parseFileName(upfile.getName()).split("\\.");
        if (fpa.length<=1){
            fileName=CommonFuns.getUUID();
        }
        else{
           fileName=CommonFuns.getUUID()+"."+fpa[1];
        }
        return fileName;
    }
    public static String createFile(UploadedFile upfile, String absolutePath) throws SysException {
        String fileName;
        try {
            File dir = new File(absolutePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            fileName = formatUploadFile(upfile);
            String path = absolutePath + File.separator + fileName;
            FileOutputStream fos = new FileOutputStream(path);
            try {
                fos.write(upfile.getBytes());
            } finally {
                fos.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new SysException("", "ָ��λ�ô����ļ�ʧ��", e, FileUtil.class);
        }
        return fileName;
    }


    public static String createFile(byte[] fileContent, String absolutePath, String fileType) throws SysException {
        String fileName;
        try {
            File dir = new File(absolutePath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            fileName = CommonFuns.getSysDate("yyyyMMddHHmmss") + "_" + new Random().nextInt(10000) + "." + fileType;
            String path = absolutePath + File.separator + fileName;
            FileOutputStream fos = new FileOutputStream(path);
            try {
                fos.write(fileContent);
            } finally {
                fos.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new SysException("", "ָ��λ�ô����ļ�ʧ��", e, FileUtil.class);
        }
        return fileName;
    }
    public static void createFile(byte[] fileContent, String path) throws SysException {
        try {
            FileOutputStream fos = new FileOutputStream(path);
            try {
                fos.write(fileContent);
            } finally {
                fos.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new SysException("", "ָ��λ�ô����ļ�ʧ��", e, FileUtil.class);
        }
    }

    /**
     *
     *  ��ȡexcle�ļ�-����������Ա
     *
     *  absolutePath �ļ���ŵľ���·��
     *  fileName     �ļ����� (����·��)
     *  colDataType  ���ݶ�ȡ�е���������
     *  keyDataType  ��¼������������ ����ָ�꼯���ࣨ��������Ա����λ�ȣ�
     *  keyCol       ��������������
     *  impRs        �������ݴ�� ��hastable�����Ϊnull��ִ�ж����ݲ������� key:��Աid������id�ȣ�value��String[] ������һ�¡�
     *  startCol     ��ȡ���ݿ�ʼ��(��0��ʼ)
     *  startRow     ��ȡ���ݿ�ʼ��(��0��ʼ)
     *  delFile      �Ƿ�ɾ��ԭ�ļ� true �ǣ� false ��
     *  codeType     0 ����   1 ����
     *  ���� boolean ���ļ������Ƿ��д��������޴��� true,�����д��� false.  ������false,ԭ�ļ���ɾ��������Դ�ļ����������µ�sheet����¼������Ϣ
     *
     */
    public static boolean readNewExcelFile(String absolutePath,
                                        String fileName,
                                        InfoItemBO[] cols,
                                        Map impRs,
                                        boolean delFile,
                                        String codeType) throws SysException {
        Hashtable htcode=new Hashtable();   // �������������������
        String tempFile=absolutePath + File.separator + fileName;
        String errorFile=absolutePath + File.separator + "ERROR_" + fileName;
        boolean noError=true;

        // -------����ת��-------
        if ("1".equals(Constants.IMPORT_CSV2UTF8)){
            FileANSI2UTF(tempFile);
        }
        File f = new File(tempFile);
        BufferedReader br = null;
        BufferedWriter bw=null;

        ActivePageAPI api=(ActivePageAPI) SysContext.getBean("sys_activePageApi");
        try {
            //���ļ�
            br = new BufferedReader(new FileReader(f));

            //����������־�ļ�
            bw = new BufferedWriter(new FileWriter(new File(errorFile)));

            String headerLine = br.readLine(); // ���������
            if(headerLine == null){
                throw new SysException("������ļ�Ϊ�գ��뵼�������ݵ��ļ�!");
            }

            int columns = headerLine.split(",").length;
            if (cols.length  != columns) {
                throw new SysException("����ѡ�����Ŀ��Excel�е���Ŀ��һ����������ѡ��!");
            }
            String lineData ;
            int parsingLineNumber = 0;   //���ڴ�����к�,���ڼ�¼������־��.
            int excelCount=0;
            int errorCount=0;
            while((lineData = br.readLine()) != null){
                parsingLineNumber ++;
                excelCount++;                      // excel��������
                if (lineData.endsWith(",")){
                    lineData+=" "; // ������Ϊ���ţ���������Ϊ��,ֻ�в��Ͽո��split����Ч
                }
                String[] data = lineData.split(",");
                data[data.length-1]=data[data.length-1].trim(); // ������ո񣬻���ȥ��
                boolean add=true;
                for(int i=0;i<cols.length;i++){  //��ʽ������
                     if (InfoItemBO.DATA_TYPE_ORG.equals(cols[i].getItemDataType())){ //��������
                         OrgBO oo=SysCacheTool.findOrgByCode(data[i]);
                         if (oo!=null){
                             data[i]=oo.getOrgId();
                         }
                         else{
                             add=false;
                             addErrorFormatLabel(bw, parsingLineNumber, i, data[i]+"�������ݲ�����");
                             noError=false;
                             break;
                         }
                     }
                     else if ("A001077".equals(cols[i].getItemId())){
                         String sql="select count(*) from a001 where a001077='"+data[i]+"'";
                         if (api.queryForInt(sql)>0){
                             add=false;
                             addErrorFormatLabel(bw, parsingLineNumber, i, data[i]+"�����֤���Ѵ���!");
                             noError=false;
                             break;
                         }
                     }                     
                     else if (InfoItemBO.DATA_TYPE_DATE6.equals(cols[i].getItemDataType())){
                         if (data[i].length()!=0 && data[i].length()!=6){
                             add=false;
                             addErrorFormatLabel(bw, parsingLineNumber, i, data[i]+"������yyyyMM��ʽ!");
                             noError=false;
                             break;
                         }
                         else{
                             if (data[i].length()==6){
                                data[i]=data[i].substring(0, 4) + "-" + data[i].substring(4, 6);
                             }
                         }
                     }
                     else if (InfoItemBO.DATA_TYPE_DATE.equals(cols[i].getItemDataType())){
                        if (data[i].length()!=0 && data[i].length()!=8){
                            add=false;
                            addErrorFormatLabel(bw, parsingLineNumber, i, data[i]+"������yyyyMMdd��ʽ!");
                            noError=false;
                            break;
                        }
                        else{
                            if (data[i].length()==8){
                                data[i]=data[i].substring(0, 4) + "-" + data[i].substring(4, 6)+"-"+data[i].substring(6, 8);
                            }
                        }
                    }
                    else if (InfoItemBO.DATA_TYPE_CODE.equals(cols[i].getItemDataType())){
                         if (data[i]!=null && !"".equals(data[i])){
                             if ("1".equals(codeType)){  // ��������ת��
                                  Hashtable itemhash=(Hashtable)htcode.get(cols[i].getItemCodeSet());
                                 if (itemhash==null){   // ����
                                     itemhash=new Hashtable();
                                     List codeitemlist=SysCacheTool.queryCodeItemBySetId(cols[i].getItemCodeSet());
                                     for(int j=0;j<codeitemlist.size();j++){
                                         CodeItemBO cb=(CodeItemBO)codeitemlist.get(j);
                                         itemhash.put(cb.getItemName(),cb.getItemId());
                                     }
                                     htcode.put(cols[i].getItemCodeSet(),itemhash);
                                 }
                                 String newcode=(String)itemhash.get(data[i]);
                                 if (newcode!=null){
                                     data[i]=newcode;
                                 }
                                 else{
                                     add=false;
                                     addErrorFormatLabel(bw, parsingLineNumber, i, "����["+data[i]+"]������");
                                     noError=false;
                                     break;
                                 }
                             }
                             else{  // ����ƥ��
                                  CodeItemBO code=SysCacheTool.findCodeItem("",data[i]);
                                  if (code==null){
                                      add=false;
                                      addErrorFormatLabel(bw, parsingLineNumber, i, "����["+data[i]+"]������!");
                                      noError=false;
                                      break;
                                  }
                             }
                        }
                    }
                    if ("1".equals(cols[i].getItemNotNull())){ // ��Ϊ��
                        if (data[i]==null || "".equals(data[i])){
                            add=false;
                            addErrorFormatLabel(bw, parsingLineNumber, i, data[i]+"Ϊ�գ������ֶβ�����Ϊ��!");
                            noError=false;
                            break;
                        }
                    }

                }
                if (add)   {
                    if ("auto".equals(data[0])){
                        data[0]="auto"+String.valueOf(parsingLineNumber);
                    }
                    impRs.put(data[0],data);
                }
            }
        }
        catch(Exception e){

        }
        finally {
            try {
                if(br != null)
                    br.close();
                if(bw != null){
                    bw.close();
                    if ("1".equals(Constants.EXPORT_CSV2UTF8)){
                        FileUTF2ANSI(errorFile);
                    }
                }
                if (delFile) {
                    f.delete();
                }
            } catch (Exception ea) {
                ea.printStackTrace();
            }
        }
        return noError;
    }

    public static boolean readExcelFile(String absolutePath,
                                        String fileName,
                                        String [] colDataType,
                                        String [] colCodeSet,
                                        String keyDataType,
                                        int keyCol,
                                        Map impRs,
                                        int startCol,
                                        int startRow,
                                        boolean delFile) throws SysException {
        int count = colDataType.length;
        InfoItemBO [] item = new InfoItemBO[count];
        for (int i = 0; i < count; i++) {
            item[i] = new InfoItemBO();
            item[i].setItemDataType(colDataType[i]);
            item[i].setItemCodeSet(colCodeSet[i]);
        }
        return readExcelFile(absolutePath, fileName, item, keyDataType, keyCol, impRs, startCol, startRow, delFile);
    }

    public static void checkExcelFile(String absolutePath,
                                        String fileName,
                                        InfoSetBO set,
                                        InfoItemBO[] cols,
                                        int keyCol,
                                        Map impRs,
                                        int startCol,
                                        int startRow,
                                        boolean delFile,
                                        int nameCol,
                                        String []items) throws SysException{
        
        if (items==null || items.length==0){
            throw new SysException("û�ж�������Ŀ��");
        }
        Hashtable ht=new Hashtable(); // 0   �Ѵ��ڸ�����    1 ���ݿⲻ���ڸ���Ա    2 �Ա�����
        for(int i=0;i<items.length;i++){
            ht.put(items[i],items[i]);
        }
        if (impRs == null) {
            throw new SysException("impRs����Ϊnull");
        } else {
            impRs.clear();
        }

        File f = new File(absolutePath + File.separator + fileName);
        if (!f.exists() || !f.isFile()) {
            throw new SysException("ָ���ļ�������");
        }
        ActivePageAPI api=(ActivePageAPI) SysContext.getBean("sys_activePageApi");
        BufferedReader br = null;
        try {
            //���ļ�
            br = new BufferedReader(new FileReader(f));
            String headerLine = br.readLine(); // ���������
            if(headerLine == null){
                throw new SysException("������ļ�Ϊ�գ��뵼�������ݵ��ļ�!");
            }

            int columns = headerLine.split(",").length;
            if ((cols.length + startCol) > columns) {
                throw new SysException("����ѡ�����Ŀ����Excel�е���Ŀ��������ѡ��!");
            }
            if(startRow < 1){
                startRow = 1;
            }
            for(int i=1;i<startRow;i++){
                br.readLine();
            }
            String lineData ;
            int parsingLineNumber = startRow -1;   //���ڴ�����к�,���ڼ�¼������־��.
            int excelCount=0;
            int errorCount=0;
            while((lineData = br.readLine()) != null){
                parsingLineNumber ++;
                excelCount++;                      // excel��������
                if (lineData.endsWith(",")){
                    lineData+=" "; // ������Ϊ���ţ���������Ϊ��,ֻ�в��Ͽո��split����Ч
                }
                String[] data = lineData.split(",");
                data[data.length-1]=data[data.length-1].trim(); // ������ո񣬻���ȥ��

                String key = data[keyCol];
                String msg="";
                if (key != null && !"".equals(key.trim())) {
                    key = key.trim();
                }
                String sql="select id from a001 where upper(A001077)='"+CommonFuns.ID15to18(key).toUpperCase()+"' or upper(A001077)='"+CommonFuns.ID18to15(key).toUpperCase()+"'";
                String pid=api.queryForString(sql);
                String []error=new String[cols.length+3];
                for(int i=0;i<cols.length+2;i++){
                     error[i]=data[i];
                }

                boolean correct=true;
                if ("".equals(pid)){
                    if (ht.get("1")!=null){
                        errorCount++;
                        error[cols.length+2]="����Ա�������ݿ���";
                        impRs.put(key, error);
                        continue;
                    }
                }else{
                    sql="select id from "+set.getSetId()+" where id='"+pid+"'";
                    if (!"".equals(api.queryForString(sql))){  // ����
                        error[keyCol]=pid;
                        errorCount++;
                        error[cols.length+2]="�������Ѿ����";
                        impRs.put(pid, error);
                    }

                    if (!"".equals(pid) && ht.get("2")!=null){
                        CellVO []head=new CellVO[cols.length+1];
                        sql="select id";
                        head[0]=new CellVO();
                        head[0].setItemId("ID");
                        for(int i=0;i<cols.length;i++){
                            sql+=","+cols[i].getItemId();
                            head[i+1]=new CellVO();
                            head[i+1].setItemId(cols[i].getItemId());
                        }
                        sql+=" from "+set.getSetId()+" where id='"+pid+"'";
                        if (InfoSetBO.RS_TYPE_SINGLE.equals(set.getSet_rsType()) && !"A001".equals(set.getSetId())){
                            sql+=" and "+set.getSetId()+"000='00901'";
                        }
                        Vector vt=api.getDataListBySql(head,sql);
                        if (vt.size()>0){
                            CellVO[]row=(CellVO[])vt.get(0);
                            for(int i=0;i<cols.length;i++){
                                if (CommonFuns.filterNull(error[i+2]).equals(row[i+1].getValue())){
                                   error[i+2]+="��";
                                }
                                else{
                                   error[i+2]+="��";
                                   correct=false;
                                }
                            }
                        }
                    }

                }
                if (correct){
                    error[cols.length+2]+=" һ��";
                }
                else{
                   error[cols.length+2]+=" ��ͬ"; 
                }
                impRs.put(pid, error);
            }
            int rightCount=excelCount-errorCount;
            impRs.put("-1","EXCEL�й�������:"+String.valueOf(excelCount)+" ��������������:"+String.valueOf(errorCount)+" ��ȷ����:"+String.valueOf(rightCount));
        }
        catch(Exception e){
            
        }
    }
    /**
     * ��ȡexcle�ļ�
     *
     *  absolutePath �ļ����·��
     *  fileName     �ļ�����(����·��)
     *  cols         ���ݶ�ȡ�е���������
     *  keyDataType  ��¼������������ A ��ԱID A1��ϵͳԱ�����A001999 A2���ڿ��� A3ʹ�����֤
     *  keyCol       ��������������
     *  impRs        �������ݴ�� ��hastable�����Ϊnull��ִ�ж����ݲ������� key:��Աid������id�ȣ�value��String[] ������һ�¡�
     *  startCol     ��ȡ���ݿ�ʼ��(��0��ʼ)
     *  startRow     ��ȡ���ݿ�ʼ��(��0��ʼ)
     *  delFile      �Ƿ�ɾ��ԭ�ļ� true �ǣ� false ��
     *  nameCol      �����ֶ� -1 ��У�� ����У��
     *    ���� boolean ���ļ������Ƿ��д��������޴��� true,�����д��� false.  ������false,ԭ�ļ���ɾ��������Դ�ļ����������µ�sheet����¼������Ϣ
     *  User         �û���Ϣ
     *  codeType     0 ����   1 ����
     */
    public static boolean readExcelFile(String absolutePath,
                                        String fileName,
                                        InfoItemBO[] cols,
                                        String keyDataType,
                                        int keyCol,
                                        Map impRs,
                                        int startCol,
                                        int startRow,
                                        boolean delFile) throws SysException {
         return readExcelFile(absolutePath,fileName,cols,keyDataType,keyCol, impRs,startCol,startRow, delFile,-1,null,"0");
    }
    public static boolean readExcelFile(String absolutePath,
                                        String fileName,
                                        InfoItemBO[] cols,
                                        String keyDataType,
                                        int keyCol,
                                        Map impRs,
                                        int startCol,
                                        int startRow,
                                        boolean delFile,
                                        int nameCol,
                                        User user,
                                        String codeType) throws SysException {
        if (impRs == null) {
            throw new SysException("impRs����Ϊnull");
        } else {
            impRs.clear();
        }

        if (keyDataType == null || "".equals(keyDataType)) {
            throw new SysException("û��ָ���ļ���������");
        }

        String tempFile=absolutePath + File.separator + fileName;
        String errorFile="";
        // -------����ת��-------
        if ("1".equals(Constants.IMPORT_CSV2UTF8)){
            FileANSI2UTF(tempFile);
        }
        File f = new File(tempFile);
        if (!f.exists() || !f.isFile()) {
            throw new SysException("ָ���ļ�������");
        }

        BufferedReader br = null;
        BufferedWriter bw = null;
        boolean isError = false;
        Hashtable htcode=new Hashtable();   // �������������������
        errorFile=absolutePath + File.separator + "ERROR_" + fileName;
        try {
            //���ļ�
            br = new BufferedReader(new FileReader(f));
            //����������־�ļ�
            bw = new BufferedWriter(new FileWriter(new File(errorFile)));
            //��ȡ��һ��Sheet��

            String headerLine = br.readLine(); // ���������
            if(headerLine == null){
                throw new SysException("������ļ�Ϊ�գ��뵼�������ݵ��ļ�!");
            }

            int columns = headerLine.split(",").length;
            if ((cols.length + startCol) > columns) {
                throw new SysException("����ѡ�����Ŀ����Excel�е���Ŀ��������ѡ��!");
            }
            if(startRow < 1){
                startRow = 1;
            }
            for(int i=1;i<startRow;i++){
                br.readLine();
            }
            String lineData ;
            int parsingLineNumber = startRow -1;   //���ڴ�����к�,���ڼ�¼������־��.
            while((lineData = br.readLine()) != null){
                parsingLineNumber ++;

                if (lineData.endsWith(",")){
                    lineData+=" "; // ������Ϊ���ţ���������Ϊ��,ֻ�в��Ͽո��split����Ч
                }
                String[] data = lineData.split(",");
                data[data.length-1]=data[data.length-1].trim(); // ������ո񣬻���ȥ��
                if(data.length != (cols.length + startCol)){
                    addErrorFormatLabel(bw, parsingLineNumber, keyCol, "Excel������Ŀ��������,���ܵ��룡");
                    isError = true;
                    continue;
                }
                String key = data[keyCol];
                String msg="";
                if (key != null && !"".equals(key.trim())) {
                    key = key.trim();
                    if (keyDataType.startsWith("A")){
                        PersonBO obj=null;
                        if ("A".equals(keyDataType)) {  // Ա�����
                             obj = SysCacheTool.findPersonByCode(key);
                        }
                        else if ("A1".equals(keyDataType)){  //ʹ�þ�ϵͳԱ�����A001999
                             obj = SysCacheTool.findPersonByOldCode(key);
                        }
                        else if ("A2".equals(keyDataType)){  //���ڿ���
                            obj = SysCacheTool.findPersonByAttendCode(key);
                        }
                        else if ("A3".equals(keyDataType)){  //���֤��
                            obj = SysCacheTool.findPersonByIDNum(key);
                        }
                        if (obj == null) {
                            msg="��¼������Ա(���:"+key+")������";
                            addErrorFormatLabel(bw, parsingLineNumber, keyCol, msg);
                            isError = true;
                            continue;
                        }
                        if (nameCol!=-1){ // ����ҪУ������
                            if (data[nameCol]!=null && !data[nameCol].equals(obj.getName())){
                                msg="��¼������Ա���Ʋ�ƥ��(���:"+key+" ϵͳ:"+obj.getName()+" �ļ�:"+data[nameCol]+")";
                                addErrorFormatLabel(bw, parsingLineNumber, keyCol, msg);
                                isError = true;
                                continue;
                            }
                         }
                         if (user!=null && !RoleInfoBO.ORGTYPE_ALL.equals(user.getprocessUnit())){   // ����ȫ����ʱ����Ҫ�ж��Ƿ񱾵�λ��
                               if (!obj.getOrgId().equals(user.getOrgId())){
                                     msg="�Ǳ���λ��Ա(���:"+key+")�����õ���";
                                     addErrorFormatLabel(bw, parsingLineNumber, keyCol, msg);
                                     isError = true;
                                     continue;
                               }
                         }
                         key = obj.getPersonId();
                    }
                    else if ("B".equals(keyDataType)) {
                        OrgBO obj = SysCacheTool.findOrgByCode(key);
                        if (obj == null) {
                            addErrorFormatLabel(bw, parsingLineNumber, keyCol, "��¼���󣬻���������");
                            isError = true;
                            continue;
                        }
                        key = obj.getOrgId();
                    } else if ("C".equals(keyDataType)) {
                        PostBO obj = SysCacheTool.findPost(key);
                        if (obj == null) {
                            addErrorFormatLabel(bw, parsingLineNumber, keyCol, "��¼���󣬸�λ������");
                            isError = true;
                            continue;
                        }
                        key = obj.getPostId();
                    } else if ("D".equals(keyDataType)) {
                        PartyBO obj = SysCacheTool.findParty(key);
                        if (obj == null) {
                            addErrorFormatLabel(bw, parsingLineNumber, keyCol, "��¼���󣬵���֯������");
                            isError = true;
                            continue;
                        }
                        key = obj.getPartyId();
                    }
                } else {
                    //���ֿ����ݣ�ֹͣ��ȡ
                    break;
                }
                int colNum = cols.length;
                String[] rs = new String[colNum];
                boolean colError = false;
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
                SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
                for (int j = startCol; j < startCol + colNum; j++) { //start for
                    String value = data[j];
                    String colDataType = cols[j - startCol].getItemDataType();                   // ��������
                    String colLength=cols[j - startCol].getItemDataLength();                     // ����
                    String colPre=CommonFuns.filterNull(cols[j - startCol].getItemPrecision());  // С��λ

                    if (value != null && !"".equals(value.trim())) {
                        // Ψһ��У�� ��ǰֻУ��A001
                        if (keyDataType.startsWith("A") && "1".equals(cols[j - startCol].getItemIsunique()) && cols[j - startCol].getItemId().startsWith("A001")){
                            String countSql="select count(*) from A001 where "+cols[j - startCol].getItemId()+"='"+value+"' and id<>'"+key+"'";
                            ActivePageAPI api=(ActivePageAPI)SysContext.getBean("sys_activePageApi");
                            if (api.queryForInt(countSql)>0){
                                addErrorFormatLabel(bw, parsingLineNumber, j, cols[j - startCol].getItemName()+"["+value+"]�����ظ�");
                                colError = true;
                            }
                        }
                        if (InfoItemBO.DATA_TYPE_CODE.equals(colDataType)) {
                            String code = value.trim();
                            if ("0".equals(codeType)){  // �������ѯ
                                CodeItemBO tmp = SysCacheTool.findCodeItem(cols[j - startCol].getItemCodeSet(), code);
                                if (tmp == null) {
                                    addErrorFormatLabel(bw, parsingLineNumber, j, "����["+code+"]������");
                                    colError = true;
                                } else {
                                    rs[j - startCol] = tmp.getItemId();
                                }
                            }
                            else{   // ��������ѯ
                               Hashtable itemhash=(Hashtable)htcode.get(cols[j - startCol].getItemCodeSet());
                               if (itemhash==null){   // ����
                                   itemhash=new Hashtable();
                                   List codeitemlist=SysCacheTool.queryCodeItemBySetId(cols[j - startCol].getItemCodeSet());
                                   for(int i=0;i<codeitemlist.size();i++){
                                       CodeItemBO cb=(CodeItemBO)codeitemlist.get(i);
                                       itemhash.put(cb.getItemName(),cb.getItemId());
                                   }
                                   htcode.put(cols[j - startCol].getItemCodeSet(),itemhash);
                               }
                               String newcode=(String)itemhash.get(code);
                               if (newcode!=null){
                                   rs[j - startCol]=newcode;
                               }
                               else{
                                   addErrorFormatLabel(bw, parsingLineNumber, j, "����["+code+"]�����ڶ�Ӧ����");
                                   colError = true;
                               }
                            }
                        } else if (InfoItemBO.DATA_TYPE_ORG.equals(colDataType)) {
                            OrgBO obj = SysCacheTool.findOrgByCode(value.trim());
                            if (obj == null) {
                                addErrorFormatLabel(bw, parsingLineNumber, j, "����["+value+"]������");
                                colError = true;
                            } else {
                                rs[j - startCol] = obj.getOrgId();
                            }
                        } else if (InfoItemBO.DATA_TYPE_PERSON.equals(colDataType)) {
                            PersonBO obj = SysCacheTool.findPersonByCode(value.trim());
                            if (obj == null) {
                                addErrorFormatLabel(bw, parsingLineNumber, j, "��Ա["+value+"]������");
                                colError = true;
                            } else {
                                rs[j - startCol] = obj.getPersonId();
                            }
                        } else if (InfoItemBO.DATA_TYPE_POST.equals(colDataType)) {
                            PostBO obj = SysCacheTool.findPostByCode(value.trim());
                            if (obj == null) {
                                addErrorFormatLabel(bw, parsingLineNumber, j, "��λ������");
                                colError = true;
                            } else {
                                rs[j - startCol] = obj.getPostId();
                            }
                        } else if (InfoItemBO.DATA_TYPE_WAGE.equals(colDataType)) {
                            OrgBO obj = SysCacheTool.findOrgByCode(value.trim());
                            if (obj == null) {
                                addErrorFormatLabel(bw, parsingLineNumber, j, "��н��λ������");
                                colError = true;
                            } else {
                                WageUnitBO bo = SysCacheTool.findWageUnit(obj.getOrgId());
                                if (bo == null) {
                                    addErrorFormatLabel(bw, parsingLineNumber, j, "��н��λ������");
                                    colError = true;
                                } else {
                                    rs[j - startCol] = bo.getUnitId();
                                }
                            }
                        } else if (InfoItemBO.DATA_TYPE_PARTY.equals(colDataType)) {
                            PartyBO obj = SysCacheTool.findParty(value.trim());
                            if (obj == null) {
                                addErrorFormatLabel(bw, parsingLineNumber, j, "����֯������");
                                colError = true;
                            } else {
                                rs[j - startCol] = obj.getPartyId();
                            }
                        } else if (InfoItemBO.DATA_TYPE_INT.equals(colDataType)) {
                            try {
                                String tempStr = value.trim();
                                if (tempStr.indexOf(".") > 0) {
                                    String str = tempStr.substring(0, tempStr.indexOf("."));
                                    Long.parseLong(str);
                                    rs[j - startCol] = str;
                                } else {
                                    Long.parseLong(tempStr);
                                    rs[j - startCol] = tempStr;
                                }
                            } catch (NumberFormatException e) {
                                colError = true;
                                addErrorFormatLabel(bw, parsingLineNumber, j, "���ݸ�ʽ���󣬲�����������");
                            }
                        } else if (InfoItemBO.DATA_TYPE_FLOAT.equals(colDataType)) {
                            try {
                                Double.parseDouble(value.trim());
                                // ��С����ʽ����
                                rs[j - startCol] = CommonFuns.formateItem(colDataType,colPre,value.trim());
                            } catch (NumberFormatException e) {
                                colError = true;
                                addErrorFormatLabel(bw, parsingLineNumber, j, "���ݸ�ʽ���󣬲���С������");
                            }
                        } else if (InfoItemBO.DATA_TYPE_DATE6.equals(colDataType)) {
                            try {
                                value = value.trim();
                                if (value.length() == 6) {
                                    if (Integer.parseInt(value.substring(0, 4)) > 1900
                                            && Integer.parseInt(value.substring(4, 6)) <= 12) {
                                        value = value.substring(0, 4) + "-" + value.substring(4, 6) + "-" + "01";
                                        java.sql.Date dt = java.sql.Date.valueOf(value);
                                        value = sdf.format(dt);
                                        rs[j - startCol] = value;
                                    } else {
                                        throw new Exception();
                                    }
                                } else {
                                    throw new Exception();
                                }
                            } catch (Exception e) {
                                colError = true;
                                addErrorFormatLabel(bw, parsingLineNumber, j, "���ݸ�ʽ���󣬲�����λ����");
                            }
                        } else if (InfoItemBO.DATA_TYPE_DATE.equals(colDataType)) {
                            try {
                                value = value.trim();
                                if (value.length() == 8) {
                                    if (Integer.parseInt(value.substring(0, 4)) > 1900
                                            && Integer.parseInt(value.substring(4, 6)) <= 12
                                            && Integer.parseInt(value.substring(6, 8)) <= 31) {
                                        value = value.substring(0, 4) + "-" + value.substring(4, 6) + "-" + value.substring(6, 8);
                                        java.sql.Date dt = java.sql.Date.valueOf(value);
                                        value = sdf1.format(dt);
                                        rs[j - startCol] = value;
                                    } else {
                                        throw new Exception();
                                    }
                                } else {
                                    throw new Exception();
                                }
                            } catch (Exception e) {
                                colError = true;
                                addErrorFormatLabel(bw, parsingLineNumber, j, "���ݸ�ʽ���󣬲��ǰ�λ����");
                            }
                        } else {
                            rs[j - startCol] = value.trim();
                        }
                    } else {//end content not null
                        rs[j - startCol] = "";
                    }

                }//end for
                // ������¼�Ӽ������ж��е����
                key=key+"|"+String.valueOf(parsingLineNumber);
                if (!colError) impRs.put(key, rs);
                if (!isError && colError) isError = colError;
            }
            return !isError;
        } catch (SysException be) {
            throw be;
        } catch (Exception e) {
            throw new SysException("", "��ȡ�ļ�ʧ��", e, FileUtil.class);
        } finally {
            try {
                if(br != null)
                    br.close();
                if(bw != null) {
                    bw.close();
                    if ("1".equals(Constants.EXPORT_CSV2UTF8)){
                        FileUTF2ANSI(errorFile);
                    }
                }
                if (delFile && !isError) {
                    f.delete();
                }
            } catch (Exception ea) {
                ea.printStackTrace();
            }
        }
    }

    /**
     * ��������Ϣ��¼��������־��
     */
    public static void addErrorFormatLabel(BufferedWriter bw, int row, int col, String error) {
        try {
            bw.write(FileUtil.addCsvField("�� " + row + " ��,�� " + (col+1) + " �� " + error));
            bw.newLine();
            bw.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * �����ļ�
     *  path  �����ļ���ž���·��
     *  table ���ݶ���
     * ���� excel  �����ļ����ƣ�������·����
     */
    public static void exportFile(String path, TableVO table, boolean delFile) throws SysException {
    	exportFile( path,  table,  delFile,false);
    }
    public static void exportFile(String path, TableVO table, boolean delFile,boolean linkDept) throws SysException {
        try {
            File dirPath = new File(path);
            if (!dirPath.exists()) {
                dirPath.mkdirs();
            }
            if (delFile) {
                delDiskFile(path);
            }

            File file = new File(path + "result.xls");
            
            WritableWorkbook book = Workbook.createWorkbook(file);
        	WritableSheet sheet = book.createSheet("sheet", 0);
        	
            CellVO[] header = table.getHeader();
            if (header != null && header.length > 0) {
                int count = header.length;
                int index=0;
                for (int n = 0; n < count; n++) {
                    if (InfoItemBO.DATA_TYPE_CLOB.equals(header[n].getItemDataType())
                            || (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[n].getItemProperty()) && !"B001003".equals(header[n].getItemId()))
                            || header[n].getPermission() == CellVO.PERMISSION_REFUSE
                            || !header[n].getSelected()){

                    } else {
                        if (header[n].isShowId()) {
                        	Label label = new Label(index++, 0, header[n].getItemName()+"����");
                    		sheet.addCell(label);
                        }else{
                        	Label label = new Label(index++, 0, header[n].getItemName());
                        	sheet.addCell(label);                        	
                        }
                    }
                }
            }

            if (table.getRowData() != null && table.getRowData().length > 0) {
                int count = table.getRowData().length;
                for (int i = 0; i < count; i++) {
                    RecordVO rvo = table.getRowData()[i];
                    CellVO[] data = rvo.getCell();
                    int size = data.length;
                    int index=0;
                    for (int n = 0; n < size; n++) {
                        if (InfoItemBO.DATA_TYPE_CLOB.equals(header[n].getItemDataType())
                                || (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(header[n].getItemProperty()) && !"B001003".equals(header[n].getItemId()))
                                || header[n].getPermission() == CellVO.PERMISSION_REFUSE 
                                || !header[n].getSelected()){
                        } else {
                            String value2 ;
                            if (InfoItemBO.DATA_TYPE_CODE.equals(data[n].getItemDataType())) {
                                value2 = CodeUtil.interpertCode(data[n].getItemCodeSet(), data[n].getValue());
                            } else if (InfoItemBO.DATA_TYPE_ORG.equals(data[n].getItemDataType())) {
                                value2 = CodeUtil.interpertCode("OU", data[n].getValue());
                                if (linkDept && "A001705".equals(data[n].getItemId())) {     // ������ʾ����
                                    OrgBO bo = SysCacheTool.findOrgById(data[n].getValue());
                                    OrgBO superbo=SysCacheTool.findOrgById(bo.getSuperId());
                                    if (superbo!=null && OrgBO.DEPTTYPE.equals(superbo.getorgType())){
                                        value2=CommonFuns.filterNull(superbo.getName()+bo.getName());
                                    }
                                }
                            } else if (InfoItemBO.DATA_TYPE_POST.equals(data[n].getItemDataType())) {
                                value2 = CodeUtil.interpertCode("PO", data[n].getValue());
                            } else if (InfoItemBO.DATA_TYPE_PERSON.equals(data[n].getItemDataType())) {
                                value2 = CodeUtil.interpertCode("PE", data[n].getValue());
                            } else if (InfoItemBO.DATA_TYPE_PARTY.equals(data[n].getItemDataType())) {
                                value2 = CodeUtil.interpertCode("PA", data[n].getValue());
                            } else if (InfoItemBO.DATA_TYPE_WAGE.equals(data[n].getItemDataType())) {
                                value2 = CodeUtil.interpertCode("WAGE", data[n].getValue());
                            } else {
                                value2 = CommonFuns.filterNull(data[n].getValue());
                            }
                            try {
                                if (InfoItemBO.DATA_TYPE_INT.equals(data[n].getItemDataType())
                                        || InfoItemBO.DATA_TYPE_FLOAT.equals(data[n].getItemDataType())
                                        || InfoItemBO.DATA_TYPE_COMPUTE.equals(data[n].getItemDataType())) {

                                	Label label = new Label(index++, i+1, value2);
                            		sheet.addCell(label);
                                } else {
                                    if (data[n].isShowId()) {
                                        String id = data[n].getValue();
                                        if (CommonFuns.filterNull(id).length() > 4)
                                            id = id.substring(4, id.length());

                                        Label label = new Label(index++, i+1, value2);
                                        sheet.addCell(label);
                                    }
                                    Label label = new Label(index++, i+1, value2);
                                    sheet.addCell(label);
                                }
                            } catch (Exception e) {
                            	Label label = new Label(index++, i+1, value2);
                            	sheet.addCell(label);
                            }
                        }
                    }
                }
            }
            book.write();
        	book.close();
        } catch (Exception e) {
            throw new SysException("", "����excel����", e, FileUtil.class);
        } 
    }

    public static String exportBankXLSFile(String path,
                                    List bankitem,
                                    List values,
                                    boolean delFile) throws SysException {
           try {
            String filename ;
            if (delFile) {
                delDiskFile(path);
            }
            filename = CommonFuns.getSysDate("yyyyMMddHHmmss") + new Random().nextInt(10000) + ".xls";
            String old = path +File.separator +"blank.xls";
            String newfile = path  +File.separator +filename;

            File ofile = new File(old);
            FileInputStream fin = new FileInputStream(ofile);
            FileOutputStream fout = new FileOutputStream(newfile);

            Workbook template = Workbook.getWorkbook(fin);
            WritableWorkbook xls = Workbook.createWorkbook(fout, template);
            WritableSheet sheet = xls.getSheet(0);
            // ����
            for(int i=0;i<bankitem.size();i++){
                WageBankItemBO wi=(WageBankItemBO)bankitem.get(i);
                Label tlb2=new Label(i,0,wi.getPayName());
                sheet.addCell(tlb2);
            }
            for(int i=0;i<values.size();i++){
                String data[] = (String[]) values.get(i);
                for(int j=0;j<data.length;j++){
                    WageBankItemBO wb=(WageBankItemBO)bankitem.get(j);
                    if (!"seq".equals(wb.getFieldID()) && !"1".equals(wb.getRadixPoint())){ // ����ʾС����
                       data[j]=data[j].replaceAll("\\.","");
                    }
                    if ("yyyy-MM-dd".equals(wb.getDateFormat()) || "yyyyMMdd".equals(wb.getDateFormat()) || "yyyy-MM".equals(wb.getDateFormat()) || "yyyyMM".equals(wb.getDateFormat())){
                        data[j]=CommonFuns.getDateByFormat(data[j],wb.getDateFormat());
                    }
                    if (wb.getBeforeChar()!=null){  //����
                        data[j]=org.apache.commons.lang.StringUtils.leftPad(data[j],Integer.parseInt(wb.getWidth()),wb.getBeforeChar());
                    }
                    if (wb.getBehindChar()!=null){  //�Ҳ���
                        data[j]=org.apache.commons.lang.StringUtils.rightPad(data[j],Integer.parseInt(wb.getWidth()),wb.getBehindChar());
                    }

                    if ("1".equals(wb.getCutStyle()) && !"0".equals(wb.getWidth()) && data[j].length()>Integer.parseInt(wb.getWidth())){ //��ü�
                        data[j]=data[j].substring(0,Integer.parseInt(wb.getWidth()));
                    }
                    if ("0".equals(wb.getCutStyle()) && !"0".equals(wb.getWidth()) && data[j].length()>Integer.parseInt(wb.getWidth())){ //�Ҳü�
                        data[j]=data[j].substring(data[j].length()-Integer.parseInt(wb.getWidth()));
                    }

                    Label tlb=new Label(j,i+1,data[j]);
                    sheet.addCell(tlb);
                }
            }
            xls.write();
            xls.close();
            template.close();
            fin.close();
            fout.close();
            return  filename;
        } catch (Exception ie) {
            throw new SysException("E1400003","��ȡ�ļ�����!",ie,FileUtil.class);
        }
    }

    public static String exportBankTXTFile(String path,
                                    List bankitem,
                                    List values,
                                    boolean showTitle,
                                    boolean delFile) throws SysException {
        BufferedWriter bw = null;
        try {
            File dirPath = new File(path);
            if (!dirPath.exists()) {
                dirPath.mkdirs();
            }

            String dir = path + File.separator;
            String filename ;
            if (delFile) {
                delDiskFile(path);
            }

            filename = CommonFuns.getSysDate("yyyyMMddHHmmss") + new Random().nextInt(10000) + ".txt";
            File f = new File(dir + filename);

            bw = new BufferedWriter(new FileWriter(f));
            StringBuffer sb = new StringBuffer();
            if (showTitle){    // ��ʾ����
                bw.newLine();  //������
                sb.delete(0,sb.length());//���
                for (int n = 0; n < bankitem.size(); n++) {
                    WageBankItemBO wb=(WageBankItemBO)bankitem.get(n);
                    String value2=wb.getPayName();
                    if (wb.getBeforeChar()!=null){  //����
                        value2=CommonFuns.leftPad(value2,Integer.parseInt(wb.getWidth())," ");
                    }
                    if (wb.getBehindChar()!=null){  //�Ҳ���
                        value2=CommonFuns.rightPad(value2,Integer.parseInt(wb.getWidth())," ");
                    }
                    if (wb.getSeparator()!=null){
                        value2+=" ";
                    }
                    sb.append(value2);
                }
                bw.write(sb.toString());
            }

            int colNum = 0;
            int rowNum ;
            if (values != null && values.size() > 0) {
                rowNum = values.size();
                for (int i = 0; i < rowNum; i++) {
                    bw.newLine();  //������
                    sb.delete(0,sb.length());//���
                    String data[] = (String[]) values.get(i);
                    for (int n = 0; n < bankitem.size(); n++) {
                        String value2=data[n];
                        WageBankItemBO wb=(WageBankItemBO)bankitem.get(n);
                        if (!"1".equals(wb.getRadixPoint())){ // ����ʾС����
                           value2=value2.replaceAll("\\.","");
                        }
                        if ("yyyy-MM-dd".equals(wb.getDateFormat()) || "yyyyMMdd".equals(wb.getDateFormat()) || "yyyy-MM".equals(wb.getDateFormat()) || "yyyyMM".equals(wb.getDateFormat())){
                            value2=CommonFuns.getDateByFormat(value2,wb.getDateFormat());
                        }

                        if (wb.getBeforeChar()!=null){  //����
                            value2=CommonFuns.leftPad(value2,Integer.parseInt(wb.getWidth()),wb.getBeforeChar());
                        }
                        if (wb.getBehindChar()!=null){  //�Ҳ���
                            value2=CommonFuns.rightPad(value2,Integer.parseInt(wb.getWidth()),wb.getBehindChar());
                        }
                        if ("1".equals(wb.getCutStyle()) && !"0".equals(wb.getWidth()) && value2.length()>Integer.parseInt(wb.getWidth())){ //��ü�
                            value2=value2.substring(0,Integer.parseInt(wb.getWidth()));
                        }
                        if ("0".equals(wb.getCutStyle()) && !"0".equals(wb.getWidth()) && value2.length()>Integer.parseInt(wb.getWidth())){ //�Ҳü�
                            value2=value2.substring(value2.length()-Integer.parseInt(wb.getWidth()));
                        }

                        if (wb.getSeparator()!=null){
                            if ("9".equals(wb.getSeparator())){
                                value2+="\t";
                            }
                            else{
                               value2+=wb.getSeparator();
                            }
                        }
                        sb.append(value2);
                    }
                    bw.write(sb.toString());
                }
                bw.newLine();  // ����0d0a
            }

            return filename;
        } catch (Exception e) {
            throw new SysException("", "�����ļ�����", e, FileUtil.class);
        } finally {
            try {
                if (bw != null) bw.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // path ·��
    // sets��������
    public static String exportInfoStru(String path,String []sets) throws SysException{
        String filename="";
        BufferedWriter bw=null;
        try{
            File dirPath = new File(path);
            if (!dirPath.exists()) {
                dirPath.mkdirs();
            }

            String dir = path + File.separator;

            filename = CommonFuns.getSysDate("yyyyMMddHHmmss") + new Random().nextInt(10000) + ".txt";
            File f = new File(dir + filename);
            bw = new BufferedWriter(new FileWriter(f));
            StringBuffer sb = new StringBuffer();
            sb.append("                        ==ϵͳ�ṹ˵��==            ");
            bw.write(sb.toString());
            bw.newLine();  // ����0d0a
            sb.delete(0,sb.length());//���
            sb.append("                                          ����ʱ��:"+CommonFuns.getSysDate("yyyy-MM-dd"));
            bw.write(sb.toString());
            bw.newLine();  // ����0d0a
            if (sets!=null){
                for(int i=0;i<sets.length;i++){
                    bw.newLine();  // ����0d0a
                    InfoSetBO setbo=SysCacheTool.findInfoSet(sets[i]);
                    sb.delete(0,sb.length());//���
                    sb.append(setbo.getSetId()).append(setbo.getSetName());
                    bw.write(sb.toString());
                    bw.newLine();  // ����0d0a
                    bw.newLine();  // ����0d0a

                    sb.delete(0,sb.length());//���
                    sb.append("�ֶ�\t����\t����\t����\t��������\t��;");
                    bw.write(sb.toString());
                    bw.newLine();  // ����0d0a

                    List list=SysCacheTool.queryInfoItemBySetId(sets[i]);
                    for(int j=0;j<list.size();j++){
                        InfoItemBO itembo=(InfoItemBO)list.get(j);
                        if (InfoItemBO.PROPERTY_CONTROL_HIDE.equals(itembo.getItemProperty())) continue;
                        sb.delete(0,sb.length());//���
                        sb.append(itembo.getItemId()).append("\t").append(itembo.getItemName()).append("\t").append(CommonFuns.filterNull(itembo.getItemDesc())).append("\t").append(CommonFuns.filterNull(itembo.getItemCodeSet())).append("\t").append(CommonFuns.filterNull(itembo.getItemIssue()));
                        bw.write(sb.toString());
                        bw.newLine();  // ����0d0a
                    }
                }
            }
        }
        catch(Exception e){
            throw new SysException("", "�����ļ�����", e, FileUtil.class);
        }
        finally {
            try {
                if (bw != null) bw.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return filename;
    }
    public static String exportCodeInfo(String path,String []sets) throws SysException{
        String filename="";
        BufferedWriter bw=null;
        try{
            File dirPath = new File(path);
            if (!dirPath.exists()) {
                dirPath.mkdirs();
            }

            String dir = path + File.separator;

            filename = CommonFuns.getSysDate("yyyyMMddHHmmss") + new Random().nextInt(10000) + ".txt";
            File f = new File(dir + filename);
            bw = new BufferedWriter(new FileWriter(f));
            StringBuffer sb = new StringBuffer();
            sb.append("                        ==ϵͳ����˵��==            ");
            bw.write(sb.toString());
            bw.newLine();  // ����0d0a
            sb.delete(0,sb.length());//���
            sb.append("                                          ����ʱ��:"+CommonFuns.getSysDate("yyyy-MM-dd"));
            bw.write(sb.toString());
            bw.newLine();  // ����0d0a
            if (sets!=null){
                for(int i=0;i<sets.length;i++){
                    bw.newLine();  // ����0d0a
                    CodeSetBO setbo=SysCacheTool.findCodeSet(sets[i]);
                    sb.delete(0,sb.length());//���
                    sb.append(setbo.getSetId()).append(setbo.getSetName());
                    bw.write(sb.toString());
                    bw.newLine();  // ����0d0a
                    bw.newLine();  // ����0d0a

                    sb.delete(0,sb.length());//���
                    sb.append("Ψһ����\t�û�����\t����");
                    bw.write(sb.toString());
                    bw.newLine();  // ����0d0a

                    List list=SysCacheTool.queryCodeItemBySetId(sets[i]);
                    for(int j=0;j<list.size();j++){
                        CodeItemBO itembo=(CodeItemBO)list.get(j);
                        sb.delete(0,sb.length());//���
                        sb.append(itembo.getItemId()).append("\t").append(itembo.getUserItemId()).append("\t").append(CommonFuns.filterNull(itembo.getItemName()));
                        bw.write(sb.toString());
                        bw.newLine();  // ����0d0a
                    }
                }
            }
        }
        catch(Exception e){
            throw new SysException("", "�����ļ�����", e, FileUtil.class);
        }
        finally {
            try {
                if (bw != null) bw.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return filename;
    }

    /**
     * �����ļ�
     *
     *  path        �����ļ���ž���·��
     *  header      ��ͷ����
     *  colDataType �е��������͡� ���鳤�Ⱥ���ͷ����һ�£���һһ��Ӧ���������ͺ�ָ������������һ�¡��������ʱ����Ҫ�����ݽ��д�����Ϊnull��
     *  values      ���ݼ�¼ ��        ÿһ����¼����String[]�����Ⱥ���ͷ����һ�£���һһ��Ӧ��
     * ���� excel      �����ļ����ƣ�����·����
     */
    public static String exportFile(String path,
                                    String [] header,
                                    String [] colDataType,
                                    List values, boolean delFile) throws SysException {
        BufferedWriter bw = null;

        try {
            if (header != null && colDataType != null && colDataType.length != colDataType.length) {
                throw new SysException("�������ͺ���ʾ��ͷ���Ȳ�ƥ��");
            }
            File dirPath = new File(path);
            if (!dirPath.exists()) {
                dirPath.mkdirs();
            }

            String dir = path + File.separator;
            String filename ;
            if (delFile) {
                delDiskFile(path);
            }

            filename = CommonFuns.getSysDate("yyyyMMddHHmmss") + new Random().nextInt(10000) + ".csv";
            File f = new File(dir + filename);

            bw = new BufferedWriter(new FileWriter(f));
            StringBuffer sb = new StringBuffer();
            int colNum = 0;
            int rowNum ;
            if (header != null && header.length > 0) {
                colNum = header.length;
                for (int n = 0; n < colNum; n++) {
                    sb.append(FileUtil.addCsvField(header[n]));
                }
                sb.delete(sb.length()-1,sb.length());
                bw.write(sb.toString());
            }
            if (values != null && values.size() > 0) {
                rowNum = values.size();
                for (int i = 0; i < rowNum; i++) {
                    bw.newLine();  //������
                    sb.delete(0,sb.length());//���

                    String data[] = (String[]) values.get(i);
                    for (int n = 0; n < colNum; n++) {
                        String value2 ;
                        if (colDataType != null) {
                            if (InfoItemBO.DATA_TYPE_CODE.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_ORG.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("OU", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_POST.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("PO", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_PERSON.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("PE", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_PARTY.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("PA", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_WAGE.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("WAGE", data[n]);
                            } else {
                                value2 = CommonFuns.filterNull(data[n]);
                            }
                            try {
                                if (InfoItemBO.DATA_TYPE_INT.equals(colDataType[n])
                                        || InfoItemBO.DATA_TYPE_FLOAT.equals(colDataType[n])
                                        || InfoItemBO.DATA_TYPE_COMPUTE.equals(colDataType[n])) {
//                                    jxl.write.Number labelN = new jxl.write.Number(n, i + 1, Double.parseDouble(value2));
//                                    sheet.addCell(labelN);
                                    sb.append(FileUtil.addCsvField(value2));
                                } else {
                                    sb.append(FileUtil.addCsvField(value2));
                                }
                            } catch (Exception e) {
                                sb.append(FileUtil.addCsvField(value2));
                            }
                        } else {
                            value2 = CommonFuns.filterNull(data[n]);
                            sb.append(FileUtil.addCsvField(value2));
                        }
                    }
                    //д�����ļ�
                    sb.delete(sb.length()-1,sb.length());
                    bw.write(sb.toString());
                }
            }

            return filename;
        } catch (Exception e) {
            throw new SysException("", "����excel����", e, FileUtil.class);
        } finally {
            try {
                if (bw != null) bw.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public static String exportFileWithOtherInfo(String path,
                                                 List otherInfo,
                                                 String [] header,
                                                 String [] colDataType,
                                                 List values, boolean delFile) throws SysException {


           BufferedWriter bw = null;
        try {
            if (header != null && colDataType != null && colDataType.length != colDataType.length) {
                throw new SysException("�������ͺ���ʾ��ͷ���Ȳ�ƥ��");
            }
            File dirPath = new File(path);
            if (!dirPath.exists()) {
                dirPath.mkdirs();
            }

            String dir = path + File.separator;
            String filename ;
            if (delFile) {
                delDiskFile(path);
            }

            filename = CommonFuns.getSysDate("yyyyMMddHHmmss") + new Random().nextInt(10000) + ".csv";
            File f = new File(dir + filename);

             bw = new BufferedWriter(new FileWriter(f));
            StringBuffer sb = new StringBuffer();
            int rowIndex = 0;
            if (otherInfo != null && otherInfo.size() > 0) {
                for (int i = 0; i < otherInfo.size(); i++) {
                    String [] info = (String[]) otherInfo.get(i);
                    if (info != null && info.length > 0) {
                        for (int j = 0; j < info.length; j++) {
                            sb.append(FileUtil.addCsvField(info[j]));
                        }
                        sb.delete(sb.length()-1,sb.length());
                        bw.write(sb.toString());
                        rowIndex++;
                    }
                }
            }
            int colNum = 0;
            int rowNum ;
            if (header != null && header.length > 0) {
                colNum = header.length;
                bw.newLine();
                sb.delete(0,sb.length());

                for (int n = 0; n < colNum; n++) {
                    sb.append(FileUtil.addCsvField(header[n]));
                }
                sb.delete(sb.length()-1,sb.length());
                bw.write(sb.toString());
            }
            if (values != null && values.size() > 0) {
                rowNum = values.size();
                for (int i = rowIndex; i < rowNum + rowIndex; i++) {
                    String data[] = (String[]) values.get(i - rowIndex);
                    for (int n = 0; n < colNum; n++) {
                        String value2 ;
                        if (colDataType != null) {
                            if (InfoItemBO.DATA_TYPE_CODE.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_ORG.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("OU", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_POST.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("PO", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_PERSON.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("PE", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_PARTY.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("PA", data[n]);
                            } else if (InfoItemBO.DATA_TYPE_WAGE.equals(colDataType[n])) {
                                value2 = CodeUtil.interpertCode("WAGE", data[n]);
                            } else {
                                value2 = CommonFuns.filterNull(data[n]);
                            }
                            try {
                                if (InfoItemBO.DATA_TYPE_INT.equals(colDataType[n])
                                        || InfoItemBO.DATA_TYPE_FLOAT.equals(colDataType[n])
                                        || InfoItemBO.DATA_TYPE_COMPUTE.equals(colDataType[n])) {
//                                    jxl.write.Number labelN = new jxl.write.Number(n, i + 1, Double.parseDouble(value2));
//                                    sheet.addCell(labelN);
                                    sb.append(FileUtil.addCsvField(value2));
                                } else {
                                    sb.append(FileUtil.addCsvField(value2));
                                    sb.append(FileUtil.addCsvField(value2));
                                }
                            } catch (Exception e) {
                                sb.append(FileUtil.addCsvField(value2));
                                sb.append(FileUtil.addCsvField(value2));
                            }
                        } else {
                            value2 = CommonFuns.filterNull(data[n]);
                            sb.append(FileUtil.addCsvField(value2));
                            sb.append(FileUtil.addCsvField(value2));
                        }
                    }
                    sb.delete(sb.length()-1,sb.length());
                    bw.write(sb.toString());
                }
            }

            return filename;
        } catch (Exception e) {
            e.printStackTrace();
            throw new SysException("", "����excel����", e, FileUtil.class);
        }finally{
            try {
               if(bw != null)bw.close();

            }catch(Exception e){
                e.printStackTrace();
            }
        }
    }

    /**
     * �õ�����·�����ļ��� ���� ����·��
     *
     *  fullFileName �ļ�ȫ������·����
     *  isPath       �Ƿ񷵻��ļ�����·��
     * ���� �ļ�����
     */
    public static boolean fileExists(String fullFileName) throws SysException {
        File f = new File(fullFileName);
        if (f.exists()) {
             return true;
        }
        return false;
    }
    
    public static String getFileNameOrPath(String fullFileName, boolean isPath) throws SysException {
        if (fullFileName == null || "".equals(fullFileName)) {
            return "";
        }
        File f = new File(fullFileName);
        if (f.exists()) {
            if (isPath) {
                f.getAbsolutePath();
            } else {
                return f.getName();
            }
        } else {
            throw new SysException("ָ���ļ���Ŀ¼������");
        }
        return "";
    }

    /**
     * ɾ��ָ��·���µ��ļ� ������excel�ļ�
     *
     *  path
     */
    public static void delDiskFile(String path) {
        File dir = new File(path);
        String[] filename = dir.list();
        if (filename == null) return;
        int count = filename.length;
        String date = CommonFuns.getSysDate("yyyyMMdd");
        for (int i = 0; i < count; i++) {
            String str = filename[i];
            if (str.indexOf(date) == -1 && str.indexOf("csc") > -1) {
                File f = new File(path + File.separator + filename[i]);
                f.delete();
            }
        }
    }
    // ɾ���ļ�
    public static void FileDelete(String src) throws IOException{
        File f = new File(src);
        f.delete();
    }
    // �����ļ�
    public static void FileCopy(String src, String dst) throws IOException{
         InputStream in = new FileInputStream(new File(src));
         OutputStream out = new FileOutputStream(new File(dst));

         byte[] buf = new byte[1024];
         int len;
         while ((len = in.read(buf)) > 0){
             out.write(buf, 0, len);
         }
         in.close();
         out.close();
    }

    // �����ļ�
    public static byte[]ReadInFile(String fileName) throws IOException{
        InputStream in = new FileInputStream(new File(fileName));

        byte[] buf = new byte[in.available()];
        in.read(buf);
        in.close();
        return buf;
    }
    public static void createDirectory(String directory, String subDirectory) {
        String dir[];
        File fl = new File(directory);
        try {
          if (!fl.exists())  fl.mkdir();
          if (!"".equals(subDirectory)) {
            dir = subDirectory.replace('\\', '/').split("/");
            for (int i = 0; i < dir.length; i++) {
              File subFile = new File(directory + File.separator + dir[i]);
              if (!subFile.exists()) subFile.mkdir();
              directory += File.separator + dir[i];
            }
          }
        }
        catch (Exception ex) {
        	ex.printStackTrace();
        }
      }

    // ���ؽ⿪�ļ����б�
    public static List unZip(String zipFileName, String outputDirectory) throws Exception {
        List fileList=new ArrayList();
        try {
            createDirectory(outputDirectory, "");
            ZipFile zipFile = new ZipFile(zipFileName);
            Enumeration e = zipFile.getEntries();
            while (e.hasMoreElements()) {
                ZipEntry zipEntry =  (ZipEntry)e.nextElement();
                if (zipEntry.isDirectory()) {
                      String name = zipEntry.getName();
                      name = name.substring(0, name.length() - 1);
                      File f = new File(outputDirectory + File.separator + name);
                      f.mkdir();
                }
                else {
                  String fileName = zipEntry.getName();
                  fileList.add(fileName);
                  fileName = fileName.replace('\\', '/');
                  if (fileName.indexOf("/") != -1){
                      createDirectory(outputDirectory,
                                      fileName.substring(0, fileName.lastIndexOf("/")));
                  }
                  File f = new File(outputDirectory + File.separator + zipEntry.getName());
                  f.createNewFile();
                  InputStream in = zipFile.getInputStream(zipEntry);
                  FileOutputStream out=new FileOutputStream(f);

                  byte[] by = new byte[1024];
                  int c;
                  while ( (c = in.read(by)) != -1) {
                    out.write(by, 0, c);
                  }
                  out.close();
                  in.close();
               }
            }
            zipFile.close();
        }
        catch (Exception ex) {
        	ex.printStackTrace();
        }
        return fileList;
  }

  public static void transPhotoToPNG(String oldfile,String newfile)  throws Exception {
      RenderedImage img = ImageIO.read(new File(oldfile));
      ImageIO.write(img, "png", new File(newfile));
  }
  public static void GenSmallJPG(String oldfile,String newfile,float tagsize)  throws Exception {
      java.io.File file = new java.io.File(oldfile); //����ղ��ϴ����ļ�
      Image src = javax.imageio.ImageIO.read(file); //����Image����
      int old_w = src.getWidth(null); //�õ�Դͼ��
      int old_h = src.getHeight(null);
      int new_w = 0;
      int new_h = 0; //�õ�Դͼ��
      //int tempsize;
      float tempdouble;
      if (old_w > old_h) {
          tempdouble = old_w / tagsize;
      } else {
          tempdouble = old_h / tagsize;
      }
      new_w = Math.round(old_w / tempdouble);
      new_h = Math.round(old_h / tempdouble);//������ͼ����
      BufferedImage tag = new BufferedImage(new_w, new_h,
              BufferedImage.TYPE_INT_RGB);
      tag.getGraphics().drawImage(src, 0, 0, new_w, new_h,null); //������С���ͼ
      FileOutputStream newimage = new FileOutputStream(newfile); //������ļ���
      JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(newimage);
      encoder.encode(tag); //��JPEG����
      newimage.close();
  }

  public static void addPhotoToExcel(String excelFile,String pngfile,int row,int col) throws Exception {
       File file= new File(excelFile);

       Workbook wb = Workbook.getWorkbook(file);
       WritableWorkbook wwb = jxl.Workbook.createWorkbook(new File(excelFile),wb);
       WritableSheet sheet = wwb.getSheet(0);

       // ȡ��ͼƬ��Ԫ���С�������Ǻϲ��ģ�
       int colspan=1;
       int rowspan=1;
       Range[] ranges =sheet.getMergedCells();
       for(int i=0;i<ranges.length;i++){
           if (ranges[i].getTopLeft().getRow()==row && ranges[i].getTopLeft().getColumn()==col){
               colspan=ranges[i].getBottomRight().getColumn()-ranges[i].getTopLeft().getColumn()+1;
               rowspan=ranges[i].getBottomRight().getRow()-ranges[i].getTopLeft().getRow()+1;
               break;
           }
       }
       File fileImage=new File(pngfile);
       WritableImage image=new WritableImage(col,row,colspan,rowspan,fileImage);//��A1��ʼ ��2��3����Ԫ��
       sheet.addImage(image);
       wwb.write();
       wwb.close();
       wb.close();
  }

    private static Document xml2FO(Document xml, String styleSheet) {
        DOMSource xmlDomSource = new DOMSource(xml);
        DOMResult domResult = new DOMResult();

        Transformer transformer = getTransformer(styleSheet);

        try {
            transformer.transform(xmlDomSource, domResult);
        }
        catch (javax.xml.transform.TransformerException e) {
            return null;
        }
        return (Document) domResult.getNode();

        }

    private static byte[] fo2PDF(Document foDocument) {

        DocumentInputSource fopInputSource = new DocumentInputSource(
                                                         foDocument);

        try {

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            Logger log = new ConsoleLogger(ConsoleLogger.LEVEL_WARN);

            Driver driver = new Driver(fopInputSource, out);
            driver.setLogger(log);
            driver.setRenderer(Driver.RENDER_PDF);
            driver.run();

            return out.toByteArray();

        } catch (Exception ex) {
            return null;
        }
    }


    private static Transformer getTransformer(String styleSheet) {
	try {

	    TransformerFactory tFactory = TransformerFactory.newInstance();

	    DocumentBuilderFactory dFactory = DocumentBuilderFactory.newInstance();

	    dFactory.setNamespaceAware(true);

	    DocumentBuilder dBuilder = dFactory.newDocumentBuilder();
	    Document xslDoc = dBuilder.parse(styleSheet);
	    DOMSource xslDomSource = new DOMSource(xslDoc);

	    return tFactory.newTransformer(xslDomSource);

	}
	catch (javax.xml.transform.TransformerException e) {
	    e.printStackTrace();
	    return null;
	}
	catch (java.io.IOException e) {
	    e.printStackTrace();
	    return null;
	}
	catch (javax.xml.parsers.ParserConfigurationException e) {
	    e.printStackTrace();
	    return null;
	}
	catch (org.xml.sax.SAXException e) {
	    e.printStackTrace();
	    return null;
	}
 }

  public static void Html2Pdf(String htmlFileName,String styleSheet) throws SysException {
      FileInputStream input = null;
      try {
        input = new FileInputStream(htmlFileName);
      }
      catch (java.io.FileNotFoundException e) {
          throw new SysException("File not found: " + htmlFileName);
      }
      Tidy tidy = new Tidy();
      Document xmlDoc = tidy.parseDOM(input, null);
      Document foDoc = xml2FO(xmlDoc, styleSheet);

      String pdfFileName = htmlFileName.substring(0, htmlFileName.indexOf(".")) + ".pdf";
      try {
          OutputStream pdf = new FileOutputStream(new File(pdfFileName));
          pdf.write(fo2PDF(foDoc));
      }
      catch (java.io.FileNotFoundException e) {
          throw new SysException("Error creating PDF: " + pdfFileName);
      }
      catch (java.io.IOException e) {
          throw new SysException("Error writing PDF: " + pdfFileName);
      }
  }
  public static void modifyExcelContent(WritableSheet sheet,WritableCell cell,String content)throws Exception {
      if (sheet==null || cell==null) return;
      CellFormat cf=cell.getCellFormat();
      Label l=new Label(cell.getColumn(),cell.getRow(),CommonFuns.filterNull(content));
      if (cf!=null)    l.setCellFormat(cf);
      sheet.addCell(l);
  }
  public static String exportTaxRptFile(String path,List dataTable) throws SysException {
      try {
          String filename = CommonFuns.getSysDate("yyyyMMddHHmmss") + new Random().nextInt(10000) + ".xls";
          String old = path +"file"+File.separator +"wage"+File.separator+"template"+File.separator+"TaxRpt.xls";
          String newfile = path +"file" +File.separator +"wage"+File.separator+"download"+File.separator+filename;
          FileCopy(old,newfile);
          File fout = new File(newfile);
          Workbook fin=Workbook.getWorkbook(fout);
          WritableWorkbook xls = Workbook.createWorkbook(fout,fin);
          
          WritableSheet sheet = xls.getSheet(0);
          int row=0;
          int startrow=-1;
          int PersonCount=-1;
          int A815713=-1;
          int A815714=-1;
          int A815708=-1;
          int TaxFree=-1;
          int Rate=-1;
          int Deduction=-1;
          int orgrow=-1,orgcol=-1;
          int daterow=-1,datecol=-1;
          while(row<10){
              for(int col=0;col<10;col++){
                  Cell cell=sheet.getCell(col,row);
                  if ("[OrgName]".equals(cell.getContents())){
                      orgrow=row;
                      orgcol=col;
                  }
                  else if ("[Date]".equals(cell.getContents())){
                     daterow=row;
                     datecol=col;
                  }
                  else if ("[PersonCount]".equals(cell.getContents())){
                      PersonCount=col;
                  }
                  else if ("[A815713]".equals(cell.getContents())){
                      startrow=row;
                      A815713=col;
                  }
                  else if ("[A815708]".equals(cell.getContents())){
                      A815708=col;
                  }
                  else if ("[A815714]".equals(cell.getContents())){
                      A815714=col;
                  }
                  else if ("[TaxFree]".equals(cell.getContents())){
                      TaxFree=col;
                  }
                  else if ("[Rate]".equals(cell.getContents())){
                      Rate=col;
                  }
                  else if ("[Deduction]".equals(cell.getContents())){
                      Deduction=col;
                  }
              }
              row++;
          }

          // ������
          if (dataTable!=null && dataTable.size()>0){
              for(int k=0;k<dataTable.size();k++){
                  TableVO table=(TableVO)dataTable.get(k);
                  String sheetName="";
                  if (table.getSetName()!=null && !"".equals(table.getSetName())){
                      sheetName=table.getSetName();
                  }
                  else{
                      sheetName="sheet"+String.valueOf(k+1);
                  }
                  xls.copySheet(0,sheetName,k+1);
                  sheet = xls.getSheet(k+1);
                  if (orgrow!=-1 && orgcol!=-1) modifyExcelContent(sheet,sheet.getWritableCell(orgcol,orgrow),table.getSetName());  // ����
                  if (daterow!=-1 && datecol!=-1) modifyExcelContent(sheet,sheet.getWritableCell(datecol,daterow),table.getTag());  // ʱ��
                  for(int j=0;j<table.getRowData().length;j++){
                      CellVO[]cells=table.getRowData()[j].getCell();
                      int pos=startrow+j;
                      if (PersonCount!=-1){
                           modifyExcelContent(sheet,sheet.getWritableCell(PersonCount,pos),cells[0].getValue());
                      }
                      if (A815713!=-1){
                          modifyExcelContent(sheet,sheet.getWritableCell(A815713,pos),cells[1].getValue());
                      }
                      if (A815714!=-1){
                          modifyExcelContent(sheet,sheet.getWritableCell(A815714,pos),cells[2].getValue());
                      }
                      if (Rate!=-1){
                          modifyExcelContent(sheet,sheet.getWritableCell(Rate,pos),cells[3].getValue());
                      }
                      if (Deduction!=-1){
                          modifyExcelContent(sheet,sheet.getWritableCell(Deduction,pos),cells[4].getValue());
                      }
                      if (A815708!=-1){
                          modifyExcelContent(sheet,sheet.getWritableCell(A815708,pos),cells[5].getValue());
                      }
                      if (TaxFree!=-1){
                          modifyExcelContent(sheet,sheet.getWritableCell(TaxFree,pos),cells[6].getValue());
                      }

                  }
              }
              xls.removeSheet(0);
          }
          xls.write();
          xls.close();
          return filename;
      } catch (Exception ie) {
          throw new SysException("E1400003","��ȡ�ļ�����run��",ie,FileUtil.class);
      }
  }
  public static void copyFile(String oldPath, String newPath) {
        try {
            int bytesum = 0;
            int byteread = 0;
            File oldfile = new File(oldPath);
            if (oldfile.exists()) { //�ļ�����ʱ
                FileInputStream inStream = new FileInputStream(oldPath); //����ԭ�ļ�
                FileOutputStream fs = new FileOutputStream(newPath);
                byte[] buffer = new byte[1444];
                int length;
                while ( (byteread = inStream.read(buffer)) != -1) {
                    bytesum += byteread; //�ֽ��� �ļ���С
                    fs.write(buffer, 0, byteread);
                }
                inStream.close();
                fs.close();
              }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
  }

  public static void FileUTF2ANSI(String path){
      String bak=path+".bak";
      copyFile(path,bak);
      try{
        Reader streamReader = new InputStreamReader(new FileInputStream(bak), "UTF-8");
        BufferedReader reader = new BufferedReader(streamReader);
        String line = null;
        //BufferedWriter  bw = new BufferedWriter(new FileWriter(path));
        BufferedWriter  bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path),"GBK"));
        while ((line = reader.readLine()) != null) {
            bw.write(line);
            bw.newLine();
        }
        reader.close();
        bw.close();
      }
      catch(Exception e){

      }
  }
    public static void FileANSI2UTF(String path){
        String bak=path+".bak";
        copyFile(path,bak);
        try{
          Reader streamReader = new InputStreamReader(new FileInputStream(bak),"GBK");
          BufferedReader reader = new BufferedReader(streamReader);
          String line = null;
          BufferedWriter  bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path),"UTF-8"));
          while ((line = reader.readLine()) != null) {
              bw.write(line);
              bw.newLine();
          }
          reader.close();
          bw.close();
          // ���ϱ�ʾ
        }
        catch(Exception e){

        }
     }

  /* window �������� linu����
  public static void FileANSI2UTF(String path){
      File f=new File(path);
      try{
          byte[] bs=new byte[(int)f.length()];
          FileInputStream fis=new FileInputStream(f);
          try{
              int io=0;
              while(io<bs.length){
                  int n=fis.read(bs,io,bs.length-io);
                  if(n<=0){
                      break;
                  }
              }
              }
          finally{
                  fis.close();
          }
          String s=new String(bs);
          bs=s.getBytes("UTF-8");
          FileOutputStream fos=new FileOutputStream(f);
          try{
              byte[] head=new byte[3];
              head[0]=(byte)0xef;
              head[1]=(byte)0xbb;
              head[2]=(byte)0xbf;
              fos.write(head);
              fos.write(bs);
          }
          finally{
              fos.close();
          }
       }
       catch(Exception e){
       }
   }
   */
}
