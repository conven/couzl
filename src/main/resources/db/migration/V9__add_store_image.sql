ALTER TABLE tb_store
    ADD COLUMN store_image      MEDIUMBLOB   NULL COMMENT '가맹점 대표 이미지',
    ADD COLUMN store_image_type VARCHAR(50)  NULL COMMENT '가맹점 대표 이미지 MIME 타입';
