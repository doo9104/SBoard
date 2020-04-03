package com.SBoard.service;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.SBoard.mapper.MemberManageMapper;
import com.SBoard.vo.MemberVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import java.util.Random;

import java.io.UnsupportedEncodingException;

import javax.activation.DataSource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;


@Service
@Log4j
public class MemberManageServiceImpl implements MemberManageService {

	@Autowired(required=true)
	private PasswordEncoder pwencoder;
	
	@Setter(onMethod_= @Autowired)
	private MemberManageMapper mapper;
	
	@Autowired
	private JavaMailSender mailSender;

	// 난수만들기
	public class TempKey {
		private int size;	
		private boolean lowerCheck;
	    
	    public String getKey(int size, boolean lowerCheck) {
	        this.size = size;
	        this.lowerCheck = lowerCheck;
	        return init();
	    }
	    
	    private String init() {
	        Random ran = new Random();
	        StringBuffer sb = new StringBuffer();
	        
	        int num = 0;
	        
	        do {
	            num = ran.nextInt(75) + 48;
	            
	            if((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
	                sb.append((char)num);
	            }else {
	                continue;
	            }
	        } while (sb.length() < size);
	        
	        if(lowerCheck) {
	            return sb.toString().toLowerCase();
	        }
	        
	        return sb.toString();
	    }
	}
	
	//////////////////////////////
	
	public class MailUtils {
	    
	    private JavaMailSender mailSender;
	    private MimeMessage message;
	    private MimeMessageHelper messageHelper;
	    
	    public MailUtils(JavaMailSender mailSender) throws MessagingException {
	        this.mailSender = mailSender;
	        message = this.mailSender.createMimeMessage();
	        messageHelper = new MimeMessageHelper(message, true, "UTF-8");
	    }
	    
	    public void setSubject(String subject) throws MessagingException {
	        messageHelper.setSubject(subject);
	    }
	    
	    public void setText(String htmlContent) throws MessagingException {
	        messageHelper.setText(htmlContent, true);
	    }
	    
	    public void setFrom(String email, String name) throws UnsupportedEncodingException, MessagingException {
	        messageHelper.setFrom(email, name);
	    }
	    
	    public void setTo(String email) throws MessagingException {
	        messageHelper.setTo(email);
	    }
	    
	    public void addInline(String contentId, DataSource dataSource) throws MessagingException {
	        messageHelper.addInline(contentId, dataSource);
	    }
	    
	    public void send() {
	        mailSender.send(message);
	    }
	}
	///////////////////////////
	
	
	@Override
	public MemberVO getUserId(MemberVO vo) {
		return mapper.getUserId(vo);
	}

	@Override
	public MemberVO getUserName(MemberVO vo) {
		return mapper.getUserName(vo);
	}
	
	@Override
	public MemberVO getUserEmail(MemberVO vo) {
		return mapper.getUserEmail(vo);
	}

	@Transactional
	@Override
	public void createNewMember(MemberVO vo) throws Exception{
		
		String authkey = new TempKey().getKey(50, false);
		
		vo.setAuthkey(authkey);
		vo.setUserpw(pwencoder.encode(vo.getUserpw()));
		
		MailUtils sendMail = new MailUtils(mailSender);
		sendMail.setSubject("[회원가입 이메일 인증]");
		sendMail.setText(
				new StringBuffer()
				.append("<h1>SBoard 회원가입 메일인증</h1>")
				.append("<a href='http://localhost:8080/joinConfirm?email=")
				.append(vo.getEmail())
				.append("&userid=")
				.append(vo.getUserid())
				.append("&authkey=")
				.append(authkey)
				.append("' target='_blenk'>이메일 인증 확인</a>")
				.toString());
		sendMail.setFrom("dominodomina1393@gmail.com", "SBoard Admin");
		sendMail.setTo(vo.getEmail());
		sendMail.send();
		
		
		 mapper.createNewMember(vo); 
		 mapper.giveAuth(vo);

		
		
	}

	@Override
	public void setActivity(MemberVO vo) {
		
		mapper.setActivity(vo);
	}

	@Override
	public int checkPassword(MemberVO vo) {
		String oldPw = vo.getUserpw();
		String encPw = mapper.checkPassword(vo);

		if(pwencoder.matches(oldPw, encPw)) { return 1;	} else { return 0; }
	}

	@Override
	public MemberVO getUserInfo(MemberVO vo) {
		return mapper.getUserInfo(vo);
	}

	@Override
	public void modifyUserInfo(MemberVO vo) {
		vo.setUserpw(pwencoder.encode(vo.getUserpw()));
		
		mapper.modifyUserInfo(vo);
	}
		
		
	



	
	
	

}
