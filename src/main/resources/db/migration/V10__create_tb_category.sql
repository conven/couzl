-- ============================================================
-- tb_category (카테고리 마스터)
--   가맹점 카테고리를 정규화. tb_store.category(ENUM) → category_id(FK) 로 이전 예정 (V11)
-- ============================================================
CREATE TABLE tb_category (
    category_id   BIGINT       NOT NULL AUTO_INCREMENT             COMMENT '카테고리 ID (PK)',
    code          VARCHAR(20)  NOT NULL                            COMMENT '카테고리 코드 (영문 대문자, 예: CAFE)',
    name          VARCHAR(50)  NOT NULL                            COMMENT '카테고리 한글 표시명',
    icon          VARCHAR(10)  NULL                                COMMENT '대표 이모지',
    sort_order    INT          NOT NULL DEFAULT 0                  COMMENT '정렬 순서',
    is_active     TINYINT      NOT NULL DEFAULT 1                  COMMENT '활성여부 (1=활성, 0=비활성)',
    created_by    VARCHAR(50)  NULL                                COMMENT '등록자',
    created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP  COMMENT '등록일시',
    updated_by    VARCHAR(50)  NULL                                COMMENT '수정자',
    updated_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '수정일시',
    is_deleted    TINYINT      NOT NULL DEFAULT 0                  COMMENT '삭제여부',
    PRIMARY KEY (category_id),
    UNIQUE KEY uq_category_code (code),
    KEY idx_category_is_active (is_active),
    KEY idx_category_sort (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='카테고리 마스터';


-- 초기 시드 (기존 ENUM 값과 동일한 code 사용)
INSERT INTO tb_category (code, name, icon, sort_order, is_active, created_by, updated_by) VALUES
    ('CAFE',        '카페',     '☕', 1, 1, 'system', 'system'),
    ('FOOD',        '음식점',   '🍽', 2, 1, 'system', 'system'),
    ('BEAUTY',      '뷰티',     '💇', 3, 1, 'system', 'system'),
    ('SHOPPING',    '쇼핑',     '🛍', 4, 1, 'system', 'system'),
    ('FITNESS',     '피트니스', '💪', 5, 1, 'system', 'system'),
    ('CONVENIENCE', '편의점',   '🏪', 6, 1, 'system', 'system');
