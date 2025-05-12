package com.example.plantishop;

import java.util.Properties;
import javax.mail.Session;
import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.Message;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.InternetAddress;

public class Epistula {

    public void eMail(String u, String a, String txt) throws Exception {
        Properties p = new Properties();
        p.put("mail.smtp.host", "mail.gmail.com");
        p.put("mail.smtp.starttls.enable", "true");
        p.put("mail.smtp.port", "587");
        p.put("mail.smtp.auth", "true");
        p.put("mail.smtp.mail.sender", "ecobyte.sw@gmail.com");
        Session s = Session.getDefaultInstance(p, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("ecobyte.sw@gmail.com", "");
            }
        });
        MimeMessage m = new MimeMessage(s);
        m.addHeader("Content-Type", "text/plain; charset=UTF-8");
        m.addHeader("format", "flowed");
        m.addHeader("Content-Transfer-Encoding", "8bit");
        m.setFrom(new InternetAddress((String) p.get("mail.smtp.mail.sender"), "PlantiSHOP"));
        m.addRecipient(Message.RecipientType.TO, new InternetAddress(u));
        m.setSubject(a);
        m.setText(txt);
        Transport.send(m);
    }

}