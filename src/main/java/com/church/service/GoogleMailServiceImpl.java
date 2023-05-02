package com.church.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;


@Service
public class GoogleMailServiceImpl implements MailService {

	@Autowired
	private JavaMailSender mailSender;
	
	@Async
	public void sendMail(String to, String subject, String body) {
		MimeMessage message = mailSender.createMimeMessage();
		
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("yoonkeunsoo@gmail.com","계정 교회");
			messageHelper.setSubject(subject);
			messageHelper.setTo(to);
			messageHelper.setText("text/html",body);

			mailSender.send(message);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}