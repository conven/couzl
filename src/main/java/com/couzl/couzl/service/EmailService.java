package com.couzl.couzl.service;

import com.couzl.couzl.mapper.UserMapper;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class EmailService {

    private static final int CODE_TTL_MINUTES = 5;
    private static final SecureRandom RANDOM = new SecureRandom();

    private final JavaMailSender mailSender;
    private final UserMapper userMapper;

    @Value("${spring.mail.username}")
    private String fromAddress;

    public void sendVerifyCode(String email) {
        String code = generateCode();
        LocalDateTime expiry = LocalDateTime.now().plusMinutes(CODE_TTL_MINUTES);

        userMapper.updateEmailVerifyCode(email, code, expiry);

        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, false, StandardCharsets.UTF_8.name());
            helper.setFrom(fromAddress);
            helper.setTo(email);
            helper.setSubject("[Couzl] 이메일 인증코드 안내");
            helper.setText(buildVerifyHtml(code), true);
            mailSender.send(message);
        } catch (MessagingException e) {
            throw new IllegalStateException("메일 메시지 생성에 실패했습니다", e);
        }
    }

    private String generateCode() {
        return String.format("%06d", RANDOM.nextInt(1_000_000));
    }

    private String buildVerifyHtml(String code) {
        return ""
            + "<!DOCTYPE html>"
            + "<html lang=\"ko\"><head><meta charset=\"UTF-8\"></head>"
            + "<body style=\"margin:0;padding:24px 12px;background:#f5f5f7;font-family:'Apple SD Gothic Neo','Noto Sans KR',sans-serif;color:#222;\">"
            + "  <table role=\"presentation\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width:430px;margin:0 auto;background:#ffffff;border-radius:16px;overflow:hidden;box-shadow:0 4px 16px rgba(0,0,0,0.06);\">"

            + "    <tr><td style=\"background:#FFD60A;padding:28px 24px;text-align:center;\">"
            + "      <div style=\"font-size:28px;font-weight:800;letter-spacing:-1px;color:#222;\">Couzl</div>"
            + "      <div style=\"margin-top:6px;font-size:13px;color:#5a4a00;\">우리 동네 쿠폰의 모든 것</div>"
            + "    </td></tr>"

            + "    <tr><td style=\"padding:32px 28px 8px 28px;\">"
            + "      <div style=\"font-size:20px;font-weight:700;margin-bottom:8px;\">이메일 인증코드 안내</div>"
            + "      <div style=\"font-size:14px;line-height:1.6;color:#555;\">"
            + "        안녕하세요, <b>Couzl</b> 에 가입해 주셔서 감사합니다.<br>"
            + "        아래 인증코드를 회원가입 화면에 입력해 주세요."
            + "      </div>"
            + "    </td></tr>"

            + "    <tr><td style=\"padding:20px 28px 8px 28px;\">"
            + "      <div style=\"background:#FFFBE6;border:1px dashed #FFD60A;border-radius:12px;padding:20px;text-align:center;\">"
            + "        <div style=\"font-size:12px;color:#8a7100;letter-spacing:1px;\">인증코드</div>"
            + "        <div style=\"margin-top:8px;font-size:34px;font-weight:800;letter-spacing:8px;color:#222;font-family:'Courier New',monospace;\">" + code + "</div>"
            + "        <div style=\"margin-top:8px;font-size:12px;color:#8a7100;\">유효시간 " + CODE_TTL_MINUTES + "분</div>"
            + "      </div>"
            + "    </td></tr>"

            + "    <tr><td style=\"padding:16px 28px 28px 28px;font-size:12px;line-height:1.7;color:#888;\">"
            + "      <div>· 인증코드는 발송 시점부터 <b>" + CODE_TTL_MINUTES + "분간</b> 유효합니다.</div>"
            + "      <div>· 본인이 요청하지 않은 메일이라면 무시해 주세요.</div>"
            + "      <div>· 보안을 위해 인증코드는 타인과 공유하지 마세요.</div>"
            + "    </td></tr>"

            + "    <tr><td style=\"background:#fafafa;padding:16px 24px;text-align:center;font-size:11px;color:#aaa;border-top:1px solid #eee;\">"
            + "      본 메일은 발신 전용입니다. 문의는 앱 내 고객센터를 이용해 주세요.<br>"
            + "      &copy; Couzl"
            + "    </td></tr>"

            + "  </table>"
            + "</body></html>";
    }
}
