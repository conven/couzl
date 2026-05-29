ALTER TABLE tb_user
ADD COLUMN email_verify_code   VARCHAR(10) NULL                    COMMENT '이메일 인증코드',
ADD COLUMN email_verify_expiry DATETIME    NULL                    COMMENT '이메일 인증코드 만료시각',
ADD COLUMN email_verified      CHAR(1)     NOT NULL DEFAULT 'N'   COMMENT '이메일 인증여부 (Y/N)';
