-- ============================================================
-- tb_admin (Back Office 관리자)
--   의존성: tb_store
-- ============================================================
CREATE TABLE tb_admin (
    admin_id      BIGINT       NOT NULL AUTO_INCREMENT             COMMENT '관리자 ID (PK)',
    login_id      VARCHAR(50)  NOT NULL                            COMMENT '로그인 아이디',
    password      VARCHAR(255) NOT NULL                            COMMENT '비밀번호 (BCrypt)',
    name          VARCHAR(50)  NOT NULL                            COMMENT '관리자 이름',
    role          VARCHAR(20)  NOT NULL                            COMMENT '역할 (SUPER_ADMIN/ADMIN/STORE_OWNER)',
    store_id      BIGINT       NULL                                COMMENT '소속 가맹점 ID (STORE_OWNER일 때만 사용)',
    status        VARCHAR(10)  NOT NULL DEFAULT 'ACTIVE'            COMMENT '상태 (ACTIVE/INACTIVE)',
    last_login_at DATETIME     NULL                                COMMENT '최근 로그인 일시',
    created_by    VARCHAR(50)  NULL                                COMMENT '등록자',
    created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '등록일시',
    updated_by    VARCHAR(50)  NULL                                COMMENT '수정자',
    updated_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    is_deleted    TINYINT      NOT NULL DEFAULT 0                  COMMENT '삭제여부',
    PRIMARY KEY (admin_id),
    UNIQUE KEY uq_admin_login_id (login_id),
    KEY idx_admin_role (role),
    KEY idx_admin_status (status),
    KEY idx_admin_store_id (store_id),
    CONSTRAINT fk_admin_store FOREIGN KEY (store_id) REFERENCES tb_store (store_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Back Office 관리자';


-- ============================================================
-- 초기 시드 (비밀번호 평문: admin1234, BCrypt strength=10)
-- ============================================================
INSERT INTO tb_admin (login_id, password, name, role, status, created_by, updated_by)
VALUES ('superadmin',
        '$2a$10$cW33wOREvtgO0Diio6bUjOMyqGO8OtMS0sSrMu.GE0zIguxZtY7Ua',
        '슈퍼관리자',
        'SUPER_ADMIN',
        'ACTIVE',
        'system',
        'system');

INSERT INTO tb_admin (login_id, password, name, role, status, created_by, updated_by)
VALUES ('admin',
        '$2a$10$cW33wOREvtgO0Diio6bUjOMyqGO8OtMS0sSrMu.GE0zIguxZtY7Ua',
        '일반관리자',
        'ADMIN',
        'ACTIVE',
        'system',
        'system');
