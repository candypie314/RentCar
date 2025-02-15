---- member
--DROP TABLE "TABLE";
--
---- 회원
--DROP TABLE "member";
--
---- 렌트카
--DROP TABLE "rent_car";
--
---- 예약정보
--DROP TABLE "reserve_info";
--
---- 게시판
--DROP TABLE "board";
--
---- 댓글
--DROP TABLE "comment";
--
---- 문화축제
--DROP TABLE "festival";
--
---- 모델가격
--DROP TABLE "model_price";
--
---- 자동차
--DROP TABLE "car";
--
--drop table "car" cascade CONSTRAINTS;
--drop table "board" cascade CONSTRAINTS;
--drop table "rent_car" cascade CONSTRAINTS;
--drop table "member" cascade CONSTRAINTS;
--drop table member;
-- 회원
CREATE TABLE "member" (
   "member_id"    VARCHAR2(20) NOT NULL, -- 회원id
   "member_pw"    VARCHAR2(20) NOT NULL, -- 회원pw
   "member_class" CHAR(1)      NULL,     -- 회원분류
   "member_name"  VARCHAR2(20) NULL,     -- 회원이름
   "member_birth" VARCHAR2(20) NULL,     -- 생년월일
   "member_phone" VARCHAR2(20) NULL,     -- 전화번호
   "member_email" VARCHAR2(50) NULL,     -- 이메일
   "member_date"  DATE         NULL      -- 가입날짜
);

-- 회원
ALTER TABLE "member"
   ADD
      CONSTRAINT "PK_member" -- 회원 기본키
      PRIMARY KEY (
         "member_id" -- 회원id
      );

-- 렌트카
CREATE TABLE "rent_car" (
   "car_number"   VARCHAR2(20) NOT NULL, -- 차량번호
   "car_model"    VARCHAR2(20) NULL,     -- 차량모델
   "car_color"    VARCHAR2(20) NULL,     -- 차량색상
   "car_distance" INTEGER      NULL      -- 주행거리
);

-- 렌트카
ALTER TABLE "rent_car"
   ADD
      CONSTRAINT "PK_rent_car" -- 렌트카 기본키
      PRIMARY KEY (
         "car_number" -- 차량번호
      );

-- 예약정보
CREATE TABLE "reserve_info" (
   "reserve_num"   VARCHAR2(20) NOT NULL, -- 예약번호
   "member_id"     VARCHAR2(20) NOT NULL, -- 회원id
   "car_model"     VARCHAR2(20) NULL,     -- 차량모델
   "car_number"    VARCHAR2(20) NOT NULL, -- 차량번호
   "reserve_date"  DATE         NULL,     -- 예약날짜
   "reserve_end"   DATE         NULL,     -- 예약종료날짜
   "reserve_price" VARCHAR2(20) NULL,     -- 렌트가격
   "reserve_area"  VARCHAR2(20) NULL      -- 렌트지역
);

-- 예약정보
ALTER TABLE "reserve_info"
   ADD
      CONSTRAINT "PK_reserve_info" -- 예약정보 기본키
      PRIMARY KEY (
         "reserve_num" -- 예약번호
      );

-- 게시판
CREATE TABLE "board" (
   "board_num"     INTEGER       NOT NULL, -- 게시글번호
   "member_id"     VARCHAR2(20)  NOT NULL, -- 회원id(작성자)
   "board_origin"  INTEGER       NULL,     -- 원글번호
   "board_title"   VARCHAR2(20)  NULL,     -- 제목
   "board_content" VARCHAR2(200) NULL,     -- 내용
   "board_time"    DATE          NULL,     -- 작성시간
   "board_modify"  DATE          NULL      -- 최종수정시간
);

-- 게시판
ALTER TABLE "board"
   ADD
      CONSTRAINT "PK_board" -- 게시판 기본키
      PRIMARY KEY (
         "board_num", -- 게시글번호
         "member_id"  -- 회원id(작성자)
      );

-- 댓글
CREATE TABLE "comment" (
   "comment_num"     INTEGER       NOT NULL, -- 댓글번호
   "comment_origin"  INTEGER       NULL,     -- 원댓글번호
   "board_num"       INTEGER       NULL,     -- 게시글번호
   "comment_content" VARCHAR2(100) NULL,     -- 내용
   "member_id"       VARCHAR2(20)  NULL,     -- 회원id(작성자)
   "comment_date"    DATE          NULL      -- 작성시간
);

-- 댓글
ALTER TABLE "comment"
   ADD
      CONSTRAINT "PK_comment" -- 댓글 기본키
      PRIMARY KEY (
         "comment_num" -- 댓글번호
      );

-- 문화축제
CREATE TABLE "festival" (
   "festival_name"      VARCHAR2(20) NULL, -- 축제명
   "festival_area"      VARCHAR2(20) NULL, -- 개최장소
   "festival_date"      DATE         NULL, -- 축제시작날짜
   "festival_end"       DATE         NULL, -- 축제종료날짜
   "festival_institute" VARCHAR2(20) NULL, -- 주최기관
   "festival_phone"     VARCHAR2(20) NULL, -- 전화번호
   "festival_hompage"   VARCHAR2(20) NULL, -- 홈페이지주소
   "festival_address"   VARCHAR2(20) NULL, -- 도로명주소
   "latitude"           number(3,4)  NULL, -- 위도
   "longitude"          number(3,4)  NULL  -- 경도
);

-- 자동차
CREATE TABLE "car" (
   "car_model" VARCHAR2(20) NOT NULL, -- 차량모델
   "car_size"  VARCHAR2(20) NULL,     -- 차량크기
   "car_type"  VARCHAR2(20) NULL,     -- 차량종류
   "car_made"  VARCHAR2(20) NULL,     -- 제조사
   "car_price" VARCHAR2(20) NULL      -- 가격
);

-- 자동차
ALTER TABLE "car"
   ADD
      CONSTRAINT "PK_car" -- 자동차 기본키
      PRIMARY KEY (
         "car_model" -- 차량모델
      );

-- 렌트카
ALTER TABLE "rent_car"
   ADD
      CONSTRAINT "FK_car_TO_rent_car" -- 자동차 -> 렌트카
      FOREIGN KEY (
         "car_model" -- 차량모델
      )
      REFERENCES "car" ( -- 자동차
         "car_model" -- 차량모델
      );

-- 예약정보
ALTER TABLE "reserve_info"
   ADD
      CONSTRAINT "FK_member_TO_reserve_info" -- 회원 -> 예약정보
      FOREIGN KEY (
         "member_id" -- 회원id
      )
      REFERENCES "member" ( -- 회원
         "member_id" -- 회원id
      );

-- 예약정보
ALTER TABLE "reserve_info"
   ADD
      CONSTRAINT "FK_rent_car_TO_reserve_info" -- 렌트카 -> 예약정보
      FOREIGN KEY (
         "car_number" -- 차량번호
      )
      REFERENCES "rent_car" ( -- 렌트카
         "car_number" -- 차량번호
      );

-- 예약정보
ALTER TABLE "reserve_info"
   ADD
      CONSTRAINT "FK_car_TO_reserve_info" -- 자동차 -> 예약정보
      FOREIGN KEY (
         "car_model" -- 차량모델
      )
      REFERENCES "car" ( -- 자동차
         "car_model" -- 차량모델
      );

-- 게시판
ALTER TABLE "board"
   ADD
      CONSTRAINT "FK_member_TO_board" -- 회원 -> 게시판
      FOREIGN KEY (
         "member_id" -- 회원id(작성자)
      )
      REFERENCES "member" ( -- 회원
         "member_id" -- 회원id
      );

-- 댓글
ALTER TABLE "comment"
   ADD
      CONSTRAINT "FK_board_TO_comment" -- 게시판 -> 댓글
      FOREIGN KEY (
         "board_num", -- 게시글번호
         "member_id"  -- 회원id(작성자)
      )
      REFERENCES "board" ( -- 게시판
         "board_num", -- 게시글번호
         "member_id"  -- 회원id(작성자)
      );

-- 댓글
ALTER TABLE "comment"
   ADD
      CONSTRAINT "FK_member_TO_comment" -- 회원 -> 댓글
      FOREIGN KEY (
         "member_id" -- 회원id(작성자)
      )
      REFERENCES "member" ( -- 회원
         "member_id" -- 회원id
      );