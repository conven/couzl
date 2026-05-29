-- 더미 계정 비밀번호 수정 (BCryptPasswordEncoder로 생성한 정확한 해시)
-- 로그인 정보: couzl / password
UPDATE tb_user
   SET password   = '$2a$10$hbZTx/7a1xE/kL84R8t/yeNzbsBwi5wTtaz3BnY6rsBZ/3oWnHt5y',
       updated_by = 'system'
 WHERE login_id = 'couzl';
