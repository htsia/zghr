/**
 * ��ѯָ���Ĺ�������
 * @param codec  ָ���Id���ؼ�value����ָ����ֵ
 * @param valuec ָ������Ʊ��ؼ�value����ָ��������
 * ����ʾ��   Sel360KeyLib(document.all('form1:superId'),document.all('form1:superName'))
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
 * ��ѯָ��Ĺ�������
 * @param codec  ָ��Id���ؼ�value����ָ���ֵ
 * @param valuec ָ������Ʊ��ؼ�value����ָ��������
 * @param keyType ָ������
 * ����ʾ�� Sel360Key(document.all('form1:superId'),document.all('form1:superName'),'1')
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
 * ��ѯָ���Ĺ�������
 * @param codec  ָ���Id���ؼ�value����ָ����ֵ
 * @param valuec ָ������Ʊ��ؼ�value����ָ��������
 * ����ʾ��   Sel360KeyLib(document.all('form1:superId'),document.all('form1:superName'))
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
