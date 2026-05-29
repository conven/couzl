-- ============================================================
-- Couzl DB 초기 스키마
-- ============================================================

-- ============================================================
-- 1. tb_region (지역)
--    의존성 없음 → 가장 먼저 생성
-- ============================================================
CREATE TABLE tb_region (
    region_id   BIGINT       NOT NULL AUTO_INCREMENT COMMENT '지역 ID (PK)',
    region_name VARCHAR(100) NOT NULL                COMMENT '지역명',
    is_active   TINYINT      NOT NULL DEFAULT 1      COMMENT '활성여부 (1=활성, 0=비활성)',
    created_by  VARCHAR(50)  NULL                    COMMENT '등록자',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
    updated_by  VARCHAR(50)  NULL                    COMMENT '수정자',
    updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    is_deleted  TINYINT      NOT NULL DEFAULT 0      COMMENT '삭제여부 (0=정상, 1=삭제)',
    PRIMARY KEY (region_id),
    KEY idx_region_is_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='지역';


-- ============================================================
-- 2. tb_user (회원)
--    의존성: tb_region
-- ============================================================
CREATE TABLE tb_user (
    user_id     BIGINT       NOT NULL AUTO_INCREMENT                        COMMENT '회원 ID (PK)',
    login_id    VARCHAR(50)  NOT NULL                                       COMMENT '아이디',
    password    VARCHAR(255) NULL                                           COMMENT '비밀번호 (BCrypt 암호화)',
    nickname    VARCHAR(20)  NOT NULL                                       COMMENT '닉네임',
    email       VARCHAR(100) NOT NULL                                       COMMENT '이메일',
    social_type ENUM('NONE','KAKAO','APPLE') NOT NULL DEFAULT 'NONE'       COMMENT '소셜 로그인 타입',
    social_id   VARCHAR(255) NULL                                           COMMENT '소셜 고유 ID',
    status      ENUM('ACTIVE','SUSPENDED','WITHDRAWN') NOT NULL DEFAULT 'ACTIVE' COMMENT '계정 상태',
    region_id   BIGINT       NULL                                           COMMENT '선택한 지역 (FK)',
    created_by  VARCHAR(50)  NULL                                           COMMENT '등록자',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP             COMMENT '등록일시',
    updated_by  VARCHAR(50)  NULL                                           COMMENT '수정자',
    updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    is_deleted  TINYINT      NOT NULL DEFAULT 0                             COMMENT '삭제여부',
    PRIMARY KEY (user_id),
    UNIQUE KEY uq_user_login_id (login_id),
    UNIQUE KEY uq_user_email (email),
    KEY idx_user_status (status),
    KEY idx_user_region_id (region_id),
    CONSTRAINT fk_user_region FOREIGN KEY (region_id) REFERENCES tb_region (region_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='회원';


-- ============================================================
-- 3. tb_store (가맹점)
--    의존성: tb_region
-- ============================================================
CREATE TABLE tb_store (
    store_id       BIGINT       NOT NULL AUTO_INCREMENT COMMENT '가맹점 ID (PK)',
    region_id      BIGINT       NOT NULL                COMMENT '지역 ID (FK)',
    store_name     VARCHAR(100) NOT NULL                COMMENT '가맹점명',
    category       ENUM('CAFE','FOOD','BEAUTY','SHOPPING','FITNESS','CONVENIENCE') NOT NULL COMMENT '카테고리',
    address        VARCHAR(255) NULL                    COMMENT '주소',
    phone          VARCHAR(20)  NULL                    COMMENT '전화번호',
    business_hours VARCHAR(100) NULL                    COMMENT '영업시간',
    description    TEXT         NULL                    COMMENT '가맹점 소개',
    emoji          VARCHAR(10)  NULL                    COMMENT '대표 이모지',
    rating_avg     DECIMAL(3,1) NOT NULL DEFAULT 0.0   COMMENT '평균 별점',
    status         ENUM('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE' COMMENT '상태',
    created_by     VARCHAR(50)  NULL                    COMMENT '등록자',
    created_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
    updated_by     VARCHAR(50)  NULL                    COMMENT '수정자',
    updated_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    is_deleted     TINYINT      NOT NULL DEFAULT 0      COMMENT '삭제여부',
    PRIMARY KEY (store_id),
    KEY idx_store_region_id (region_id),
    KEY idx_store_category (category),
    KEY idx_store_status (status),
    KEY idx_store_region_category (region_id, category),
    CONSTRAINT fk_store_region FOREIGN KEY (region_id) REFERENCES tb_region (region_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='가맹점';


-- ============================================================
-- 4. tb_coupon (쿠폰 마스터)
--    의존성: tb_store
-- ============================================================
CREATE TABLE tb_coupon (
    coupon_id      BIGINT       NOT NULL AUTO_INCREMENT COMMENT '쿠폰 ID (PK)',
    store_id       BIGINT       NOT NULL                COMMENT '가맹점 ID (FK)',
    coupon_name    VARCHAR(100) NOT NULL                COMMENT '쿠폰명',
    benefit        VARCHAR(200) NOT NULL                COMMENT '혜택 내용',
    condition_text VARCHAR(200) NULL                    COMMENT '사용 조건',
    expire_date    DATE         NOT NULL                COMMENT '만료일',
    total_count    INT          NOT NULL DEFAULT 0      COMMENT '발급 총 수량 (0=무제한)',
    issued_count   INT          NOT NULL DEFAULT 0      COMMENT '발급된 수량',
    status         ENUM('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE' COMMENT '상태',
    created_by     VARCHAR(50)  NULL                    COMMENT '등록자',
    created_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
    updated_by     VARCHAR(50)  NULL                    COMMENT '수정자',
    updated_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    is_deleted     TINYINT      NOT NULL DEFAULT 0      COMMENT '삭제여부',
    PRIMARY KEY (coupon_id),
    KEY idx_coupon_store_id (store_id),
    KEY idx_coupon_status (status),
    KEY idx_coupon_expire_date (expire_date),
    KEY idx_coupon_store_status (store_id, status),
    CONSTRAINT fk_coupon_store FOREIGN KEY (store_id) REFERENCES tb_store (store_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='쿠폰 마스터';


-- ============================================================
-- 5. tb_user_coupon (사용자 보유 쿠폰)
--    의존성: tb_user, tb_coupon
-- ============================================================
CREATE TABLE tb_user_coupon (
    user_coupon_id BIGINT      NOT NULL AUTO_INCREMENT COMMENT '사용자 쿠폰 ID (PK)',
    user_id        BIGINT      NOT NULL                COMMENT '회원 ID (FK)',
    coupon_id      BIGINT      NOT NULL                COMMENT '쿠폰 ID (FK)',
    coupon_code    VARCHAR(36) NOT NULL                COMMENT '쿠폰 고유코드 (UUID)',
    status         ENUM('AVAILABLE','USED','EXPIRED') NOT NULL DEFAULT 'AVAILABLE' COMMENT '쿠폰 상태',
    used_at        DATETIME    NULL                    COMMENT '사용일시',
    created_by     VARCHAR(50) NULL                    COMMENT '등록자',
    created_at     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
    updated_by     VARCHAR(50) NULL                    COMMENT '수정자',
    updated_at     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    is_deleted     TINYINT     NOT NULL DEFAULT 0      COMMENT '삭제여부',
    PRIMARY KEY (user_coupon_id),
    UNIQUE KEY uq_user_coupon_code (coupon_code),
    KEY idx_uc_user_id (user_id),
    KEY idx_uc_coupon_id (coupon_id),
    KEY idx_uc_status (status),
    KEY idx_uc_user_status (user_id, status),
    CONSTRAINT fk_uc_user   FOREIGN KEY (user_id)   REFERENCES tb_user   (user_id),
    CONSTRAINT fk_uc_coupon FOREIGN KEY (coupon_id) REFERENCES tb_coupon (coupon_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사용자 보유 쿠폰';


-- ============================================================
-- 6. tb_review (리뷰)
--    의존성: tb_user, tb_store, tb_user_coupon
-- ============================================================
CREATE TABLE tb_review (
    review_id      BIGINT   NOT NULL AUTO_INCREMENT COMMENT '리뷰 ID (PK)',
    user_id        BIGINT   NOT NULL                COMMENT '회원 ID (FK)',
    store_id       BIGINT   NOT NULL                COMMENT '가맹점 ID (FK)',
    user_coupon_id BIGINT   NOT NULL                COMMENT '사용자 쿠폰 ID (FK)',
    rating         TINYINT  NOT NULL                COMMENT '별점 (1~5)',
    content        TEXT     NULL                    COMMENT '리뷰 내용',
    status         ENUM('ACTIVE','DELETED') NOT NULL DEFAULT 'ACTIVE' COMMENT '상태',
    created_by     VARCHAR(50) NULL                 COMMENT '등록자',
    created_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시',
    updated_by     VARCHAR(50) NULL                 COMMENT '수정자',
    updated_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    is_deleted     TINYINT  NOT NULL DEFAULT 0      COMMENT '삭제여부',
    PRIMARY KEY (review_id),
    UNIQUE KEY uq_review_user_coupon (user_coupon_id),
    KEY idx_review_user_id (user_id),
    KEY idx_review_store_id (store_id),
    KEY idx_review_status (status),
    CONSTRAINT fk_review_user    FOREIGN KEY (user_id)        REFERENCES tb_user        (user_id),
    CONSTRAINT fk_review_store   FOREIGN KEY (store_id)       REFERENCES tb_store       (store_id),
    CONSTRAINT fk_review_uc      FOREIGN KEY (user_coupon_id) REFERENCES tb_user_coupon (user_coupon_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='리뷰';
