<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="/pages/include/taglib.jsp"%>
<%@ page import="com.hr319wg.sys.configuration.LanguageSupport" %>
<x:saveState id="upFileBackingBean" value="#{upFileBackingBean}" />
<h:form id="form1" enctype="multipart/form-data" >
<h:inputHidden value="#{upFileBackingBean.pageinit}"></h:inputHidden>
 
  <h:panelGrid columns="1"  width="98%" align="center">
    <h:panelGrid columns="1"  styleClass="td_title" width="100%" cellpadding="4" align="center" border="0" >
        <h:panelGroup>
            <h:graphicImage value="/images/tips.gif" />
             <f:verbatim>
             <%=LanguageSupport.getResource("YXGL-0898","����ϴ�")%>  
            </f:verbatim>
        </h:panelGroup>
    </h:panelGrid>

    <h:panelGrid columns="4" border="0" cellspacing="5" align="right">
��������<h:commandButton value="�ϴ����" onclick="showUpFilePopDialog();" styleClass="button01"/>
        <h:commandButton value="�� ��" action="#{upFileBackingBean.changefiles}" styleClass="button01"/>
        <h:commandButton value="ɾ ��" action="#{upFileBackingBean.delectfiles}" styleClass="button01"/>
    </h:panelGrid>

    <h:dataTable value="#{upFileBackingBean.listweb}" var="filelist"  id="dateList"
                 headerClass="td_top" width="100%" columnClasses="td_middle_center" align="center" border="1" styleClass="table03" >
                  <h:column>
                  <f:facet name="header">
                             <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1022","ѡ��")%>  
                              </f:verbatim>
                       </f:facet>
                 <x:selectOneRadio id="scs" forceId="true" forceIdIndex="false" value="#{upFileBackingBean.choseattachid}">
                      <f:selectItem itemLabel="" itemValue="#{filelist.attachid}"/>
                       </x:selectOneRadio>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                           <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1023","�ļ���")%>  
                              </f:verbatim>
                        </f:facet>
                        <h:outputText value="#{filelist.filename}" escape="false"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                             <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1024","�� ��")%>  
                              </f:verbatim>
                        </f:facet>
                        <h:outputText value="#{filelist.describe}" escape="false"/>
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                         <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1025","�ļ���С")%>  
                              </f:verbatim>
                        
                        </f:facet>
                        <h:outputText value="#{filelist.filesize}" />
                    </h:column>

                    <h:column>
                        <f:facet name="header">
                        <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1005","����ʱ��")%>  
                              </f:verbatim>
                        </f:facet>
                        <h:outputText value="#{filelist.datetime}" />
                    </h:column>

                    <h:column>
                    <f:facet name="header">
                       <f:verbatim>
                                  <%=LanguageSupport.getResource("YXGL-1026","�� ��")%>  
                              </f:verbatim>
                    </f:facet>
                    <f:verbatim><a target="_blank" href="</f:verbatim><h:outputText value="#{filelist.relativepath}"/><f:verbatim>">
              			<f:verbatim>
              			 <%=LanguageSupport.getResource("YXGL-1027","����")%>  
              			</f:verbatim>                      
                               </a></f:verbatim>

                    </h:column>
    </h:dataTable>
	
    </h:panelGrid>

</h:form>

<script type="text/javascript">
    setDataTableOver("form1:dateList");
   function showUpFilePopDialog() {
        var sFeature="dialogWidth:400px;dialogHeight:250px;Status:0;resizable:true;help:0";
        //������֯����ID

        var url="/run/UpFilePop.jsf?";
        var result=window.showModalDialog(url,window,sFeature);
	}
</script>