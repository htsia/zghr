/**
 * 查询指标库的公共函数
 * @param codec  指标库Id表单控件value保存指标库的值
 * @param valuec 指标库名称表单控件value保存指标库的名称
 * 调用示例   Sel360KeyLib(document.all('form1:superId'),document.all('form1:superName'))
 */
function Sel360KeyLib(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/xys/eva/Sel360KeyLib.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
/**
 * 查询指标的公共函数
 * @param codec  指标Id表单控件value保存指标的值
 * @param valuec 指标库名称表单控件value保存指标库的名称
 * @param keyType 指标类型
 * 调用示例 Sel360Key(document.all('form1:superId'),document.all('form1:superName'),'1')
 */
function Sel360Key(codec, valuec,keyType) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/xys/eva/Sel360Key.jsp?keyType="+keyType.value, "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}

/**
 * 查询指标库的公共函数
 * @param codec  指标库Id表单控件value保存指标库的值
 * @param valuec 指标库名称表单控件value保存指标库的名称
 * 调用示例   Sel360KeyLib(document.all('form1:superId'),document.all('form1:superName'))
 */
function Sel360TempLib(codec, valuec) {
    showx = event.screenX - event.offsetX - 150;
    showy = event.screenY - event.offsetY + 18;
    retval = window.showModalDialog("/pages/xys/eva/Sel360TempLib.jsp", "", "dialogWidth:215px; dialogHeight:430px; dialogLeft:" + showx + "px; dialogTop:" + showy + "px; status:0;resizable:yes");
    //debugger;
    if (retval != null) {
        rs = retval.split(",");
        valuec.value = rs[1];
        codec.value = rs[0];
    }
}
