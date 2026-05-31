-- ============================================================
-- tb_banner (FO 메인 배너)
-- ============================================================
CREATE TABLE tb_banner (
    banner_id      BIGINT       NOT NULL AUTO_INCREMENT             COMMENT '배너 ID (PK)',
    title          VARCHAR(100) NOT NULL                            COMMENT '관리용 제목',
    image          MEDIUMBLOB   NOT NULL                            COMMENT '배너 이미지 바이너리',
    image_type     VARCHAR(50)  NOT NULL                            COMMENT 'MIME 타입',
    link_type      VARCHAR(20)  NOT NULL DEFAULT 'NONE'             COMMENT '링크 유형 (NONE/STORE/COUPON)',
    link_value     VARCHAR(100) NULL                                COMMENT '링크 대상 (store_id or coupon_id)',
    display_order  INT          NOT NULL DEFAULT 0                  COMMENT '노출 순서 (낮을수록 먼저)',
    start_date     DATE         NULL                                COMMENT '노출 시작일 (null=즉시)',
    end_date       DATE         NULL                                COMMENT '노출 종료일 (null=무기한)',
    is_active      TINYINT(1)   NOT NULL DEFAULT 1                  COMMENT '활성여부',
    created_by     VARCHAR(50)  NULL                                COMMENT '등록자',
    created_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '등록일시',
    updated_by     VARCHAR(50)  NULL                                COMMENT '수정자',
    updated_at     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    is_deleted     TINYINT      NOT NULL DEFAULT 0                  COMMENT '삭제여부',
    PRIMARY KEY (banner_id),
    KEY idx_banner_active (is_active, is_deleted),
    KEY idx_banner_order (display_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='FO 메인 배너';
