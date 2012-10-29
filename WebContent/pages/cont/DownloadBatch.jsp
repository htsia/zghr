<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="com.hr319wg.common.ucc.IAttachmentUCC" %>
<%
    try {
        java.util.Date dateTmp = new java.util.Date();
        java.text.SimpleDateFormat bartDateFormat = new java.text.SimpleDateFormat("yyyy_MM_dd");
        String dateStr = bartDateFormat.format(dateTmp);
        String k = (new Double(Math.random())).toString(); //随机数

        response.setContentType("");
        response.setHeader("Content-Disposition", "attachment;filename=" + new String(com.hr319wg.util.CommonFuns.filterNull("合同-" + dateStr + ".zip").getBytes("GBK"), "ISO8859_1"));
        response.setHeader("Expires", "Tues,01 Jan 1980 00:00:00 GMT");

        IAttachmentUCC ucc = (com.hr319wg.common.ucc.IAttachmentUCC) SysContext.getBean("common_attachmentUCC");
        com.hr319wg.cont.ucc.IContPersonUCC ucc_contPerson = (com.hr319wg.cont.ucc.IContPersonUCC) SysContext.getBean("cont_iContPersonUCC");

        String ids[] = request.getParameterValues("selected_ids");

        ServletOutputStream outputStream = response.getOutputStream();
        java.io.BufferedOutputStream bros = new java.io.BufferedOutputStream(outputStream);
        org.apache.tools.zip.ZipOutputStream zipos = new org.apache.tools.zip.ZipOutputStream(bros);

        for (int i = 0; i < ids.length; i++) {
            String[] temp = com.hr319wg.util.CommonFuns.getStringArray(ids[i], ",");

            String personName = "";
            com.hr319wg.emp.pojo.bo.PersonBO personbo = com.hr319wg.sys.cache.SysCacheTool.findPersonById(temp[1]);
            if (personbo != null) {
                personName = personbo.getName();
            } else {
                com.hr319wg.cont.pojo.bo.ContPersonBO contPersonbo = ucc_contPerson.findContPersonById(temp[1]);
                if (contPersonbo != null) {
                    personName = contPersonbo.getPersonName();
                }
            }
             if(temp.length==3){
            byte[] fileContent = ucc.getFileContent(temp[2]);
            //设置压缩方法
            zipos.setMethod(org.apache.tools.zip.ZipOutputStream.DEFLATED);
            String zipName = "合同-[" + personName + "].rtf";
            zipos.putNextEntry(new org.apache.tools.zip.ZipEntry(zipName));
            zipos.write(fileContent, 0, fileContent.length);
            zipos.closeEntry();
             }else{
            	 String str="该人员无任何合同文件数据!";
            byte[] fileContent =str.getBytes();
            //设置压缩方法
            zipos.setMethod(org.apache.tools.zip.ZipOutputStream.DEFLATED);
            String zipName = "合同-[" + personName + "].rtf";
            zipos.putNextEntry(new org.apache.tools.zip.ZipEntry(zipName));
            zipos.write(fileContent, 0, fileContent.length);
            zipos.closeEntry();
             }


        }

        zipos.close();
        bros.close();
        outputStream.flush();

    } catch (Exception e) {
        out.println("\n downloadBatch error!");
    }
%>
