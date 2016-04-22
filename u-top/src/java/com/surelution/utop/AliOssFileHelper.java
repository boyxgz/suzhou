/**
 * 
 */
package com.surelution.utop;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.OSSException;
import com.aliyun.oss.model.OSSObject;
import com.aliyun.oss.model.ObjectMetadata;

/**
 * @author <a href="mailto:guangzong.syu@gmail.com">guangzong</a>
 *
 */
public class AliOssFileHelper {

	private static String ACCESS_KEY = "zq4xfzP1X1kFg2Td7I+DSoV+qXc=";
	private static String ACCESS_ID = "2z5li9exzab7p4tnrk283vx2";
	private static String END_POINT = "http://oss-cn-hangzhou.aliyuncs.com";
	
	public static OSSClient getClient() {
		OSSClient client = new OSSClient(END_POINT, ACCESS_ID, ACCESS_KEY);
		return client;
	}

	// 上传文件
	public static void uploadFile(InputStream in, String bucketName, String name, long size, String contentType)
						throws OSSException, ClientException, IOException {
		OSSClient client = getClient();

		ObjectMetadata objectMeta = new ObjectMetadata();
		objectMeta.setContentLength(size);
		objectMeta.setContentType(contentType);

		client.putObject(bucketName, name, in, objectMeta);
	}

	public static InputStream downloadFile(String bucketName, String key)
            throws OSSException, ClientException, FileNotFoundException {

		OSSClient client = getClient();
        OSSObject object = client.getObject(bucketName, key);
        return object.getObjectContent();
    }
	
}
