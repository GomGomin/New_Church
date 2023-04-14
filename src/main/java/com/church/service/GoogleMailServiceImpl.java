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
			messageHelper.setText("text/html",body);//템플릿에 들어가는 이미지 cid로 삽입

			messageHelper.addInline("image1", new ClassPathResource("mailImg/image-1.jpeg"));
			messageHelper.addInline("image2", new ClassPathResource("mailImg/image-2.jpeg"));
			messageHelper.addInline("image3", new ClassPathResource("mailImg/image-3.jpeg"));
			messageHelper.addInline("image4", new ClassPathResource("mailImg/image-4.png"));

			mailSender.send(message);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

}