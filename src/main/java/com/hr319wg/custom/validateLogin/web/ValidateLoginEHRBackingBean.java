package com.hr319wg.custom.validateLogin.web;

import java.rmi.RemoteException;

import org.apache.axiom.om.OMAbstractFactory;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.OMFactory;
import org.apache.axiom.om.OMNamespace;
import org.apache.axis2.AxisFault;
import org.apache.axis2.client.ServiceClient;

import com.hr319wg.custom.validateLogin.web.HrSSOStub.MySoapHeader;
import com.hr319wg.custom.validateLogin.web.HrSSOStub.MySoapHeaderE;
import com.hr319wg.custom.validateLogin.web.HrSSOStub.Validate;

public class ValidateLoginEHRBackingBean {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		

		HrSSOStub stub;
		ValidateLoginEHRBackingBean backingBean = new ValidateLoginEHRBackingBean();
		try {
			stub = new HrSSOStub();
			ServiceClient client = stub._getServiceClient();
			client.addHeader(backingBean.creatElement());
			stub._setServiceClient(client);
			
			Validate validate = new Validate();
			validate.setAppid(4);
			validate.setUsername("11360");
			validate.setCredentials("dZbVk%2bQKVifIljlsfW0DI9uUVWSIt7W3IOXS6osFqD4%3d");
			validate.setKey("063c3490b076f0ce522f0289833adad4");
			
			MySoapHeaderE header = new MySoapHeaderE();
			MySoapHeader mySoapHeader = new MySoapHeader();
			mySoapHeader.setPassWord("siashr@SS0123");
			mySoapHeader.setUserName("siassso");
			header.setMySoapHeader(mySoapHeader);

			try {
				stub.validate(validate, header).getValidateResult();
			} catch (RemoteException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (AxisFault e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static OMElement creatElement() {
		OMFactory factory = OMAbstractFactory.getOMFactory();
		OMNamespace SecurityElementNamespace = factory.createOMNamespace(
				"http://tempuri.org/", "MySoapHeader");
		OMElement authenticationOM = factory.createOMElement("MySoapHeader",
				SecurityElementNamespace);
		OMElement usernameOM = factory.createOMElement("UserName",
				SecurityElementNamespace);
		OMElement passwordOM = factory.createOMElement("PassWord",
				SecurityElementNamespace);
		usernameOM.setText("siassso");
		passwordOM.setText("siashr@SS0123");
		authenticationOM.addChild(usernameOM);
		authenticationOM.addChild(passwordOM);
		return authenticationOM;

	}

}
