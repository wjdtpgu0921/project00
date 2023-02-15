package dev.mvc.contents;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
 
public class HttpTest {
  
    // GET 요청
    public static String mf_recommend(String django_url) throws MalformedURLException, IOException {
        URL url = new URL(django_url);
        HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
        
        int statusCode = httpConn.getResponseCode();        
        System.out.println((statusCode == 200) ? "success" : "fail");
        System.out.println("Response code: " + statusCode);
        
        BufferedReader br = new BufferedReader(new InputStreamReader(httpConn.getInputStream()));
        String line=br.readLine();
        br.close();
        
        return line;
    }
 
    // main method
    public static void main(String[] args) throws MalformedURLException, IOException {
        
        String line = mf_recommend("http://127.0.0.1:8000:/recommend_food/mf_food?memberno=1");        
        System.out.println(line);
    } 
}

