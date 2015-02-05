package com.afd.boss.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.ContentBody;
import org.apache.http.entity.mime.content.InputStreamBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;
import com.afd.common.util.PropertyUtils;

@SuppressWarnings("deprecation")
public class HttpCilient {
	public static final Logger LOGGER = LoggerFactory.getLogger(HttpCilient.class);
	
	private static final String IMG_UPLOAD_ADDR =(String)PropertyUtils.getProperty("imgUploadUrl");
	
	public static List<String> uploadFileService(InputStream inputStream, String fileName, String opt) throws Exception {
		List<String> list = new ArrayList<String>();
		HttpClientBuilder httpClientBuilder = HttpClientBuilder.create();
		//HttpClient
		CloseableHttpClient closeableHttpClient = httpClientBuilder.build();
		
		String jsonStr = null;
		HttpResponse response = null;
		HttpPost httpPost = new HttpPost(IMG_UPLOAD_ADDR);
		httpPost.setConfig(RequestConfig.DEFAULT);
	
		try {
			MultipartEntityBuilder entityBuilder = MultipartEntityBuilder.create();
			ContentBody fileBody = new InputStreamBody(inputStream, fileName);
			HttpEntity reqEntity = entityBuilder.addPart("filename", fileBody).build();
			httpPost.setEntity(reqEntity);
	
		    response = closeableHttpClient.execute(httpPost);
			
			HttpEntity httpEntity = response.getEntity();//响应内容
			if (httpEntity != null) {
				jsonStr = EntityUtils.toString(httpEntity);
			}
		} finally {
			closeableHttpClient.close();
		}
		
		@SuppressWarnings("unchecked")
		Map<String, Object> map = JSON.parseObject(jsonStr, HashMap.class);
		int status = response.getStatusLine().getStatusCode();	
		
		int height = (Integer)map.get("height");
		int width = (Integer)map.get("width");
		
		if ("1".equals(opt)) {//编辑器上传，需要切图
			if (width <= 768) {//原图尺寸进行裁剪
				int part = (height/400)+1;
				for (int i = 1; i <= part; i++) {
					String rid = (String)map.get("rid")+"&op=c4_a"+part+"_p"+i;
					list.add(rid);
				}
			} else if (width > 768) {
				int part = (height*768/width/400)+1;
				for (int i = 1; i <= part; i++) {
					String rid = (String)map.get("rid")+"&op=s0_w768-c4_a"+part+"_p"+i;
					list.add(rid);
				}
			} 
		} else {
			String rid = (String)map.get("rid");
			list.add(rid);
		}

		if (status == HttpStatus.SC_OK) {
//	 	    System.out.println("上传成功");
		} else {
//	 	    System.out.println("上传失败");
		}
		return list;	
	}
	
	public static int getPage(String url, String param) {
		String realurl = url + "?" + param;

		HttpGet httpget = new HttpGet(realurl);
		RequestConfig.Builder builder = RequestConfig.custom();
		builder.setConnectTimeout(1000);
		builder.setSocketTimeout(1000);
		httpget.setConfig(builder.build());
//		RequestConfig.custom().setConnectionRequestTimeout(1000);
		
		HttpResponse response = null;
		
		try {
			response = new DefaultHttpClient().execute(httpget);
		} catch (ClientProtocolException ce) {
			LOGGER.error("发送GET请求出现异常！" + ce);
		} catch (IOException ie) {
			LOGGER.error("发送GET请求出现异常！" + ie);
		}

		int status = response.getStatusLine().getStatusCode();
		
		LOGGER.error("返回状态！" + status);
		
		return status;
	}
	
	public static void main(String[] args) {
		HttpCilient.getPage("http://util.yiwang.com/purge", "param=100024&auth=e6e028654a7a1cbca1459eb7d8bf2478");
	}
	
	
	
}
