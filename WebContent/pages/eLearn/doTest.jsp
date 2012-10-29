<%@ page import="com.hr319wg.scorm.paperLibService" %>
<%@ page import="com.hr319wg.common.web.SysContext" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hr319wg.scorm.questLibService" %>
<%@ page import="com.hr319wg.eLearn.pojo.bo.*" %>
<%@ page import="com.hr319wg.scorm.testService" %>
<%@ page import="java.util.Hashtable" %>
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="../include/taglib.jsp" %>
<%
    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
%>

<script type="text/javascript">
    CenterMenu = 1;
    MenuBorder = 100;
    TimeCheck  = 250;
    TimeUpdate = 15;
    DivUpdate  = 15;
    Minimum    = 50;
    AddHeight  = -4;
    function GetObjectHeight(Object) {
         if (document.all || document.documentElement) {
            Clip = Object.style.clip;
             if (! Clip) {
                 return Object.offsetHeight;
             }
             else  {
                 return GetClipElement (Clip, 'Bottom');
             }
         }
         else if (document.layers) {
             return Object.clip.height;
         }
    }

    function GetWindowOffsetTop() {
         if (window.innerHeight)   {
             return window.pageYOffset;
         }
         else if (document.body){
             return document.body.scrollTop;
         }
    }
    function GetWindowHeight() {
        if (window.innerHeight)   {
            return window.innerHeight;
        }
        else if (document.body)
        {
            return document.body.clientHeight;
        }
    }
    function GetObjectOffsetTop(Object) {
       if (Object.offsetTop) {
           return Object.offsetTop;
       }
       else if (document.layers) {
           return Object.top;
       }
    }
    function SetObjectOffsetTop(Object, Offset) {
       if (Object.style) {
           Object.style.top = Offset;
       }
       else if (Object.top)  {
           Object.top = Offset;
       }
    }

    function ScrollMenu() {
         Menu      = document.all('timer');
         WinTop    = GetWindowOffsetTop();
         WinHeight = GetWindowHeight() + AddHeight;
         MenuTop   = GetObjectOffsetTop(Menu);
         MenuHeight = GetObjectHeight (Menu);
         MenuNew   = (CenterMenu) ? Math.round (WinTop + (WinHeight - MenuHeight) / 1) : WinTop + MenuBorder;
        if (MenuNew < Minimum){
            MenuNew = Minimum;
        }
        if (MenuTop != MenuNew) {
            if ( (MenuTop + MenuHeight) < WinTop || MenuTop > (WinTop + WinHeight) ) {
                SetObjectOffsetTop (Menu, (MenuTop < MenuNew) ? (WinTop - MenuHeight) : (WinTop + WinHeight));
            }
            else {
             Add = (MenuTop < MenuNew) ? 1 : -1;
              SetObjectOffsetTop (Menu, MenuTop + Math.round((MenuNew - MenuTop) / DivUpdate) + Add);
             }
        }
        window.setTimeout('ScrollMenu()', (GetObjectOffsetTop(Menu) == MenuNew) ? TimeCheck : TimeUpdate);
   }
   function document_onkeydown() {
    if(((event.ctrlKey)&&(event.keyCode==69))           //Ctrl + E
    ||((event.ctrlKey)&&(event.keyCode==70))        //Ctrl + F
    ||((event.ctrlKey)&&(event.keyCode==72))        //Ctrl + H
    ||((event.ctrlKey)&&(event.keyCode==73))        //Ctrl + I
    ||((event.ctrlKey)&&(event.keyCode==78))        //Ctrl + N
    ||((event.ctrlKey)&&(event.keyCode==79))        //Ctrl + O
    ||((event.ctrlKey)&&(event.keyCode==80))        //Ctrl + P
    ||((event.ctrlKey)&&(event.keyCode==67))        //Ctrl + F
    ||((event.ctrlKey)&&(event.keyCode==86))        //Ctrl + F
    ||((event.ctrlKey)&&(event.keyCode==83))){      //Ctrl + S
       event.keyCode=0;
       event.returnValue=false;
    }

    if(event.keyCode==8){                               //BackSpace
        if(!((event.srcElement.type=='text')||(event.srcElement.type=='password')||(event.srcElement.type=='textarea'))){
            event.keyCode=0;
            event.returnValue=false;}
    }

    if((event.keyCode==116)                             //F5
        ||(event.keyCode==122)){                        //F11
          event.keyCode=0;
          event.returnValue=false;}

    if(event.altKey){//Alt + Left ; Alt + Right
        if(((event.keyCode==37)||(event.keyCode==39))){
             window.alert('考试期间禁止该操作！');
             event.keyCode=0;
             event.returnValue=false;
        }
     }
 }

</script>

<x:saveState value="#{eLearn_testBB}"/>
<h:form id="form1">
    <h:inputHidden value="#{eLearn_testBB.beginTest}"></h:inputHidden>
    <h:inputHidden  id='starttime' value="#{eLearn_testBB.starttime}" />
    <h:inputHidden  id='endtime' value="#{eLearn_testBB.endtime}" />
    <h:inputHidden  id='nowtime'  />
    <h:inputHidden  id='nian' value="#{eLearn_testBB.nian}" />
    <h:inputHidden  id='yue' value="#{eLearn_testBB.yue}" />
    <h:inputHidden  id='ri' value="#{eLearn_testBB.ri}" />
    <h:inputHidden  id='shi' value="#{eLearn_testBB.shi}" />
    <h:inputHidden  id='fen' value="#{eLearn_testBB.fen}" />
    <h:inputHidden  id='miao' value="#{eLearn_testBB.miao}" />

    <h:outputText escape="false" value="<br><center><font face='隶书' size='14pt'>#{eLearn_testBB.testbo.paperName}考试</font></center>"></h:outputText>

    <c:verbatim>
    <table width=98% align="center">
        <tr>
        <td>
    </c:verbatim>
          <h:outputText escape="false" value="<br><center>考试时间:#{eLearn_testBB.testbo.testminute}分钟</center>"></h:outputText>
    <c:verbatim>
       </td>
       </tr>

        <tr>
        <td align="right" >
        <table><tr><td>
     </c:verbatim>
                <h:commandButton id="pashStop" value="暂停考试" styleClass="button01" style="display:none" action="#{eLearn_testBB.midStop}"></h:commandButton>
    <c:verbatim>
        </td><td>
    </c:verbatim>
                <h:commandButton id="save" value="保存" styleClass="button01"  style="display:none" action="#{eLearn_testBB.saveTest}"></h:commandButton>
                <h:commandButton id="finish" value="结束考试" styleClass="button01" style="display:none" action="#{eLearn_testBB.finishTest}"></h:commandButton>
                <h:commandButton id="close" value="关闭" styleClass="button01"  style="display:none" type="button" onclick="window.close();"></h:commandButton>
    <c:verbatim>
     </td>
    	</tr>
    	</table>
        </td>
        </tr>

        <%
            eLearnPaperBO bo = (eLearnPaperBO) session.getAttribute("PAPER");  // 考卷
            TestPersonBO pb = (TestPersonBO) session.getAttribute("PERSON");   // 考生

            paperLibService plib = (paperLibService) SysContext.getBean("eLearn_paperservice");
            questLibService qlib = (questLibService) SysContext.getBean("eLearn_libservice");
            testService testservice = (testService) SysContext.getBean("eLearn_testservice");
            Hashtable ht =testservice.getResultByPersonAndTest(pb.getItemID(),bo.getPaperID());
            if ("1".equals(pb.getIsfinish())) {
                out.println("<tr><td>");
                out.println("您已经于" + pb.getTestDate() + "参加过本考试了!");
                out.println("<script type=\"text/javascript\">");
                out.println("           document.all('form1:close').style.display='block';");
                out.println("</script>");
                out.println("</td></tr>");
            }else if("1".equals(pb.getIsOnTime())){
            	out.println("<tr><td>");
                out.println("考试还没有开始!");
                out.println("<script type=\"text/javascript\">");
                out.println("           document.all('form1:close').style.display='block';");
                out.println("</script>");
                out.println("</td></tr>");
            }
            else if("2".equals(pb.getIsOnTime())){
            	out.println("<tr><td>");
                out.println("考试已经结束!");
                out.println("<script type=\"text/javascript\">");
                out.println("           document.all('form1:close').style.display='block';");
                out.println("</script>");
                out.println("</td></tr>");
            }
            else {
                out.println("<tr><td>");
                out.println("<script type=\"text/javascript\">");
                out.println("debugger;");
                out.println("           document.all('form1:finish').style.display='block';");
                out.println("           document.all('form1:pashStop').style.display='block';");
                out.println("</script>");
                out.println("</td></tr>");
                
                List sessionList = plib.getChildPaperItemSet(bo.getPaperID());
                int allCount = 0;
                for (int i = 0; i < sessionList.size(); i++) {
                    PaperItemSetBO setbo = (PaperItemSetBO) sessionList.get(i);
                    List questionList = plib.getChildItem(setbo.getSetID());
                    String str = setbo.getSetName() + "&nbsp;&nbsp;共" + String.valueOf(questionList.size()) + "题";
                    out.println("<tr><td> ");
                    out.println("<table cellspaing='0' cellpadding='0' width='100%' class='table02'>");
                    out.println("<tr><td align='center' bgcolor=\"#2074C5\">");
                    out.println(str);
                    out.println("<input type='button' class='button01' value='保存' onclick='document.all(\"form1:save\").click();'>");
                    out.println("</td>");
                    out.println("<tr>");

                    for (int j = 0; j < questionList.size(); j++) {
                        allCount++;
                        PaperItemBO item = (PaperItemBO) questionList.get(j);
                        TestPersonResultBO resultbo=(TestPersonResultBO)ht.get(item.getItemID());
                        String select=(resultbo!=null)?resultbo.getResult():"";
                        QuestionBO qb = qlib.findeQuestionBO(item.getLinkID());
                        out.println("<tr><td>");
                        if (QuestionBO.QUESTION_TYPE_SINGLE.equals(qb.getQuestionType())) {
                            str = "<strong>" + String.valueOf(allCount) + "、" + qb.getTitle() + "(" + item.getScore() + ")</strong><br>";
                            out.println(str);

                            List answerList = qlib.getAllAnswerList(qb.getQuestionID());
                            for (int k = 0; k < answerList.size(); k++) {
                                AnswerListBO answer = (AnswerListBO) answerList.get(k);
                                if (select.equals(answer.getAnswerCode())) {
                                    str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + answer.getAnswerID() + "' type='radio'  checked value='" + answer.getAnswerCode() + "' name='" + item.getItemID() + "'>" + answer.getAnswerCode() + "、" + answer.getAnswerName() + "<br>";
                                }
                                else{
                                    str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + answer.getAnswerID() + "' type='radio'   value='" + answer.getAnswerCode() + "' name='" + item.getItemID() + "'>" + answer.getAnswerCode() + "、" + answer.getAnswerName() + "<br>";
                                }
                                out.println(str);
                            }
                        } else if (QuestionBO.QUESTION_TYPE_MUTL.equals(qb.getQuestionType())) {
                            str = "<strong>" + String.valueOf(allCount) + "、" + qb.getTitle() + "</strong><br>";
                            out.println(str);

                            List answerList = qlib.getAllAnswerList(qb.getQuestionID());
                            for (int k = 0; k < answerList.size(); k++) {
                                AnswerListBO answer = (AnswerListBO) answerList.get(k);
                                if (select.indexOf(answer.getAnswerCode())>=0) {
                                    str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT name='" + answer.getAnswerID() + "' type='checkbox'  value='" + answer.getAnswerCode() + "' checked>" + answer.getAnswerCode() + "、" + answer.getAnswerName() + "<br>";
                                }
                                else{
                                    str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT name='" + answer.getAnswerID() + "' type='checkbox'  value='" + answer.getAnswerCode() + "' >" + answer.getAnswerCode() + "、" + answer.getAnswerName() + "<br>";
                                }
                                out.println(str);
                            }
                        } else if (QuestionBO.QUESTION_TYPE_REPLAY.equals(qb.getQuestionType())) {
                            if (qb.getLowChars() != null && !"".equals(qb.getLowChars())) {
                                out.println("<br><strong>" + String.valueOf(allCount) + "、" + qb.getTitle() + "( 最少" + qb.getLowChars() + "字)</strong><br>");
                            } else {
                                out.println("<br><strong>" + qb.getTitle() + "</strong><br>");
                            }
                            out.println("&nbsp;&nbsp;&nbsp;&nbsp;<textarea name='" + item.getItemID() + "' rows=6 cols=80>"+select+"</textarea>");
                        } else if (QuestionBO.QUESTION_TYPE_JUDGE.equals(qb.getQuestionType())) {
                            str = "<strong>" + String.valueOf(allCount) + "、" + qb.getTitle() + "</strong><br>";
                            out.println(str);
                            if ("1".equals(select)){
                                str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "1' type='radio'   value='1' name='" + item.getItemID() + "' checked>对 &nbsp;&nbsp";
                            }
                            else{
                                str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "1' type='radio'   value='1' name='" + item.getItemID() + "'>对 &nbsp;&nbsp";
                            }
                            out.println(str);
                            if ("0".equals(select)){
                              str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "0' type='radio'   value='0' name='" + item.getItemID() + "' checked>错<br>";
                            }
                            else{
                                str = "&nbsp;&nbsp;&nbsp;&nbsp;<INPUT id='" + qb.getQuestionID() + "0' type='radio'   value='0' name='" + item.getItemID() + "'>错<br>";
                            }
                            out.println(str);
                        }
                        out.println("</td><tr>");
                    }
                    out.println("</table>");
                    out.println("</td><tr>");
                }
            }
        %>
    </table>
    </c:verbatim>
    <c:verbatim>
    <% 
    	TestPersonBO pb2 = (TestPersonBO) session.getAttribute("PERSON");   // 考生
    	if("3".equals(pb2.getIsOnTime())){
    %>
    <div id='timer' style='position: absolute; height:153; width:126; right:20; top:106;z-index: 100; visibility: hidden' >
    <table bgcolor="gray" width=98%>
        <tr><td align="center">记时器</td></tr>
        <tr><td>
            开始时间<br>
            <input type='text' name='mystarttime' size='11'   readonly style='text-align: center' >
        </td></tr>

        <tr><td>
            结束时间<br>
            <input type='text' name='myendtime' size='11'   readonly style='text-align: center' >
        </td></tr>

        <tr><td>
            剩余时间<br>
            <input type='text' name='lefttime' size='11'   readonly style='text-align: center' >
        </td></tr>

        <tr><td>
            现在时间<br>
            <input type='text' name='nowtime' size='11'   readonly style='text-align: center' >
        </td></tr>
        
    </table>
    </div>
    <%
    }else{
    %>
    <div id='timer' style='position: absolute; height:153; width:126; right:20; top:106;z-index: 100; visibility: hidden' >
    <table bgcolor="gray" width=98% style="display: none">
        <tr><td align="center">记时器</td></tr>
        <tr><td>
            开始时间<br>
            <input type='text' name='mystarttime' size='11'   readonly style='text-align: center' >
        </td></tr>

        <tr><td>
            结束时间<br>
            <input type='text' name='myendtime' size='11'   readonly style='text-align: center' >
        </td></tr>

        <tr><td>
            剩余时间<br>
            <input type='text' name='lefttime' size='11'   readonly style='text-align: center' >
        </td></tr>

        <tr><td>
            现在时间<br>
            <input type='text' name='nowtime' size='11'   readonly style='text-align: center' >
        </td></tr>
        
    </table>
    
    </div>
    <%
    }
    %>
   </c:verbatim>
</h:form>

<script type="text/javascript">
    document.all('timer').style.visibility='visible';
    ScrollMenu();
    document.all.mystarttime.value=document.all("form1:starttime").value;
    document.all.myendtime.value=document.all("form1:endtime").value;

    var lasttime=90*60*1000;

    startclock();
    var timerID = null;
    var timerRunning = false;

    function stopclock (){
        if(timerRunning)   clearTimeout(timerID);
        timerRunning = false;
    }
            
    function showtime () {
        var now = new Date();
        var year = now.getYear();
        var month = now.getMonth() + 1;
        var date = now.getDate();
        var hours = now.getHours();
        var minutes = now.getMinutes();
        var seconds = now.getSeconds();

        var timeValue = hours + ':' + minutes + ':' + seconds; // 现在时间
        var nian = document.all('form1:nian').value;
        var yue = document.all('form1:yue').value - 1;
        var ri = document.all('form1:ri').value ;
        var shi = document.all('form1:shi').value ;
        var fen = document.all('form1:fen').value;
        var miao = document.all('form1:miao').value ;

        var endt= new Date();  // 结束时间
        endt.setFullYear(nian,yue,ri)
        endt.setHours(shi,fen,miao)

        var chaju = endt.getTime() - now.getTime();
        var myh = Math.floor(chaju / (1000 * 60 * 60))
        var mym=Math.floor((chaju /(1000*60)) % 60)
        var mys=Math.floor((chaju /1000)%60)
        document.all.nowtime.value = timeValue
        document.all.lefttime.value =myh+':'+mym+':'+mys;
        if (myh==0 && mym==0 && mys==0){
             alert('考试时间到，请提交您的试卷！');
             document.all('form1:finish').click();
        }
        if (document.all.lefttime.value=='0:1:0'){
          alert('考试时间还剩1分钟，请注意保存！');
        }
        if (document.all.lefttime.value=='0:0:10'){
            alert('还剩10秒钟，请保存答案，并提交试卷！');
        }

        timerID = setTimeout('showtime()',1000);
        timerRunning = true;
    }

    function startclock () {
        stopclock();
        showtime();
    }

</script>
