-- ============================================================
-- tb_store.category(ENUM) → category_id(FK) 정규화
--   1) category_id 컬럼 추가
--   2) 기존 category 값으로 category_id 채움
--   3) NOT NULL + FK 제약
--   4) 기존 category 컬럼은 deprecated (VARCHAR NULL로 변경, 호환성 유지)
-- ============================================================

-- 1. category_id 컬럼 추가
ALTER TABLE tb_store
    ADD COLUMN category_id BIGINT NULL AFTER region_id;

-- 2. 기존 ENUM 값을 보고 category_id 채우기
UPDATE tb_store s
  JOIN tb_category c ON s.category = c.code
   SET s.category_id = c.category_id
 WHERE s.is_deleted = 0;

-- 3. NOT NULL + FK
ALTER TABLE tb_store
    MODIFY COLUMN category_id BIGINT NOT NULL COMMENT '카테고리 ID (FK)';

ALTER TABLE tb_store
    ADD CONSTRAINT fk_store_category
        FOREIGN KEY (category_id) REFERENCES tb_category (category_id);

ALTER TABLE tb_store
    ADD INDEX idx_store_category_id (category_id);

-- 4. 기존 category 컬럼을 deprecated 처리 (NULL 허용 + VARCHAR)
--    이후 모든 INSERT/UPDATE는 category_id를 정답으로 사용.
--    category 컬럼은 일반 화면 호환성을 위해 카테고리 코드를 함께 채워주는 식으로 유지.
ALTER TABLE tb_store
    MODIFY COLUMN category VARCHAR(20) NULL COMMENT '(deprecated) category_id 사용';
