ALTER TABLE tb_store
ADD COLUMN latitude DECIMAL(10,7),
ADD COLUMN longitude DECIMAL(10,7);

UPDATE tb_store SET latitude=37.4979, longitude=127.0276 WHERE store_name='강남 커피로스터스';
UPDATE tb_store SET latitude=37.4989, longitude=127.0283 WHERE store_name='스시 오마카세 나카';
UPDATE tb_store SET latitude=37.4969, longitude=127.0261 WHERE store_name='헤어살롱 모아';
UPDATE tb_store SET latitude=37.4959, longitude=127.0271 WHERE store_name='크로스핏 강남';
