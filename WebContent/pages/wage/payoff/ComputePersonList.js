        function openChangeRecord(){
            window.showModalDialog("/wage/payoff/showChangeRecord.jsf?SetID="+form1.all("form1:setId").value+"&PayoffMonth="+document.all('form1:payoffDate').value.substr(0,7), null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return false;
        }
        function viewFinish(){
            window.showModalDialog("/wage/gross/GrossPlanStauts.jsf?Year="+document.all('form1:payoffDate').value.substr(0,4)+"&orgID="+form1.all("form1:unitId").value, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:no;status:no;scroll:yes;");
            return false;
        }

        function doCheckDate(){
            var setid=form1.all("form1:setId").value;
            window.showModalDialog("/wage/payoff/doCheckData.jsf?setID="+setid, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function  doselfQuery(){
            document.all("form1:WageDept").value="-1";
            return doAdvanceQuery('A','ORG','011','Y','','','N','152','N');
        }
        function showDeptdiff(){
            var url="/wage/payoff/ShowDeptDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height=460,width=800,top=40,left=40,scrollbars=yes');
            return false;
        }
        function forViewPerson(form, id, type){
            window.showModalDialog("/wage/payoff/wagePersonquery.jsf?pID="+id, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
        }
        function doViewCard(){
            var ID=getFirstSelectValue(form1.chk);
            //debugger;
            if (ID!=null && ID!=""){
               window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value+"&ID="+ID, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            }else{
               window.showModalDialog("/wage/payoff/ShowCard.jsf?setId="+document.all("form1:setId").value, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            }
            return false;
        }
        function doClearZero() {
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var arg = "act=clearSetInput&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId;
            var reval = window.showModalDialog("/wage/set/SetInputClear.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }
        function doQueryManyPerson(){
            var reval = window.showModalDialog("/common/ManyPersonCon.jsf", null, "dialogWidth:550px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
            if (reval != null && reval !="") {
                document.all('form1:ManyPerson').value = reval;
                return true;
            } else {
                return false;
            }
        }
        function doShowItem() {
            var arg = "setId=" + form1.all("form1:setId").value;
            var reval = window.showModalDialog("/wage/payoff/ComputeShowItemEdit.jsf?" + arg, null, "dialogWidth:600px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
            if (reval != null) {
                form1.all('form1:str').value = reval;
                return true;
            } else {
                return false;
            }
        }
        function doSetConst(){
            var url="/wage/set/SetConst.jsf?dateId="+form1.all("form1:dateId").value+"&setId="+form1.all("form1:setId").value+"&setName="+form1.all("form1:setName").value;
            window.showModalDialog(url, null, "dialogWidth:500px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doExport(setId) {
           window.open('/wage/payoff/SetSelectToExport.jsf?setId='+setId,'','toolbar=0,scrollbars=1,height='+screen.height*0.8+',width=500,top=40,left='+(screen.width-500)/2);
        }
        function doReinforce(){
            var url="/wage/set/ReinForce.jsf?setid="+form1.all("form1:setId").value+"&unitid="+form1.all("form1:unitId").value;
            var reval = window.showModalDialog( url, null, "dialogWidth:800px; dialogHeight:550px;center:center;resizable:yes;status:no;scroll:yes;");
            //alert(reval);
            if (reval != null && reval != "") {
                document.all("form1:addPerson").value=reval;
                return true;
            } else {
                return false;
            }
        }
        function  doBatch(){
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var arg="unitId="+unitId+"&setId="+setId+"&setName="+setName;
            window.showModalDialog("/wage/payoff/batchUpdate.jsf?" + arg, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }

        // 模板录入
        function doTemplateInput(){
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var unitName=form1.all("form1:unitName").value;
            var dateId=form1.all("form1:dateId").value;
            var arg="dateId="+dateId+"&unitId="+unitId+"&setId="+setId+"&setName="+setName+"&unitName="+unitName;
            //alert(arg);
            var reval = window.showModalDialog("/wage/set/InputEdit.jsf?" + arg, null, "dialogWidth:"+screen.width*0.8+"px; dialogHeight:"+screen.height*0.8+"px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }
        function doRestore(){
            var str = window.showModalDialog("/wage/set/RestoreSelect.jsf?setID=" + form1.all("form1:setId").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");

            if (str != null && str!="") {
                document.all("form1:deletePerson").value=str;
                return true;
            }
            else{
                return false;
            }
        }
        // 部门信息
        function doDeptInput(){
            var url="/wage/set/DeptInfoList.jsf?setId="+form1.all("form1:setId").value+"&unitId=" + form1.all("form1:unitId").value+"&setName="+form1.all("form1:setName").value+"&dateId="+form1.all("form1:dateId").value;
            //alert(url);
            window.showModalDialog(url, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

        function doUploadFile() {
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var arg = "act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId+"&showOnlyCheck=true";
            var reval = window.showModalDialog("/wage/set/SetInputUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }
        function doUploadFileOnlyInput() {
            var setName = form1.all("form1:setName").value;
            var unitId = form1.all("form1:unitId").value;
            var setId = form1.all("form1:setId").value;
            var arg = "act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId+"&showOnlyCheck=false";
            var reval = window.showModalDialog("/wage/set/SetInputUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            if (reval != null) {
                return true;
            } else {
                return false;
            }
        }

         // 导入考勤数据
         function doUploadAttFile() {
             var setName = form1.all("form1:setName").value;
             var unitId = form1.all("form1:unitId").value;
             var setId = form1.all("form1:setId").value;
             var arg = "act=attInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId;
             var reval = window.showModalDialog("/wage/set/SetInputUpload.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
             if (reval != null) {
                 return true;
             } else {
                 return false;
             }
         }

        function refreshList() {
             showProcessBar();
            return true;
        }
        function showSum(){
            var url="/wage/payoff/ShowSumInfo.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            window.open(url,'','toolbar=0,height='+screen.height*0.8+',width='+screen.width*0.9+',top='+screen.height*0.1+',left='+screen.width*0.05);
            return false;
        }
        function showdiff(){
            var url="/wage/payoff/ShowDiff.jsf?unitId="+form1.all("form1:unitId").value+"&setId="+form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value;
            var ret=window.showModalDialog(url,'',"dialogWidth:"+screen.width*0.9+"px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            if (ret=="refresh"){
                document.all('form1:queryPerson').click();
            }
            return false;
        }

        function showProcessBar() {
           x = document.body.clientWidth / 2 - 150;
           y = document.body.clientHeight / 2;
           document.all('processbar').style.top = y;
           document.all('processbar').style.left = x;
           document.all('processbar').style.display = "";
        }
        function doSelectManyDept(){
            window.showModalDialog("/wage/payoff/WageManyDept.jsf?SetId=" + form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value+"&unitId="+form1.all("form1:unitId").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;
        }
        function doApply(){
            window.showModalDialog("/wage/payoff/showApply.jsf?dateId="+form1.all("form1:dateId").value+"&setName=" + form1.all("form1:setName").value+"&unitId="+form1.all("form1:unitId").value+"&unitName="+form1.all("form1:unitName").value, null, "dialogWidth:480px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }

         function doPayoff(){
             window.showModalDialog("/wage/payoff/PayoffDialog.jsf?dateId="+form1.all("form1:dateId").value+"&setName=" + form1.all("form1:setName").value, null, "dialogWidth:500px; dialogHeight:250px;center:center;resizable:yes;status:no;scroll:yes;");
             return false;
         }

         
        function showSpecialQuery(){
            if (document.all('form1:SpecialQuery').value==""){
                alert("请选择查询方式！");
            }
            else{
               if (document.all('form1:SpecialQuery').value=="-1"){
                   document.all('form1:queryquestion').click();
               }
                if (document.all('form1:SpecialQuery').value=="-1"){
                    document.all('form1:queryAllQestion').click();
                }
               else{
                  window.showModalDialog("/wage/payoff/specialQuery.jsf?ID="+document.all('form1:SpecialQuery').value+"&setID="+document.all('form1:setId').value, null, "dialogWidth:"+screen.width*0.95+"px; dialogHeight:600px;center:center;resizable:no;status:no;scroll:yes;");
               }
            }
        }

        function OpenRpt(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var url="/pages/report/ServerReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                     +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;
            window.open(url);
            return false;
        }
        function OpenRptByControl(){
            if (document.all("form1:ReportID").value=="-1"){
                alert("请先选择表格样式！");
                return false;
            }
            var url="/pages/report/ClientReportShow.jsp?RptCode="+document.all("form1:ReportID").value+"&ID=&ORGUID="+document.all("form1:unitId").value+"&Parameter="+document.all("form1:setId").value
                     +"&Title="+document.all("form1:setId").value+"_"+document.all("form1:dateId").value+"_"+document.all("form1:ReportID").value;
            window.open(url);
            return false;
        }

        function doOrderCalc(){
            if (form1.all("form1:groupLevel").value!="DEPT_NAME"){
                alert("必须选择最细层次的部门!");
                return false;
            }
            if (form1.all("form1:WageDept").value=="-1" || form1.all("form1:WageDept").value=="-2"){
                alert("请选择部门");
                return false;
            }
            return true;
        }
        function doCheckSelect() {
            if (checkMutilSelect(form1.chk)) {
                showProcessBar();
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
        }
        function beginGroup(){
            if (document.all("form1:sortList").value=="-1") {
                alert("没有选择汇总信息项");
            }
            else{
               window.showModalDialog("/wage/payoff/ShowGroup.jsf?SetId=" + form1.all("form1:setId").value+"&GroupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            }
            return false;
        }

        function beginClass(){
            if (document.all("form1:sortList").value=="-1") {
                alert("没有选择汇总信息项");
            }
            else{
               window.showModalDialog("/wage/payoff/ShowClass.jsf?SetId=" + form1.all("form1:setId").value+"&GroupField="+form1.all("form1:sortList").value, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
            }
            return false;
        }

         function OpenRptByDept(){
            if (form1.chk!=null && form1.chk!=undefined){
                count = form1.chk.length;
            }
            else{
                count=null;
            }
            var str = "";
            if (count != null && count!=undefined) {
                var num = 0;
                for (i = 0; i < count; i++)
                    if (form1.chk[i].checked) {
                        str += form1.chk[i].value.replace("#","~") + ",";
                        num++;
                    }
                if (num > allCount) {
                    alert("最多只能选择"+allCount+"个人员");
                    return false;
                }
            } else if (form1.chk!=null && form1.chk!=undefined)
                str = form1.chk.value.replace("#","~");

            var url="/report/DeptReportShow.jsf?unitId="+document.all("form1:unitId").value+"&setId="+document.all("form1:setId").value
                     +"&setName="+form1.all("form1:setName").value+"&pids="+str+"&dateId="+document.all('form1:dateId').value;
            window.showModalDialog( url, null, "dialogWidth:450px; dialogHeight:400px;center:center;resizable:yes;status:no;scroll:yes;");
            return true;// 返回true 以便涮新界面 从而得到部门权限session
        }

        // 按标准表计算
        function doSetStandard(){
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value.replace("#","~") + ",";
                            num++;
                        }
                    if (num > allCount) {
                        alert("最多只能选择"+allCount+"个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value.replace("#","~");
                var setName = form1.all("form1:setName").value;
                var unitId = form1.all("form1:unitId").value;
                var setId = form1.all("form1:setId").value;
                var arg = "isTry=false&act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId + "&str=" + str;
                var reval = window.showModalDialog("/wage/set/SetStardard.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
        }
         function doAttendSelectInput() {
             if (checkMutilSelect(form1.chk)) {
                 count = form1.chk.length;
                 var str = "";
                 if (count != null) {
                     var num = 0;
                     for (i = 0; i < count; i++)
                         if (form1.chk[i].checked) {
                             str += form1.chk[i].value + ",";
                             num++;
                         }
                     if (num > allCount) {
                         alert("最多只能选择<%=Constants.ACTIVE_PAGE_SIZE%>个人员");
                         return false;
                     }
                 } else
                     str = form1.chk.value;
                 str=str.replace("#","~");  // #不能出现
                 var setName = form1.all("form1:setName").value;
                 var unitId = form1.all("form1:unitId").value;
                 var setId = form1.all("form1:setId").value;
                 var arg = "act=attInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId + "&str=" + str;
                 var reval = window.showModalDialog("/wage/set/SetInputSelect.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
                 if (reval != null) {
                     return true;
                 } else {
                     return false;
                 }
             } else {
                 alert("请选择人员");
                 return false;
             }
         }

        function doSingleInput() {
            if (checkMutilSelect(form1.chk)) {
                var id=getFirstSelectValue(form1.chk);
                window.showModalDialog("/wage/set/SingleInputEdit.jsf?setId=" + form1.all("form1:setId").value+"&perID="+id+"&dateId="+form1.all("form1:dateId").value, null, "dialogWidth:600px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
                return true;
            }
            else{
                return false;
            }
        }
        function doSelectInput() {
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value.replace("#","~") + ",";
                            num++;
                        }
                    if (num > allCount) {
                        alert("最多只能选择"+allCount+"个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value.replace("#","~");
                var setName = form1.all("form1:setName").value;
                var unitId = form1.all("form1:unitId").value;
                var setId = form1.all("form1:setId").value;
                var dateId = form1.all("form1:dateId").value;
                var arg = "act=selectSetInput" + "&setName=" + setName + "&unitId=" + unitId + "&setId=" + setId + "&str=" + str+"&dateId="+dateId;
                var reval = window.showModalDialog("/wage/set/SetInputSelect.jsf?" + arg, null, "dialogWidth:"+screen.width*0.9+"px; dialogHeight:"+screen.height*0.9+"px;center:center;resizable:yes;status:no;scroll:yes;");
                if (reval != null) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择人员");
                return false;
            }
        }
        function doBaseInfoInput() {
            if (checkMutilSelect(form1.chk)) {
                //debugger;
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value.replace("#","~") + ",";
                            num++;
                        }
                    if (num > allCount) {
                        alert("最多只能选择"+allCount+"个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value.replace("#","~");
                var setName = form1.all("form1:setName").value;
                var unitName = form1.all("form1:unitName").value;
                var unitId = form1.all("form1:unitId").value;
                var setId = form1.all("form1:setId").value;
                var arg = "setName=" + setName + "&unitId=" + unitId + "&unitName="+unitName+"&setId=" + setId + "&str=" + str;
                var reval = window.showModalDialog("/wage/set/BaseInputSelect.jsf?" + arg, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
                if (reval != null) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择人员");
                return false;
            }
        }

        function doDelete(){
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value + ",";
                            num++;
                        }
                    if (num > allCount) {
                        alert("最多只能选择"+allCount+"个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value;
                //alert(str);
                document.all("form1:deletePerson").value=str;
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
        }
        function doTaxExport(){
            var dateId=form1.all("form1:dateId").value;
            window.showModalDialog("/wage/payoff/CreateTaxFile.jsf?dateId="+dateId, null, "dialogWidth:350px; dialogHeight:500px;center:center;resizable:yes;status:no;scroll:yes;");
            return false;
        }
        function doOrderInput() {
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value.replace("#","~") + ",";
                            num++;
                        }
                    if (num > allCount) {
                        alert("最多只能选择"+allCount+"个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value.replace("#","~");
                var reval = window.showModalDialog("/wage/set/OrderInput.jsf?setId="+form1.all("form1:setId").value+"&PerStr=" + str, null, "dialogWidth:800px; dialogHeight:600px;center:center;resizable:yes;status:no;scroll:yes;");
                if (reval != null) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择人员");
                return false;
            }
        }

        function     doaddManyDept(){
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value.replace("#","~") + ",";
                            num++;
                        }
                    if (num > allCount) {
                        alert("最多只能选择"+allCount+"个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value;
                var reval = window.showModalDialog("/wage/payoff/BatchAddWageManyDept.jsf?SetId=" + form1.all("form1:setId").value+"&dateId="+form1.all("form1:dateId").value+"&unitId="+form1.all("form1:unitId").value+"&PerStr=" + str, null, "dialogWidth:500px; dialogHeight:200px;center:center;resizable:yes;status:no;scroll:yes;");
                if (reval != null) {
                    return true;
                } else {
                    return false;
                }
            } else {
                alert("请选择人员");
                return false;
            }
        }
        function modifyOk(){
            if (checkMutilSelect(form1.chk)) {
                count = form1.chk.length;
                var str = "";
                if (count != null) {
                    var num = 0;
                    for (i = 0; i < count; i++)
                        if (form1.chk[i].checked) {
                            str += form1.chk[i].value + ",";
                            num++;
                        }
                    if (num > allCount) {
                        alert("最多只能选择"+allCount+"个人员");
                        return false;
                    }
                } else
                    str = form1.chk.value;
                document.all("form1:str").value=str;
                return true;
            } else {
                alert("请选择人员");
                return false;
            }
        }
