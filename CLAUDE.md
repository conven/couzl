# Couzl 프로젝트 개발 가이드

## 1. 프로젝트 개요

- **서비스명**: Couzl (쿠즐)
- **도메인**: 즐거움을 나누는 로컬 쿠폰 플랫폼 — 지역 기반 소상공인 쿠폰 발급/사용 서비스
- **타겟**: 모바일 웹 (max-width 430px 고정)

### 기술 스택
- **언어/런타임**: Java 17
- **프레임워크**: Spring Boot 3.5.14 (WAR 패키징, 내장 톰캣)
- **뷰**: JSP + JSTL (`/WEB-INF/views/`)
- **빌드**: Gradle
- **DB**: MariaDB (EC2 원격: `13.209.76.47:3306/couzldb`)
- **ORM**: MyBatis 3.0.5 (`map-underscore-to-camel-case=true`)
- **마이그레이션**: Flyway (`classpath:db/migration`, V1~V7)
- **인증**: 세션 기반 + BCrypt (Spring Security Crypto)
- **메일**: Gmail SMTP (이메일 인증코드 발송)
- **외부 API**: 카카오맵 SDK
- **기타**: Lombok, Thumbnailator(프로필 이미지 200x200 리사이즈), Devtools

---

## 2. 브랜드 규칙

| 항목 | 값 |
|---|---|
| 메인 컬러 | `#FFD60A` (theme-color 동일) |
| max-width | `430px` (모바일 폭 고정) |
| 폰트 | `sans-serif` |
| viewport | `width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no` (확대 차단) |

---

## 3. 폴더 구조

```
couzl/
├── build.gradle
├── CLAUDE.md
├── src/main/
│   ├── java/com/couzl/couzl/
│   │   ├── CouzlApplication.java        # @SpringBootApplication
│   │   ├── ServletInitializer.java      # WAR 배포용
│   │   ├── config/
│   │   │   ├── SecurityConfig.java      # BCryptPasswordEncoder Bean
│   │   │   └── WebMvcConfig.java        # LoginInterceptor 등록
│   │   ├── interceptor/
│   │   │   └── LoginInterceptor.java    # 세션 검증 → /login?msg=unauthorized
│   │   ├── controller/                  # 화면별 Controller
│   │   ├── service/                     # UserService, EmailService
│   │   ├── mapper/                      # MyBatis Mapper 인터페이스
│   │   └── dto/                         # UserDto, StoreDto, CouponDto, RegionDto
│   ├── resources/
│   │   ├── application.properties       # 공통 + view resolver + flyway
│   │   ├── application-dev.properties   # 로컬 DB 접속 + Gmail SMTP
│   │   ├── application-prod.properties
│   │   ├── mapper/                      # MyBatis XML
│   │   └── db/migration/                # Flyway V1~V7
│   └── webapp/
│       ├── WEB-INF/views/
│       │   ├── common/                  # 공통 include (아래 5번 참조)
│       │   └── *.jsp                    # 화면 JSP
│       └── static/
│           ├── css/                     # common.css + 페이지별
│           ├── js/                      # common.js + 페이지별
│           └── images/og-image.png
```

---

## 4. 완료된 화면 목록 (JSP + URL)

| URL | JSP | 설명 | 로그인 필요 |
|---|---|---|---|
| `/` | `index.jsp` | 진입점 | - |
| `/splash` | `splash.jsp` | 스플래시 | ✅ |
| `/login` | `login.jsp` | 로그인 (GET/POST) | ❌ |
| `/logout` | - | 세션 invalidate | ✅ |
| `/register` | `register.jsp` | 회원가입 (GET/POST + check-id/send-code/verify-code) | ❌ |
| `/find-id` | `find-id.jsp` | 아이디 찾기 | ❌ |
| `/find-pw` | `find-pw.jsp` | 비밀번호 찾기 | ❌ |
| `/password-change` | `password-change.jsp` | 비밀번호 변경 | ✅ |
| `/welcome` | `welcome.jsp` | 신규 회원 환영 (지역 미설정 시) | ✅ |
| `/location` | `location.jsp` | 지역 설정/변경 (GET/POST) | ✅ |
| `/main` | `main.jsp` | 홈 (배너/카테고리/인기 가맹점/HOT 쿠폰) | ✅ |
| `/map` | `map.jsp` | 카카오맵 기반 내 주변 가맹점 | ✅ |
| `/store` | `store-detail.jsp` | 가맹점 상세 (쿠폰/정보/리뷰 탭) | ✅ |
| `/coupon-box` | `coupon-box.jsp` | 내 쿠폰함 | ✅ |
| `/coupon-use` | `coupon-use.jsp` | 쿠폰 사용 (QR) | ✅ |
| `/review-list` | `review-list.jsp` | 리뷰 관리 | ✅ |
| `/review-write` | `review-write.jsp` | 리뷰 작성 | ✅ |
| `/mypage` | `mypage.jsp` | 마이페이지 | ✅ |
| `/profile-edit` | `profile-edit.jsp` | 프로필 수정 (이미지 업로드) | ✅ |
| `/withdraw` | `withdraw.jsp` | 회원 탈퇴 | ✅ |
| `/terms` | `terms.jsp` | 이용약관 | ❌ |
| `/privacy` | `privacy.jsp` | 개인정보 처리방침 | ❌ |

> 로그인 제외 경로는 `WebMvcConfig`의 `excludePathPatterns`에 등록.

---

## 5. 공통 컴포넌트 include 규칙

모든 JSP는 아래 규칙을 따른다.

### 5-1. `<head>` 안 — 필수
```jsp
<%@ include file="/WEB-INF/views/common/_meta.jsp" %>
```
> `_meta.jsp`에 charset, viewport, theme-color, OG/Twitter 메타, `/static/css/common.css`가 모두 포함됨. **개별 JSP에 charset/viewport/common.css 중복 금지.**

### 5-2. `<body>` 안 — 화면에 따라 사용

| Include | 위치 | 용도 |
|---|---|---|
| `_header.jsp` | 본문 최상단 | 상단 헤더 (📍지역 + 로고 + 🔔) — `_location_modal.jsp` 자동 포함 |
| `_tab_bar.jsp` | 본문 최하단 | 하단 탭바 (홈/내 주변/쿠폰함/마이페이지) |
| `_logo.jsp` | 필요 위치 | 로고 SVG (`bgColor`/`inkColor`/`notchColor` 파라미터) |
| `_location_modal.jsp` | `_header.jsp`에서 자동 include | 지역 선택 바텀시트 |

### 5-3. CSS/JS
- `_meta.jsp`가 `common.css`를 로드 → 추가 link 금지
- `</body>` 직전에 `<script src="/static/js/common.js"></script>` 후 페이지별 JS

---

## 6. DB 테이블 목록

> 모든 테이블 공통 컬럼: `created_by`, `created_at`, `updated_by`, `updated_at`, `is_deleted`

### `tb_region` — 지역
- `region_id` (PK), `region_name`, `is_active`

### `tb_user` — 회원
- `user_id` (PK), `login_id` (UQ), `password` (BCrypt), `nickname`, `email` (UQ)
- `social_type` (NONE/KAKAO/APPLE), `social_id`
- `status` (ACTIVE/SUSPENDED/WITHDRAWN)
- `region_id` (FK → tb_region)
- `profile_image` (MEDIUMBLOB), `profile_image_type` *(V4)*
- `email_verify_code`, `email_verify_expiry`, `email_verified` (Y/N) *(V7)*

### `tb_store` — 가맹점
- `store_id` (PK), `region_id` (FK), `store_name`
- `category` (CAFE/FOOD/BEAUTY/SHOPPING/FITNESS/CONVENIENCE)
- `address`, `phone`, `business_hours`, `description`, `emoji`
- `rating_avg`, `status` (ACTIVE/INACTIVE)
- `latitude`, `longitude` *(V5, DECIMAL(10,7))*

### `tb_coupon` — 쿠폰 마스터
- `coupon_id` (PK), `store_id` (FK), `coupon_name`, `benefit`, `condition_text`
- `expire_date`, `total_count` (0=무제한), `issued_count`
- `status` (ACTIVE/INACTIVE)

### `tb_user_coupon` — 사용자 보유 쿠폰
- `user_coupon_id` (PK), `user_id` (FK), `coupon_id` (FK)
- `coupon_code` (UUID, UQ)
- `status` (AVAILABLE/USED/EXPIRED), `used_at`

### `tb_review` — 리뷰
- `review_id` (PK), `user_id` (FK), `store_id` (FK), `user_coupon_id` (FK, UQ)
- `rating` (1~5), `content`
- `status` (ACTIVE/DELETED)
- **1 user_coupon = 1 review** (UNIQUE 제약)

---

## 7. Controller / Service / Mapper 패턴 규칙

### 7-1. 패키지 구조
```
controller  → service       → mapper(interface) ↔ mapper(XML)
                              ↓
                             dto
```

### 7-2. Controller
- `@Controller` + `@RequiredArgsConstructor` (Lombok DI)
- GET = 화면 반환, POST = 폼 처리
- 뷰 이름은 JSP 파일명 (확장자 제외): `return "main";`
- 로그인 회원: `(UserDto) session.getAttribute("LOGIN_USER")`
- 지역 세션: `(RegionDto) session.getAttribute("USER_REGION")`
- 화면만 보여주는 단순 Controller는 메서드 1~2개 (예: `MainController`, `TermsController`)
- 폼/이메일/이미지 등 로직이 있으면 Service 위임 (예: `LoginController` → `UserService`)

### 7-3. Service
- `@Service` + `@RequiredArgsConstructor`
- 트랜잭션 필요 시 `@Transactional` (예: `UserService.register`)
- 비밀번호: `BCryptPasswordEncoder` 주입 → `encode`/`matches`
- 세션 조작은 Service 안에서도 가능 (HttpSession 파라미터로 받음, `UserService.login` 참고)

### 7-4. Mapper
- 인터페이스 `@Mapper`, XML은 `src/main/resources/mapper/`에 동일 이름
- 다중 파라미터는 `@Param("xxx")` 필수
- 컬럼 ↔ 필드는 `snake_case` ↔ `camelCase` 자동 매핑
- 모든 SELECT/UPDATE에 `is_deleted = 0` 조건 포함 (논리 삭제)

### 7-5. DTO
- `@Getter @Setter` (Lombok)
- 단순 POJO, 비즈니스 로직 X

### 7-6. URL 컨벤션
- kebab-case (`/coupon-box`, `/profile-edit`, `/review-write`)
- JSP 파일명도 kebab-case로 동일하게 매칭

---

## 8. 미완성 / 진행중

### UI에 "준비중" / "준비 중입니다" 표시된 항목
- **소셜 로그인**: 카카오 / Apple 버튼은 alert만 (`login.jsp`, `register.jsp`)
- **공유 기능**: 가맹점 상세 공유 버튼 (`store-detail.jsp`)
- **알림**: 헤더 🔔 버튼 (`_header.jsp` — 항상 "알림이 없습니다")
- **리뷰 수정/삭제**: `review-list.jsp` 작성한 리뷰의 수정/삭제 버튼

### 백엔드 미구현
- **비밀번호 변경**: `/password-change`는 화면만 있고 PostMapping 없음 (JSP 안에서 alert로 임시 처리)
- **회원 탈퇴**: `/withdraw` GET만 있음, 실제 탈퇴 처리 PostMapping 없음
- **아이디/비밀번호 찾기**: `/find-id`, `/find-pw` 화면만 있음 (실제 발송/조회 로직 없음)
- **쿠폰 발급/사용**: `tb_coupon`, `tb_user_coupon` 테이블만 있고 Mapper/Service 미구현 (화면은 더미 데이터)
- **리뷰 등록/조회**: `tb_review` 테이블만 있고 Mapper/Service 미구현
- **가맹점 검색/카테고리 필터**: `main.jsp` 검색바는 readonly, 카테고리 클릭은 active 토글만

### 그 외 메모
- Flyway 최신 버전: **V7** (이메일 인증 컬럼 추가)
- 더미 로그인 계정: `couzl / password` (V3 마이그레이션)
- 카카오맵 키는 `application.properties`에 평문 노출 (운영 분리 필요)
- DB 접속 정보가 `application-dev.properties`에 평문 (Git 추적 시 주의)
