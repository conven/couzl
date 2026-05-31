ALTER TABLE tb_coupon
    ADD COLUMN max_per_user INT NOT NULL DEFAULT 1 COMMENT '인당 최대 발급 수';
