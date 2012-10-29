package com.hr319wg.sys.web;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * 获取天气
 * 
 * @author 郝威
 * 
 */
public class WeatherReport {

	public static List<Map> getweather(String city, int curr) {
		List<Map> list = new ArrayList<Map>();
		try {
			Properties prop = System.getProperties();
			prop.put("http.proxyHost", "localhost");
			prop.put("http.proxyPort", "8080");
			URL url = new URL("http://www.google.com/ig/api?hl=zh_cn&weather="
					+ city);
			URLConnection conn = url.openConnection();
			conn.setUseCaches(false);
			conn.setDoInput(true);
			conn.setDoOutput(true);

			conn.setRequestProperty("Content-Type", "text/xml; charset=utf-8");

			InputStream in = conn.getInputStream();
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			int i = -1;
			while ((i = in.read()) != -1) {
				bos.write(i);
			}
			InputStream inp = new ByteArrayInputStream(bos.toString().getBytes(
					"utf-8"));
			SAXReader saxReader = new SAXReader();
			Document doc = saxReader.read(inp);
			Element root = doc.getRootElement();
			for (Iterator j = root.elementIterator(); j.hasNext();) {
				Element head = (Element) j.next();
				int index = 0;
				for (Iterator sec = head.elementIterator(); sec.hasNext();) {
					Element seclevel = (Element) sec.next();
					if (!"forecast_information".equals(seclevel.getName())) {
						if (curr == 1 && index == 2) {
							break;
						}
						Map map = new HashMap();
						for (Iterator last = seclevel.elementIterator(); last
								.hasNext();) {
							Element w = (Element) last.next();
							map.put(w.getName(), w.attributeValue("data"));
						}
						list.add(map);
						index++;
					}
				}
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
