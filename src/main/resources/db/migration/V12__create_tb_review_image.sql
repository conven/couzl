-- ============================================================
-- tb_review_image (리뷰 첨부 이미지)
--   리뷰 1건당 N장 첨부 가능. 추후 FO 리뷰 등록 시 INSERT 예정.
-- ============================================================
CREATE TABLE tb_review_image (
    review_image_id BIGINT       NOT NULL AUTO_INCREMENT             COMMENT '리뷰 이미지 ID (PK)',
    review_id       BIGINT       NOT NULL                            COMMENT '리뷰 ID (FK)',
    image           MEDIUMBLOB   NOT NULL                            COMMENT '이미지 바이너리',
    image_type      VARCHAR(50)  NOT NULL DEFAULT 'image/jpeg'       COMMENT 'MIME 타입',
    sort_order      INT          NOT NULL DEFAULT 0                  COMMENT '정렬 순서 (0부터)',
    created_by      VARCHAR(50)  NULL                                COMMENT '등록자',
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '등록일시',
    is_deleted      TINYINT      NOT NULL DEFAULT 0                  COMMENT '삭제여부',
    PRIMARY KEY (review_image_id),
    KEY idx_rvi_review_id (review_id),
    KEY idx_rvi_review_sort (review_id, sort_order),
    CONSTRAINT fk_rvi_review FOREIGN KEY (review_id) REFERENCES tb_review (review_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='리뷰 첨부 이미지';
