package dev.mvc.tool;

import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.web.multipart.MultipartFile;

public class MailTool {
    /**
     * ���� ����
     * @param receiver ���� ���� �̸��� �ּ�
     * @param from ������ ��� �̸��� �ּ�
     * @param title ����
     * @param content ���� ����
     */
    public void send(String receiver, String from, String title, String content) {
      Properties props = new Properties();
      props.put("mail.smtp.host", "smtp.gmail.com");
      props.put("mail.smtp.port", "587");
      props.put("mail.smtp.auth", "true");
      props.put("mail.smtp.starttls.enable", "true");
      props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
      
      // 3. SMTP ���������� ����� ������ ������� Session Ŭ������ �ν��Ͻ� ����
      Session session = Session.getInstance(props, new javax.mail.Authenticator() {
          protected PasswordAuthentication getPasswordAuthentication() {
              String user="1229juwon67@gmail.com";
              String password="kecrcfvvvbxrvcar";
              return new PasswordAuthentication(user, password);
          }
      });
    
      Message message = new MimeMessage(session);
      try {
          message.setFrom(new InternetAddress(from));
          message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
          message.setSubject(title);
          message.setContent(content, "text/html; charset=utf-8");

          Transport.send(message);
      } catch (Exception e) {
          e.printStackTrace();
      }    
  }
 
    /**
     * ���� ÷�� ���� ����
     * @param receiver ���� ���� �̸��� �ּ�
     * @param title ����
     * @param content ���� ����
     * @param file1MF �����Ϸ��� ���� ���
     * @param path ÷���Ϸ��� ������ �ִ� ����
     */
    public void send_file(String receiver, String from, String title, String content,
                                  MultipartFile[] file1MF, String path) {
      Properties props = new Properties();
      props.put("mail.smtp.host", "smtp.gmail.com");
      props.put("mail.smtp.port", "587");
      props.put("mail.smtp.auth", "true");
      props.put("mail.smtp.starttls.enable", "true");
      props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
      
      // 3. SMTP ���������� ����� ������ ������� Session Ŭ������ �ν��Ͻ� ����
      Session session = Session.getInstance(props, new javax.mail.Authenticator() {
          protected PasswordAuthentication getPasswordAuthentication() {
              String user="testcell2014@studydesk.co.kr";
              String password="talrlwjbwgnpbnzk";
              return new PasswordAuthentication(user, password);
          }
      });
    
      Message message = new MimeMessage(session);
      try {
          message.setFrom(new InternetAddress(from));
          message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
          message.setSubject(title);
          
          MimeBodyPart mbp1 = new MimeBodyPart();
          mbp1.setContent(content, "text/html; charset=utf-8"); // ���� ����
          
          Multipart mp = new MimeMultipart();
          mp.addBodyPart(mbp1);

          // ÷�� ���� ó��
          // ---------------------------------------------------------------------------------------
          for (MultipartFile item:file1MF) {
              if (item.getSize() > 0) {
                  MimeBodyPart mbp2 = new MimeBodyPart();
                  
                  String fname=path+item.getOriginalFilename();
                  System.out.println("-> file name: " + fname); 
                  
                  FileDataSource fds = new FileDataSource(fname);
                  
                  mbp2.setDataHandler(new DataHandler(fds));
                  mbp2.setFileName(fds.getName());
                  
                  mp.addBodyPart(mbp2);
              }
          }
          // ---------------------------------------------------------------------------------------
          
          message.setContent(mp);
          
          Transport.send(message);
          
      } catch (Exception e) {
          e.printStackTrace();
      }    
  }
  
}

