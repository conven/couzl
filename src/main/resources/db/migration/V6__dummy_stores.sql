-- ============================================================
-- Couzl 더미 가맹점/쿠폰 데이터
-- 서울/경기/인천 주요 동네별 가맹점 150개 + 가맹점당 쿠폰 2~3개
-- ============================================================

-- ============================================================
-- 1. tb_region 신규 동네 추가 (region_id 7~31)
--    기존: 1=강남구, 2=서초구, 3=마포구, 4=송파구, 5=종로구, 6=영등포구
-- ============================================================
INSERT INTO tb_region (region_name, is_active, created_by, updated_by) VALUES
('홍대',     1, 'system', 'system'),  -- 7
('합정',     1, 'system', 'system'),  -- 8
('이태원',   1, 'system', 'system'),  -- 9
('건대',     1, 'system', 'system'),  -- 10
('신촌',     1, 'system', 'system'),  -- 11
('혜화',     1, 'system', 'system'),  -- 12
('성수동',   1, 'system', 'system'),  -- 13
('잠실',     1, 'system', 'system'),  -- 14
('여의도',   1, 'system', 'system'),  -- 15
('노원',     1, 'system', 'system'),  -- 16
('강동구',   1, 'system', 'system'),  -- 17
('판교',     1, 'system', 'system'),  -- 18
('분당',     1, 'system', 'system'),  -- 19
('수원',     1, 'system', 'system'),  -- 20
('일산',     1, 'system', 'system'),  -- 21
('안양',     1, 'system', 'system'),  -- 22
('과천',     1, 'system', 'system'),  -- 23
('김포',     1, 'system', 'system'),  -- 24
('부천',     1, 'system', 'system'),  -- 25
('부평구',   1, 'system', 'system'),  -- 26
('계양구',   1, 'system', 'system'),  -- 27
('남동구',   1, 'system', 'system'),  -- 28
('연수구',   1, 'system', 'system'),  -- 29
('서구',     1, 'system', 'system'),  -- 30
('송도',     1, 'system', 'system'); -- 31


-- ============================================================
-- 2. 가맹점 + 쿠폰
--    패턴: store INSERT → SET @sid = LAST_INSERT_ID() → coupon INSERT
--    쿠폰 expire_date: NOW() + 3개월
-- ============================================================

-- ====================== [강남구 region_id=1] 10개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, '강남 빈스로스터리', 'CAFE', '서울 강남구 테헤란로 152', '02-1111-0001', '08:00 - 22:00', '직접 로스팅한 스페셜티 원두로 매일 새로운 한 잔을 제공합니다.', '☕', 4.7, 37.5012, 127.0388, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, '테헤란 커피랩', 'CAFE', '서울 강남구 테헤란로 234', '02-1111-0002', '08:00 - 22:00', '드립부터 에스프레소까지, 커피 본연의 맛을 즐길 수 있는 공간입니다.', '☕', 4.5, 37.5050, 127.0410, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, '강남역 디저트하우스', 'CAFE', '서울 강남구 강남대로 396', '02-1111-0003', '08:00 - 22:00', '시즌별 시그니처 디저트와 직접 내린 커피를 즐길 수 있는 카페입니다.', '☕', 4.6, 37.4979, 127.0276, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, '강남 한우상회', 'FOOD', '서울 강남구 봉은사로 102', '02-1111-0004', '11:00 - 22:00', '1++ 등급 한우만 취급하는 정통 한우 전문점입니다.', '🍖', 4.8, 37.5111, 127.0490, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '사이드 메뉴 1개 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 무료 업그레이드', '음료 사이즈 업그레이드 무료', '세트 메뉴 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, '압구정 스시오마카세', 'FOOD', '서울 강남구 압구정로 76', '02-1111-0005', '12:00 - 22:00', '제철 해산물로 구성된 정통 오마카세 코스를 제공합니다.', '🍱', 4.9, 37.5240, 127.0290, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '사이드 메뉴 1개 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, '강남 파스타팩토리', 'FOOD', '서울 강남구 강남대로 478', '02-1111-0006', '11:00 - 22:00', '수제 생면 파스타와 화덕 피자를 즐길 수 있는 이탈리안 레스토랑입니다.', '🍕', 4.4, 37.5080, 127.0450, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '사이드 메뉴 1개 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, '강남 헤어룸', 'BEAUTY', '서울 강남구 논현로 832', '02-1111-0007', '10:00 - 20:00', '트렌디한 헤어스타일을 제안하는 강남 대표 살롱입니다.', '💇', 4.7, 37.5172, 127.0473, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, '청담 네일아뜰리에', 'BEAUTY', '서울 강남구 청담동 89-12', '02-1111-0008', '10:00 - 20:00', '시즌별 트렌드 디자인을 제안하는 프리미엄 네일 살롱입니다.', '💅', 4.6, 37.5260, 127.0400, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, '강남 크로스핏박스', 'FITNESS', '서울 강남구 선릉로 200', '02-1111-0009', '06:00 - 23:00', '전문 코치와 함께하는 기능성 트레이닝 센터입니다.', '🏋️', 4.4, 37.5020, 127.0420, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(1, 'GS25 강남대로점', 'CONVENIENCE', '서울 강남구 강남대로 99', '02-1111-0010', '24시간', '강남대로 메인 직영 편의점입니다.', '🏪', 4.0, 37.4998, 127.0273, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '500원 할인', '전 상품 500원 할인', '5,000원 이상 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 500, 0, 'ACTIVE', 'system', 'system'),
(@sid, '1+1 이벤트', '지정 상품 1+1 증정', '이벤트 상품 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 300, 0, 'ACTIVE', 'system', 'system');


-- ====================== [서초구 region_id=2] 5개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(2, '서초 브런치카페', 'CAFE', '서울 서초구 서초대로 300', '02-2222-0001', '08:00 - 22:00', '서초 직장인들의 든든한 아침을 책임지는 브런치 전문 카페입니다.', '☕', 4.5, 37.4870, 127.0334, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(2, '서초 한정식', 'FOOD', '서울 서초구 반포대로 158', '02-2222-0002', '11:00 - 22:00', '제철 재료로 정성껏 차려내는 정통 한정식 전문점입니다.', '🍱', 4.6, 37.4850, 127.0290, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '사이드 메뉴 1개 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(2, '방배 라멘집', 'FOOD', '서울 서초구 방배로 45', '02-2222-0003', '11:00 - 22:00', '24시간 우려낸 진한 돈코츠 육수와 수제 면이 자랑인 라멘 전문점입니다.', '🍜', 4.7, 37.4790, 127.0150, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '교자 1접시 무료 제공', '라멘 2그릇 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(2, '서초 헤어살롱', 'BEAUTY', '서울 서초구 강남대로 251', '02-2222-0004', '10:00 - 20:00', '두피 케어부터 컬러까지, 토탈 헤어 케어를 제공하는 살롱입니다.', '💇', 4.5, 37.4825, 127.0340, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(2, '서초 요가스튜디오', 'FITNESS', '서울 서초구 사임당로 33', '02-2222-0005', '06:00 - 22:00', '하타, 빈야사, 아쉬탕가까지 다양한 요가 클래스를 제공하는 스튜디오입니다.', '🧘', 4.6, 37.4810, 127.0310, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [마포구 region_id=3] 5개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(3, '마포 로스터리', 'CAFE', '서울 마포구 양화로 78', '02-3333-0001', '08:00 - 22:00', '소량 로스팅으로 신선한 원두를 제공하는 동네 로스터리 카페입니다.', '☕', 4.6, 37.5620, 126.9080, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(3, '공덕 커피전문점', 'CAFE', '서울 마포구 마포대로 144', '02-3333-0002', '08:00 - 22:00', '공덕역 근처 직장인들의 사랑방 같은 동네 카페입니다.', '☕', 4.3, 37.5448, 126.9510, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(3, '마포 곱창전문점', 'FOOD', '서울 마포구 도화길 11', '02-3333-0003', '17:00 - 02:00', '50년 전통의 곱창 전문점, 야들야들한 곱창과 막창이 인기입니다.', '🍖', 4.8, 37.5650, 126.9100, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '볶음밥 1인분 무료 제공', '곱창 3인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(3, '마포 네일샵', 'BEAUTY', '서울 마포구 어울마당로 42', '02-3333-0004', '10:00 - 20:00', '깔끔한 시술과 합리적인 가격으로 마포 직장인들에게 사랑받는 네일샵입니다.', '💅', 4.4, 37.5640, 126.9075, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(3, 'CU 마포점', 'CONVENIENCE', '서울 마포구 마포대로 89', '02-3333-0005', '24시간', '마포역 1번 출구 앞 24시간 운영 편의점입니다.', '🏪', 4.0, 37.5630, 126.9090, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '500원 할인', '전 상품 500원 할인', '5,000원 이상 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 500, 0, 'ACTIVE', 'system', 'system'),
(@sid, '1+1 이벤트', '지정 상품 1+1 증정', '이벤트 상품 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 300, 0, 'ACTIVE', 'system', 'system');


-- ====================== [송파구 region_id=4] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(4, '송파 디저트하우스', 'CAFE', '서울 송파구 올림픽로 240', '02-4444-0001', '08:00 - 22:00', '시즌별 디저트와 직접 내린 드립커피를 즐길 수 있는 동네 카페입니다.', '☕', 4.5, 37.5140, 127.1050, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(4, '송파 한우상회', 'FOOD', '서울 송파구 백제고분로 320', '02-4444-0002', '11:00 - 22:00', '엄선된 1++ 한우를 합리적인 가격에 즐길 수 있는 한우 전문점입니다.', '🍖', 4.7, 37.5160, 127.1070, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '된장찌개 1개 무료 제공', '한우 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(4, '송파 헤어아뜰리에', 'BEAUTY', '서울 송파구 송파대로 200', '02-4444-0003', '10:00 - 20:00', '디자이너 1:1 컨설팅으로 맞춤형 헤어를 제안하는 살롱입니다.', '💇', 4.6, 37.5130, 127.1040, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(4, '송파 헬스장', 'FITNESS', '서울 송파구 잠실로 88', '02-4444-0004', '06:00 - 23:00', '최신 장비와 1:1 PT 프로그램을 갖춘 프리미엄 헬스장입니다.', '🏋️', 4.4, 37.5150, 127.1060, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [종로구 region_id=5] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(5, '종로 커피공장', 'CAFE', '서울 종로구 종로 90', '02-5555-0001', '08:00 - 22:00', '종로 한복판에서 직접 로스팅한 원두를 사용하는 스페셜티 카페입니다.', '☕', 4.5, 37.5730, 126.9790, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(5, '광화문 한정식', 'FOOD', '서울 종로구 사직로 14', '02-5555-0002', '11:00 - 22:00', '광화문 광장 인근, 정통 한정식 코스를 즐길 수 있는 한식 명가입니다.', '🍱', 4.8, 37.5750, 126.9770, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '계절 반찬 1개 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(5, '종로 우동집', 'FOOD', '서울 종로구 인사동길 35', '02-5555-0003', '11:00 - 22:00', '직접 뽑은 사누키 우동과 깊은 가다랑어 육수가 일품인 우동 전문점입니다.', '🍜', 4.5, 37.5720, 126.9800, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '튀김 1개 무료 제공', '우동 2그릇 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(5, '종로 헤어살롱', 'BEAUTY', '서울 종로구 종로 195', '02-5555-0004', '10:00 - 20:00', '클래식부터 트렌디까지 다양한 스타일을 소화하는 종로 대표 헤어살롱입니다.', '💇', 4.4, 37.5740, 126.9780, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [영등포구 region_id=6] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(6, '영등포 브런치카페', 'CAFE', '서울 영등포구 영등포로 150', '02-6666-0001', '08:00 - 22:00', '신선한 재료로 만든 브런치와 시그니처 음료를 즐길 수 있는 카페입니다.', '☕', 4.4, 37.5260, 126.8960, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(6, '영등포 곱창집', 'FOOD', '서울 영등포구 양산로 89', '02-6666-0002', '17:00 - 02:00', '20년 전통의 곱창 명가, 신선한 한우 곱창과 막창이 인기입니다.', '🍖', 4.6, 37.5270, 126.8970, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '볶음밥 1인분 무료 제공', '곱창 3인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(6, '영등포 네일샵', 'BEAUTY', '서울 영등포구 당산로 200', '02-6666-0003', '10:00 - 20:00', '깔끔한 시술과 친절한 응대로 단골이 많은 동네 네일샵입니다.', '💅', 4.5, 37.5255, 126.8950, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(6, '영등포 크로스핏', 'FITNESS', '서울 영등포구 영등포로 320', '02-6666-0004', '06:00 - 23:00', '체계적인 프로그램과 전문 코치진이 함께하는 크로스핏 박스입니다.', '🏋️', 4.5, 37.5265, 126.8965, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [홍대 region_id=7] 7개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(7, '홍대 빈스앤빈스', 'CAFE', '서울 마포구 와우산로 94', '02-7777-0001', '08:00 - 23:00', '홍대 거리 한복판에서 다양한 원두를 즐길 수 있는 인기 카페입니다.', '☕', 4.6, 37.5570, 126.9240, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(7, '홍대 디저트하우스', 'CAFE', '서울 마포구 양화로 152', '02-7777-0002', '08:00 - 23:00', 'SNS에서 화제인 비주얼 디저트와 시그니처 음료가 인기인 카페입니다.', '☕', 4.7, 37.5555, 126.9220, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(7, '홍대 라멘집', 'FOOD', '서울 마포구 홍익로 12', '02-7777-0003', '11:00 - 23:00', '돈코츠와 미소 라멘이 인기인 정통 일본식 라멘 전문점입니다.', '🍜', 4.5, 37.5560, 126.9230, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '교자 1접시 무료 제공', '라멘 2그릇 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(7, '홍대 떡볶이집', 'FOOD', '서울 마포구 어울마당로 56', '02-7777-0004', '11:00 - 23:00', '매콤달콤한 즉석떡볶이와 모듬튀김이 일품인 분식집입니다.', '🍜', 4.4, 37.5575, 126.9245, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '튀김 1개 무료 제공', '떡볶이 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(7, '홍대 헤어살롱', 'BEAUTY', '서울 마포구 와우산로 78', '02-7777-0005', '10:00 - 21:00', '20~30대 트렌드를 선도하는 홍대 핫플 헤어살롱입니다.', '💇', 4.7, 37.5550, 126.9215, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(7, '홍대 크로스핏박스', 'FITNESS', '서울 마포구 동교로 38', '02-7777-0006', '06:00 - 23:00', '활기찬 분위기에서 함께 운동하는 홍대 크로스핏 박스입니다.', '🏋️', 4.5, 37.5565, 126.9235, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(7, '세븐일레븐 홍대점', 'CONVENIENCE', '서울 마포구 양화로 168', '02-7777-0007', '24시간', '홍대입구역 9번 출구 앞 24시간 운영 편의점입니다.', '🏪', 4.0, 37.5562, 126.9232, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '500원 할인', '전 상품 500원 할인', '5,000원 이상 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 500, 0, 'ACTIVE', 'system', 'system'),
(@sid, '1+1 이벤트', '지정 상품 1+1 증정', '이벤트 상품 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 300, 0, 'ACTIVE', 'system', 'system');


-- ====================== [합정 region_id=8] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(8, '합정 로스터리', 'CAFE', '서울 마포구 양화로 45', '02-8888-0001', '08:00 - 22:00', '직접 로스팅한 원두로 정성껏 내린 핸드드립 커피가 자랑인 카페입니다.', '☕', 4.6, 37.5490, 126.9130, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(8, '합정 브런치카페', 'CAFE', '서울 마포구 잔다리로 24', '02-8888-0002', '08:00 - 22:00', '주말 줄서서 먹는 합정의 인기 브런치 명소입니다.', '☕', 4.7, 37.5500, 126.9140, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(8, '합정 파스타하우스', 'FOOD', '서울 마포구 토정로 88', '02-8888-0003', '11:00 - 22:00', '수제 생면 파스타와 화덕 피자가 일품인 이탈리안 레스토랑입니다.', '🍕', 4.5, 37.5495, 126.9135, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '샐러드 1접시 무료 제공', '파스타 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(8, '합정 네일샵', 'BEAUTY', '서울 마포구 양화로 100', '02-8888-0004', '10:00 - 20:00', '시즌별 트렌드 디자인을 합리적인 가격에 즐길 수 있는 네일샵입니다.', '💅', 4.4, 37.5492, 126.9138, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [이태원 region_id=9] 5개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(9, '이태원 브런치카페', 'CAFE', '서울 용산구 이태원로 200', '02-9999-0001', '08:00 - 22:00', '이국적인 분위기에서 즐기는 글로벌 스타일 브런치 카페입니다.', '☕', 4.6, 37.5340, 126.9940, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(9, '이태원 타코마니아', 'FOOD', '서울 용산구 이태원로 155', '02-9999-0002', '11:00 - 24:00', '정통 멕시칸 타코와 부리또를 즐길 수 있는 이태원 명소입니다.', '🍕', 4.5, 37.5345, 126.9950, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '나초 1개 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(9, '이태원 케밥집', 'FOOD', '서울 용산구 이태원로 180', '02-9999-0003', '11:00 - 24:00', '정통 터키식 케밥과 후무스를 맛볼 수 있는 중동음식 전문점입니다.', '🍕', 4.6, 37.5350, 126.9955, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '후무스 1개 무료 제공', '케밥 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(9, '이태원 수제버거', 'FOOD', '서울 용산구 이태원로 110', '02-9999-0004', '11:00 - 23:00', '직접 만든 패티와 신선한 재료로 만드는 프리미엄 수제버거 전문점입니다.', '🍕', 4.7, 37.5335, 126.9945, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '감자튀김 1개 무료 제공', '버거 세트 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(9, '이태원 헤어살롱', 'BEAUTY', '서울 용산구 이태원로 220', '02-9999-0005', '10:00 - 21:00', '외국인 고객도 많이 찾는 이태원 대표 글로벌 헤어살롱입니다.', '💇', 4.5, 37.5342, 126.9942, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [건대 region_id=10] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(10, '건대 커피하우스', 'CAFE', '서울 광진구 능동로 120', '02-1010-0001', '08:00 - 23:00', '건대 학생들의 작업 공간이자 휴식 공간인 24시간 운영 카페입니다.', '☕', 4.4, 37.5400, 127.0690, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(10, '건대 곱창집', 'FOOD', '서울 광진구 동일로 100', '02-1010-0002', '17:00 - 02:00', '건대 명물 곱창 골목의 원조 곱창 전문점입니다.', '🍖', 4.7, 37.5405, 127.0700, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '볶음밥 1인분 무료 제공', '곱창 3인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(10, '건대 분식집', 'FOOD', '서울 광진구 능동로 188', '02-1010-0003', '11:00 - 22:00', '학생들의 든든한 한 끼, 가성비 좋은 분식 전문점입니다.', '🍜', 4.3, 37.5410, 127.0705, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '튀김 1개 무료 제공', '떡볶이 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(10, '건대 헬스장', 'FITNESS', '서울 광진구 화양동 60', '02-1010-0004', '06:00 - 24:00', '학생 할인 혜택과 다양한 그룹 클래스를 운영하는 헬스장입니다.', '🏋️', 4.4, 37.5395, 127.0695, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [신촌 region_id=11] 5개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(11, '신촌 로스터리', 'CAFE', '서울 서대문구 연세로 30', '02-1111-0011', '08:00 - 23:00', '직접 볶은 원두로 내리는 신촌의 대표 스페셜티 카페입니다.', '☕', 4.5, 37.5555, 126.9365, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(11, '신촌 디저트하우스', 'CAFE', '서울 서대문구 신촌로 75', '02-1111-0012', '08:00 - 23:00', '학생들이 사랑하는 가성비 좋은 디저트 카페입니다.', '☕', 4.4, 37.5560, 126.9370, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(11, '신촌 라멘집', 'FOOD', '서울 서대문구 연세로 23', '02-1111-0013', '11:00 - 23:00', '진한 돈코츠 육수와 쫄깃한 면이 일품인 라멘 전문점입니다.', '🍜', 4.6, 37.5565, 126.9375, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '교자 1접시 무료 제공', '라멘 2그릇 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(11, '신촌 분식집', 'FOOD', '서울 서대문구 명물길 22', '02-1111-0014', '11:00 - 22:00', '학생들이 즐겨 찾는 가성비 좋은 신촌 분식집입니다.', '🍜', 4.3, 37.5550, 126.9360, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '튀김 1개 무료 제공', '떡볶이 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(11, 'CU 신촌점', 'CONVENIENCE', '서울 서대문구 연세로 50', '02-1111-0015', '24시간', '신촌역 인근 24시간 운영 편의점입니다.', '🏪', 4.0, 37.5558, 126.9368, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '500원 할인', '전 상품 500원 할인', '5,000원 이상 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 500, 0, 'ACTIVE', 'system', 'system'),
(@sid, '1+1 이벤트', '지정 상품 1+1 증정', '이벤트 상품 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 300, 0, 'ACTIVE', 'system', 'system');


-- ====================== [혜화 region_id=12] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(12, '혜화 북카페', 'CAFE', '서울 종로구 대학로 110', '02-1212-0001', '08:00 - 23:00', '대학로의 조용한 분위기에서 책과 함께 즐기는 북카페입니다.', '☕', 4.6, 37.5820, 127.0015, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(12, '대학로 브런치', 'CAFE', '서울 종로구 동숭길 30', '02-1212-0002', '08:00 - 22:00', '공연 전후 들르기 좋은 대학로의 인기 브런치 카페입니다.', '☕', 4.5, 37.5830, 127.0020, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(12, '혜화 막걸리집', 'FOOD', '서울 종로구 창경궁로 252', '02-1212-0003', '17:00 - 24:00', '전통주와 어울리는 안주를 즐길 수 있는 대학로 막걸리 전문점입니다.', '🍖', 4.5, 37.5825, 127.0018, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '전 1접시 무료 제공', '막걸리 2병 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(12, '혜화 헤어살롱', 'BEAUTY', '서울 종로구 대학로 145', '02-1212-0004', '10:00 - 20:00', '학생 가격으로 트렌디한 스타일을 즐길 수 있는 동네 헤어살롱입니다.', '💇', 4.4, 37.5828, 127.0022, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [성수동 region_id=13] 7개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(13, '성수동 커피공장', 'CAFE', '서울 성동구 성수이로 88', '02-1313-0001', '08:00 - 23:00', '폐공장을 개조한 감각적인 공간에서 즐기는 성수동 대표 카페입니다.', '☕', 4.8, 37.5440, 127.0555, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(13, '성수 디저트랩', 'CAFE', '서울 성동구 연무장길 42', '02-1313-0002', '08:00 - 22:00', '시즌별 한정 디저트와 시그니처 음료가 인기인 핫플 카페입니다.', '☕', 4.7, 37.5450, 127.0565, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '시즌 디저트 1개 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(13, '성수 핸드드립카페', 'CAFE', '서울 성동구 서울숲길 15', '02-1313-0003', '08:00 - 22:00', '바리스타가 직접 내려주는 핸드드립 커피가 자랑인 작은 카페입니다.', '☕', 4.6, 37.5445, 127.0570, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(13, '성수 양조장', 'FOOD', '서울 성동구 성수이로 76', '02-1313-0004', '17:00 - 02:00', '직접 양조한 크래프트 맥주와 수제 안주를 즐길 수 있는 브루펍입니다.', '🍖', 4.7, 37.5448, 127.0558, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '수제 소시지 1개 무료 제공', '맥주 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(13, '성수 수제버거', 'FOOD', '서울 성동구 연무장5가길 11', '02-1313-0005', '11:00 - 22:00', '신선한 식재료로 만든 프리미엄 수제버거 전문점입니다.', '🍕', 4.6, 37.5442, 127.0552, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '감자튀김 1개 무료 제공', '버거 세트 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(13, '성수 헤어살롱', 'BEAUTY', '서울 성동구 성수일로 56', '02-1313-0006', '10:00 - 20:00', '감각적인 인테리어와 트렌드 스타일을 제안하는 성수동 핫플 살롱입니다.', '💇', 4.7, 37.5446, 127.0560, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(13, '성수 필라테스', 'FITNESS', '서울 성동구 왕십리로 222', '02-1313-0007', '06:00 - 22:00', '1:1 맞춤 레슨과 그룹 클래스를 운영하는 필라테스 스튜디오입니다.', '🧘', 4.6, 37.5444, 127.0563, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [잠실 region_id=14] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(14, '잠실 브런치카페', 'CAFE', '서울 송파구 올림픽로 300', '02-1414-0001', '08:00 - 22:00', '롯데타워가 보이는 뷰가 일품인 잠실의 인기 브런치 카페입니다.', '☕', 4.5, 37.5130, 127.0995, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(14, '잠실 초밥집', 'FOOD', '서울 송파구 잠실로 85', '02-1414-0002', '11:00 - 22:00', '신선한 제철 해산물로 만든 정통 일식 초밥 전문점입니다.', '🍱', 4.7, 37.5135, 127.1005, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '미소시루 1개 무료 제공', '초밥 세트 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(14, '잠실 헤어아뜰리에', 'BEAUTY', '서울 송파구 송파대로 567', '02-1414-0003', '10:00 - 20:00', '디자이너 1:1 컨설팅으로 맞춤형 스타일을 제안하는 헤어 아뜰리에입니다.', '💇', 4.6, 37.5128, 127.0998, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(14, '잠실 크로스핏', 'FITNESS', '서울 송파구 올림픽로 240', '02-1414-0004', '06:00 - 23:00', '잠실 한복판에서 함께하는 활기찬 크로스핏 박스입니다.', '🏋️', 4.5, 37.5138, 127.1003, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [여의도 region_id=15] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(15, '여의도 커피로스터스', 'CAFE', '서울 영등포구 여의대로 70', '02-1515-0001', '07:00 - 22:00', '직장인들의 아침을 책임지는 여의도 대표 로스터리 카페입니다.', '☕', 4.5, 37.5215, 126.9240, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(15, '여의도 한식당', 'FOOD', '서울 영등포구 의사당대로 88', '02-1515-0002', '11:00 - 22:00', '비즈니스 미팅에 적합한 정갈한 한정식 전문점입니다.', '🍱', 4.6, 37.5220, 126.9245, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '계절 반찬 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(15, '여의도 일식당', 'FOOD', '서울 영등포구 국제금융로 30', '02-1515-0003', '11:00 - 22:00', '신선한 회와 정통 일식 코스를 즐길 수 있는 여의도 일식당입니다.', '🍱', 4.7, 37.5225, 126.9250, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '미소시루 1개 무료 제공', '코스 메뉴 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(15, '여의도 PT스튜디오', 'FITNESS', '서울 영등포구 여의대로 108', '02-1515-0004', '06:00 - 23:00', '1:1 맞춤 PT와 그룹 클래스를 운영하는 여의도 PT 스튜디오입니다.', '💪', 4.6, 37.5218, 126.9242, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [노원 region_id=16] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(16, '노원 디저트카페', 'CAFE', '서울 노원구 노원로 425', '02-1616-0001', '08:00 - 22:00', '노원역 인근의 아늑한 동네 디저트 카페입니다.', '☕', 4.4, 37.6540, 127.0565, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(16, '노원 곱창전문점', 'FOOD', '서울 노원구 동일로 1390', '02-1616-0002', '17:00 - 02:00', '노원의 대표 곱창 명소, 신선한 한우 곱창이 자랑입니다.', '🍖', 4.6, 37.6545, 127.0570, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '볶음밥 1인분 무료 제공', '곱창 3인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(16, '노원 헤어살롱', 'BEAUTY', '서울 노원구 노원로 380', '02-1616-0003', '10:00 - 20:00', '깔끔한 시술과 친절한 응대로 단골이 많은 노원 헤어살롱입니다.', '💇', 4.5, 37.6538, 127.0567, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(16, '이마트24 노원점', 'CONVENIENCE', '서울 노원구 노원로 410', '02-1616-0004', '24시간', '노원역 4번 출구 앞 24시간 운영 편의점입니다.', '🏪', 4.0, 37.6542, 127.0568, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '500원 할인', '전 상품 500원 할인', '5,000원 이상 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 500, 0, 'ACTIVE', 'system', 'system'),
(@sid, '1+1 이벤트', '지정 상품 1+1 증정', '이벤트 상품 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 300, 0, 'ACTIVE', 'system', 'system');


-- ====================== [강동구 region_id=17] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(17, '강동 브런치카페', 'CAFE', '서울 강동구 천호대로 1077', '02-1717-0001', '08:00 - 22:00', '천호역 인근의 분위기 좋은 브런치 카페입니다.', '☕', 4.4, 37.5300, 127.1235, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(17, '강동 한우상회', 'FOOD', '서울 강동구 성내로 50', '02-1717-0002', '11:00 - 22:00', '엄선된 1++ 한우를 합리적인 가격에 즐길 수 있는 한우 전문점입니다.', '🍖', 4.7, 37.5305, 127.1240, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '된장찌개 1개 무료 제공', '한우 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(17, '강동 네일샵', 'BEAUTY', '서울 강동구 천호대로 1066', '02-1717-0003', '10:00 - 20:00', '강동 주민들에게 사랑받는 동네 네일샵입니다.', '💅', 4.5, 37.5298, 127.1232, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(17, '강동 헬스장', 'FITNESS', '서울 강동구 천호대로 1100', '02-1717-0004', '06:00 - 24:00', '최신 장비와 그룹 클래스를 갖춘 강동 대표 헬스장입니다.', '🏋️', 4.4, 37.5302, 127.1238, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [판교 region_id=18] 6개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(18, '판교 로스터리', 'CAFE', '경기 성남시 분당구 판교역로 235', '031-1818-0001', '07:00 - 22:00', 'IT 직장인들의 든든한 아침을 책임지는 판교 로스터리 카페입니다.', '☕', 4.6, 37.3945, 127.1110, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(18, '판교 테크밸리커피', 'CAFE', '경기 성남시 분당구 대왕판교로 660', '031-1818-0002', '07:00 - 22:00', '테크밸리 직장인들의 사랑방 같은 동네 카페입니다.', '☕', 4.5, 37.3950, 127.1115, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(18, '판교 한정식', 'FOOD', '경기 성남시 분당구 판교로 256', '031-1818-0003', '11:00 - 22:00', '비즈니스 미팅에 적합한 정갈한 한정식을 제공하는 식당입니다.', '🍱', 4.7, 37.3948, 127.1112, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '계절 반찬 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(18, '판교 라멘집', 'FOOD', '경기 성남시 분당구 판교역로 145', '031-1818-0004', '11:00 - 22:00', '진한 돈코츠 라멘과 사이드 메뉴가 인기인 일식 라멘 전문점입니다.', '🍜', 4.5, 37.3944, 127.1108, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '교자 1접시 무료 제공', '라멘 2그릇 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(18, '판교 헤어살롱', 'BEAUTY', '경기 성남시 분당구 대왕판교로 644', '031-1818-0005', '10:00 - 20:00', '판교 직장인들이 사랑하는 트렌디한 헤어 살롱입니다.', '💇', 4.6, 37.3946, 127.1113, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(18, '판교 크로스핏박스', 'FITNESS', '경기 성남시 분당구 판교로 264', '031-1818-0006', '06:00 - 23:00', '체계적인 프로그램과 전문 코치진이 함께하는 판교 크로스핏 박스입니다.', '🏋️', 4.6, 37.3950, 127.1110, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [분당 region_id=19] 6개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(19, '분당 커피로스터스', 'CAFE', '경기 성남시 분당구 정자일로 95', '031-1919-0001', '07:00 - 22:00', '분당 정자동의 대표 스페셜티 커피 로스터리입니다.', '☕', 4.6, 37.3818, 127.1184, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(19, '분당 베이커리카페', 'CAFE', '경기 성남시 분당구 서현로 240', '031-1919-0002', '08:00 - 22:00', '매일 아침 직접 구운 프리미엄 베이커리와 음료를 즐길 수 있는 카페입니다.', '🥐', 4.7, 37.3822, 127.1188, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(19, '분당 한우상회', 'FOOD', '경기 성남시 분당구 정자로 18', '031-1919-0003', '11:00 - 22:00', '1++ 등급 한우만 취급하는 분당 한우 전문점입니다.', '🍖', 4.8, 37.3820, 127.1185, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '된장찌개 1개 무료 제공', '한우 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(19, '분당 일식당', 'FOOD', '경기 성남시 분당구 정자일로 215', '031-1919-0004', '11:00 - 22:00', '신선한 회와 정통 일식 코스를 즐길 수 있는 분당 일식당입니다.', '🍱', 4.7, 37.3825, 127.1190, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '미소시루 1개 무료 제공', '코스 메뉴 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(19, '분당 네일아트', 'BEAUTY', '경기 성남시 분당구 서현로 184', '031-1919-0005', '10:00 - 20:00', '시즌별 디자인을 제안하는 분당 트렌드 네일 살롱입니다.', '💅', 4.5, 37.3819, 127.1183, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(19, '분당 PT스튜디오', 'FITNESS', '경기 성남시 분당구 정자일로 168', '031-1919-0006', '06:00 - 23:00', '1:1 맞춤 PT 프로그램으로 체계적인 운동을 도와드리는 스튜디오입니다.', '💪', 4.6, 37.3823, 127.1187, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [수원 region_id=20] 6개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(20, '수원 화성 커피', 'CAFE', '경기 수원시 팔달구 정조로 905', '031-2020-0001', '08:00 - 22:00', '수원 화성이 보이는 뷰가 일품인 동네 로스터리 카페입니다.', '☕', 4.6, 37.2630, 127.0280, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(20, '수원 디저트하우스', 'CAFE', '경기 수원시 팔달구 인계로 158', '031-2020-0002', '08:00 - 22:00', '시즌별 디저트와 시그니처 음료가 인기인 수원 디저트 카페입니다.', '☕', 4.5, 37.2638, 127.0286, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(20, '수원 갈비집', 'FOOD', '경기 수원시 팔달구 정조로 800', '031-2020-0003', '11:00 - 23:00', '수원의 명물 왕갈비를 맛볼 수 있는 정통 갈비 전문점입니다.', '🍖', 4.8, 37.2640, 127.0290, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '냉면 1그릇 무료 제공', '갈비 3인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(20, '수원 한정식', 'FOOD', '경기 수원시 팔달구 행궁로 32', '031-2020-0004', '11:00 - 22:00', '제철 재료로 차려내는 정갈한 한정식 코스 전문점입니다.', '🍱', 4.7, 37.2635, 127.0284, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '계절 반찬 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(20, '수원 헤어살롱', 'BEAUTY', '경기 수원시 영통구 광교호수공원로 80', '031-2020-0005', '10:00 - 20:00', '수원 광교 직장인들이 사랑하는 트렌디한 헤어 살롱입니다.', '💇', 4.5, 37.2632, 127.0282, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(20, '수원 크로스핏', 'FITNESS', '경기 수원시 팔달구 인계로 200', '031-2020-0006', '06:00 - 23:00', '전문 코치진과 함께하는 체계적인 크로스핏 박스입니다.', '🏋️', 4.5, 37.2642, 127.0292, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [일산 region_id=21] 5개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(21, '일산 커피하우스', 'CAFE', '경기 고양시 일산동구 중앙로 1228', '031-2121-0001', '08:00 - 22:00', '일산 호수공원 인근의 분위기 좋은 동네 카페입니다.', '☕', 4.5, 37.6580, 126.7695, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(21, '일산 라멘집', 'FOOD', '경기 고양시 일산서구 중앙로 1455', '031-2121-0002', '11:00 - 22:00', '진한 돈코츠 라멘이 일품인 일산의 인기 라멘 전문점입니다.', '🍜', 4.6, 37.6585, 126.7705, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '교자 1접시 무료 제공', '라멘 2그릇 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(21, '일산 한우상회', 'FOOD', '경기 고양시 일산동구 마두동 808', '031-2121-0003', '11:00 - 23:00', '엄선된 1++ 한우만 취급하는 일산 한우 전문점입니다.', '🍖', 4.7, 37.6588, 126.7702, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '된장찌개 1개 무료 제공', '한우 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(21, '일산 네일샵', 'BEAUTY', '경기 고양시 일산서구 중앙로 1346', '031-2121-0004', '10:00 - 20:00', '깔끔한 시술과 다양한 디자인을 제공하는 일산 네일샵입니다.', '💅', 4.5, 37.6582, 126.7698, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(21, '일산 헬스장', 'FITNESS', '경기 고양시 일산동구 정발산로 24', '031-2121-0005', '06:00 - 24:00', '최신 장비와 그룹 클래스를 갖춘 일산 대표 헬스장입니다.', '🏋️', 4.4, 37.6586, 126.7703, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [안양 region_id=22] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(22, '안양 브런치카페', 'CAFE', '경기 안양시 동안구 시민대로 178', '031-2222-0001', '08:00 - 22:00', '주말 가족 단위로 인기 있는 안양의 브런치 카페입니다.', '☕', 4.4, 37.3940, 126.9565, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(22, '안양 곱창집', 'FOOD', '경기 안양시 만안구 만안로 240', '031-2222-0002', '17:00 - 02:00', '안양 토박이들이 사랑하는 30년 전통 곱창 전문점입니다.', '🍖', 4.6, 37.3945, 126.9570, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '볶음밥 1인분 무료 제공', '곱창 3인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(22, '안양 헤어살롱', 'BEAUTY', '경기 안양시 동안구 평촌대로 220', '031-2222-0003', '10:00 - 20:00', '동네 단골이 많은 안양 평촌의 친근한 헤어 살롱입니다.', '💇', 4.5, 37.3942, 126.9567, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(22, 'GS25 안양점', 'CONVENIENCE', '경기 안양시 동안구 시민대로 215', '031-2222-0004', '24시간', '평촌역 인근 24시간 운영 편의점입니다.', '🏪', 4.0, 37.3943, 126.9568, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '500원 할인', '전 상품 500원 할인', '5,000원 이상 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 500, 0, 'ACTIVE', 'system', 'system'),
(@sid, '1+1 이벤트', '지정 상품 1+1 증정', '이벤트 상품 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 300, 0, 'ACTIVE', 'system', 'system');


-- ====================== [과천 region_id=23] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(23, '과천 커피로스터스', 'CAFE', '경기 과천시 별양로 35', '031-2323-0001', '08:00 - 22:00', '과천 정부청사 인근의 직장인 단골 카페입니다.', '☕', 4.5, 37.4290, 126.9870, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(23, '과천 한정식', 'FOOD', '경기 과천시 관문로 88', '031-2323-0002', '11:00 - 22:00', '정갈한 한식 코스를 즐길 수 있는 과천 한정식 전문점입니다.', '🍱', 4.6, 37.4295, 126.9876, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '계절 반찬 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(23, '과천 네일아트', 'BEAUTY', '경기 과천시 별양상가1로 25', '031-2323-0003', '10:00 - 20:00', '꼼꼼한 시술과 트렌디한 디자인이 매력인 과천 네일샵입니다.', '💅', 4.5, 37.4288, 126.9872, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(23, '과천 요가스튜디오', 'FITNESS', '경기 과천시 별양로 110', '031-2323-0004', '06:00 - 22:00', '하타, 빈야사 등 다양한 클래스를 운영하는 과천 요가 스튜디오입니다.', '🧘', 4.6, 37.4293, 126.9874, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [김포 region_id=24] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(24, '김포 브런치카페', 'CAFE', '경기 김포시 김포한강 4로 125', '031-2424-0001', '08:00 - 22:00', '김포 한강신도시의 분위기 좋은 브런치 카페입니다.', '☕', 4.5, 37.6150, 126.7150, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(24, '김포 한정식', 'FOOD', '경기 김포시 사우중로 89', '031-2424-0002', '11:00 - 22:00', '정갈한 한식 코스를 합리적인 가격에 즐길 수 있는 한정식 전문점입니다.', '🍱', 4.6, 37.6158, 126.7160, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '계절 반찬 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(24, '김포 떡볶이집', 'FOOD', '경기 김포시 김포대로 1898', '031-2424-0003', '11:00 - 22:00', '얼큰한 즉석떡볶이와 가성비 좋은 분식을 즐길 수 있는 떡볶이 전문점입니다.', '🍜', 4.4, 37.6155, 126.7156, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '튀김 1개 무료 제공', '떡볶이 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(24, '김포 헤어살롱', 'BEAUTY', '경기 김포시 김포한강 8로 88', '031-2424-0004', '10:00 - 20:00', '동네 단골이 많은 김포 한강신도시의 친근한 헤어 살롱입니다.', '💇', 4.5, 37.6153, 126.7155, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [부천 region_id=25] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(25, '부천 커피공장', 'CAFE', '경기 부천시 부천로 188', '032-2525-0001', '08:00 - 22:00', '직접 로스팅한 원두로 내리는 부천의 대표 스페셜티 카페입니다.', '☕', 4.5, 37.5030, 126.7655, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(25, '부천 곱창집', 'FOOD', '경기 부천시 송내대로 350', '032-2525-0002', '17:00 - 02:00', '신선한 한우 곱창과 막창을 맛볼 수 있는 부천 곱창 전문점입니다.', '🍖', 4.6, 37.5040, 126.7665, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '볶음밥 1인분 무료 제공', '곱창 3인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(25, '부천 네일샵', 'BEAUTY', '경기 부천시 길주로 232', '032-2525-0003', '10:00 - 20:00', '시즌별 디자인을 합리적인 가격에 즐길 수 있는 부천 네일샵입니다.', '💅', 4.4, 37.5033, 126.7658, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(25, '부천 PT스튜디오', 'FITNESS', '경기 부천시 부천로 250', '032-2525-0004', '06:00 - 23:00', '1:1 맞춤 PT 프로그램으로 체계적인 운동을 도와드리는 PT 스튜디오입니다.', '💪', 4.5, 37.5037, 126.7662, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [부평구 region_id=26] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(26, '부평 디저트카페', 'CAFE', '인천 부평구 부평대로 28', '032-2626-0001', '08:00 - 22:00', '부평역 인근의 아늑한 분위기에서 디저트와 음료를 즐길 수 있는 카페입니다.', '☕', 4.4, 37.5072, 126.7215, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(26, '부평 떡볶이집', 'FOOD', '인천 부평구 시장로 25', '032-2626-0002', '11:00 - 22:00', '부평 시장의 명물, 매콤달콤한 즉석떡볶이가 인기인 분식집입니다.', '🍜', 4.5, 37.5080, 126.7222, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '튀김 1개 무료 제공', '떡볶이 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(26, '부평 헤어살롱', 'BEAUTY', '인천 부평구 부평대로 88', '032-2626-0003', '10:00 - 20:00', '동네 단골이 많은 부평의 친근한 헤어 살롱입니다.', '💇', 4.5, 37.5074, 126.7217, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(26, 'CU 부평점', 'CONVENIENCE', '인천 부평구 부평대로 50', '032-2626-0004', '24시간', '부평역 4번 출구 앞 24시간 운영 편의점입니다.', '🏪', 4.0, 37.5076, 126.7218, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '500원 할인', '전 상품 500원 할인', '5,000원 이상 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 500, 0, 'ACTIVE', 'system', 'system'),
(@sid, '1+1 이벤트', '지정 상품 1+1 증정', '이벤트 상품 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 300, 0, 'ACTIVE', 'system', 'system');


-- ====================== [계양구 region_id=27] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(27, '계양 커피로스터스', 'CAFE', '인천 계양구 계양대로 88', '032-2727-0001', '08:00 - 22:00', '직접 로스팅한 원두로 정성껏 내린 커피를 즐길 수 있는 동네 카페입니다.', '☕', 4.5, 37.5370, 126.7375, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(27, '계양 한우상회', 'FOOD', '인천 계양구 계산새로 88', '032-2727-0002', '11:00 - 22:00', '엄선된 한우만 취급하는 계양구 한우 전문점입니다.', '🍖', 4.6, 37.5378, 126.7382, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '된장찌개 1개 무료 제공', '한우 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(27, '계양 네일샵', 'BEAUTY', '인천 계양구 계양대로 122', '032-2727-0003', '10:00 - 20:00', '계양 주민들에게 사랑받는 깔끔하고 친절한 네일샵입니다.', '💅', 4.4, 37.5372, 126.7376, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(27, '계양 헬스장', 'FITNESS', '인천 계양구 장제로 880', '032-2727-0004', '06:00 - 24:00', '최신 장비를 갖춘 계양 대표 헬스장입니다.', '🏋️', 4.4, 37.5376, 126.7380, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [남동구 region_id=28] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(28, '구월동 브런치카페', 'CAFE', '인천 남동구 인주대로 678', '032-2828-0001', '08:00 - 22:00', '구월동의 인기 브런치 명소, 주말마다 줄 서서 먹는 카페입니다.', '☕', 4.6, 37.4470, 126.7310, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(28, '남동 한식당', 'FOOD', '인천 남동구 구월로 285', '032-2828-0002', '11:00 - 22:00', '정갈한 한식 코스를 즐길 수 있는 남동구의 대표 한식당입니다.', '🍱', 4.6, 37.4475, 126.7318, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '계절 반찬 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(28, '남동 메이크업스튜디오', 'BEAUTY', '인천 남동구 인주대로 600', '032-2828-0003', '10:00 - 20:00', '웨딩, 행사 메이크업을 전문으로 하는 남동구 메이크업 스튜디오입니다.', '💄', 4.7, 37.4468, 126.7312, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '헤어 세팅 서비스 무료 추가', '메이크업 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(28, '남동 크로스핏', 'FITNESS', '인천 남동구 인주대로 720', '032-2828-0004', '06:00 - 23:00', '체계적인 프로그램과 전문 코치진이 함께하는 남동구 크로스핏 박스입니다.', '🏋️', 4.5, 37.4473, 126.7316, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [연수구 region_id=29] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(29, '연수 디저트카페', 'CAFE', '인천 연수구 청능대로 240', '032-2929-0001', '08:00 - 22:00', '시즌별 디저트와 시그니처 음료가 인기인 연수구 디저트 카페입니다.', '☕', 4.5, 37.4105, 126.6778, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(29, '연수 라멘집', 'FOOD', '인천 연수구 컨벤시아대로 165', '032-2929-0002', '11:00 - 22:00', '진한 돈코츠 라멘과 사이드가 일품인 연수구 라멘 전문점입니다.', '🍜', 4.6, 37.4112, 126.6785, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '교자 1접시 무료 제공', '라멘 2그릇 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(29, '연수 헤어살롱', 'BEAUTY', '인천 연수구 청능대로 380', '032-2929-0003', '10:00 - 20:00', '동네 단골이 많은 연수구의 친근한 헤어 살롱입니다.', '💇', 4.5, 37.4107, 126.6780, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '두피케어 서비스', '두피 케어 서비스 무료 추가', '헤어 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(29, '연수 PT스튜디오', 'FITNESS', '인천 연수구 컨벤시아대로 200', '032-2929-0004', '06:00 - 23:00', '1:1 맞춤 PT 프로그램으로 체계적인 운동을 도와드리는 스튜디오입니다.', '💪', 4.6, 37.4110, 126.6782, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [서구 region_id=30] 4개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(30, '서구 청라커피', 'CAFE', '인천 서구 청라한내로 88', '032-3030-0001', '08:00 - 22:00', '청라 호수공원 인근의 분위기 좋은 청라 대표 카페입니다.', '☕', 4.5, 37.5450, 126.6756, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(30, '서구 한식당', 'FOOD', '인천 서구 청라라임로 64', '032-3030-0002', '11:00 - 22:00', '정갈한 한식과 한정식 코스를 즐길 수 있는 서구 한식당입니다.', '🍱', 4.5, 37.5460, 126.6765, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '계절 반찬 무료 제공', '메인 메뉴 2개 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(30, '서구 네일샵', 'BEAUTY', '인천 서구 청라에메랄드로 112', '032-3030-0003', '10:00 - 20:00', '청라 주민들에게 사랑받는 트렌디한 네일샵입니다.', '💅', 4.5, 37.5455, 126.6760, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '풋케어 서비스 무료 추가', '네일 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(30, '서구 요가스튜디오', 'FITNESS', '인천 서구 청라한내로 122', '032-3030-0004', '06:00 - 22:00', '하타, 빈야사 등 다양한 요가 클래스를 운영하는 서구 요가 스튜디오입니다.', '🧘', 4.6, 37.5453, 126.6762, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');


-- ====================== [송도 region_id=31] 7개 ======================
INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(31, '송도 카페하루', 'CAFE', '인천 연수구 컨벤시아대로 165', '032-3131-0001', '08:00 - 22:00', '송도 센트럴파크 인근의 분위기 좋은 동네 카페입니다.', '☕', 4.7, 37.3835, 126.6430, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '케이크 서비스', '케이크 1조각 무료 제공', '음료 2잔 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(31, '송도 베이커리카페', 'CAFE', '인천 연수구 송도과학로 80', '032-3131-0002', '08:00 - 22:00', '매일 아침 직접 구운 프리미엄 베이커리와 음료를 즐길 수 있는 송도 카페입니다.', '🥐', 4.6, 37.3842, 126.6435, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '아메리카노 1+1', '아메리카노 1+1 증정', '음료 1잔 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '음료 20% 할인', '전 음료 20% 할인', '앱 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(31, '송도 라멘집', 'FOOD', '인천 연수구 컨벤시아대로 200', '032-3131-0003', '11:00 - 22:00', '진한 돈코츠 라멘과 사이드가 인기인 송도 라멘 전문점입니다.', '🍜', 4.6, 37.3838, 126.6432, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '교자 1접시 무료 제공', '라멘 2그릇 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(31, '송도 한우상회', 'FOOD', '인천 연수구 송도동 24-5', '032-3131-0004', '11:00 - 23:00', '엄선된 1++ 한우만 취급하는 송도 한우 전문점입니다.', '🍖', 4.8, 37.3844, 126.6438, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '2만원 이상 10% 할인', '전 메뉴 10% 할인', '2만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '사이드 메뉴 무료', '된장찌개 1개 무료 제공', '한우 2인분 이상 주문시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 80, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(31, '송도 메이크업스튜디오', 'BEAUTY', '인천 연수구 송도과학로 130', '032-3131-0005', '10:00 - 20:00', '웨딩, 행사 메이크업을 전문으로 하는 송도 메이크업 스튜디오입니다.', '💄', 4.7, 37.3836, 126.6428, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '첫 방문 30% 할인', '전체 시술 30% 할인', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '시술 1만원 할인', '시술 비용 1만원 할인', '5만원 이상 결제시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 100, 0, 'ACTIVE', 'system', 'system'),
(@sid, '서비스 추가 제공', '헤어 세팅 서비스 무료 추가', '메이크업 시술 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(31, '송도 크로스핏박스', 'FITNESS', '인천 연수구 컨벤시아대로 230', '032-3131-0006', '06:00 - 23:00', '체계적인 프로그램과 전문 코치진이 함께하는 송도 크로스핏 박스입니다.', '🏋️', 4.6, 37.3840, 126.6434, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '1일 무료 체험', '1일 이용권 무료 제공', '첫 방문 고객 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 50, 0, 'ACTIVE', 'system', 'system'),
(@sid, '등록비 면제', '회원 등록비 면제', '3개월 이상 등록시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 30, 0, 'ACTIVE', 'system', 'system');

INSERT INTO tb_store (region_id, store_name, category, address, phone, business_hours, description, emoji, rating_avg, latitude, longitude, status, created_by, updated_by) VALUES
(31, 'GS25 송도센트럴파크점', 'CONVENIENCE', '인천 연수구 컨벤시아대로 165', '032-3131-0007', '24시간', '송도 센트럴파크 인근 24시간 운영 편의점입니다.', '🏪', 4.1, 37.3839, 126.6432, 'ACTIVE', 'system', 'system');
SET @sid = LAST_INSERT_ID();
INSERT INTO tb_coupon (store_id, coupon_name, benefit, condition_text, expire_date, total_count, issued_count, status, created_by, updated_by) VALUES
(@sid, '500원 할인', '전 상품 500원 할인', '5,000원 이상 구매시', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 500, 0, 'ACTIVE', 'system', 'system'),
(@sid, '1+1 이벤트', '지정 상품 1+1 증정', '이벤트 상품 한정', DATE_ADD(CURDATE(), INTERVAL 3 MONTH), 300, 0, 'ACTIVE', 'system', 'system');
