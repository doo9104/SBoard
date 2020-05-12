## 개인 게시판 프로젝트

### 개발환경

### Front-End

- BootStrap 4.4.1
- JQuery 3.4.1

### Back-End

- Spring 3.1
- JDK 1.8
- Oracle 17.3.1
- Mybatis 3.5.3
- Tomcat 9
- Maven 3.6.1

---

백엔드는 스프링 프레임워크 구조로 스프링 시큐리티로 만들었으며, 게시판/댓글/회원/첨부파일과 관련된 테이블과 여러 DAO, DTO 객체로 구성되어 있습니다. 그리고 모든 리소스는 Oracle DB에 저장하였습니다.

프론트엔드는 JSP와 부트스트랩을 사용하였습니다.

## 구현 기능

- 로그인(spring-security)
- 게시판(페이징/검색/글쓰기/첨부파일)
- 게시글 상세페이지(수정/삭제/CKEditor)
- 마이페이지(닉네임,비밀번호,이메일 변경/회원 탈퇴)
- 다국어 지원(한국어,일본어,영어)

## 테이블 구성

<img width="556" alt="DB" src="https://user-images.githubusercontent.com/41267046/81645977-75f7c000-9465-11ea-9b3e-353a53174b8b.PNG">

## 프로젝트 구현

![메인](https://user-images.githubusercontent.com/41267046/81646088-9d4e8d00-9465-11ea-9018-a265a9cfd7ff.png)


검색 기능과 페이징 기능을 구현하였습니다.

<img width="899" alt="다국어지원 일본어" src="https://user-images.githubusercontent.com/41267046/81646147-b22b2080-9465-11ea-9746-74e010676828.PNG">

Message를 사용하여 다국어(한국어,일본어,영어)를 지원합니다.

<img width="911" alt="검색사진" src="https://user-images.githubusercontent.com/41267046/81646171-bd7e4c00-9465-11ea-974c-f200b7f6651e.PNG">

제목/제목+내용/작성자 등 여러 조건으로 검색기능을 구현하였습니다.

![글쓰기화면](https://user-images.githubusercontent.com/41267046/81646197-ca9b3b00-9465-11ea-83cb-eb1d97568436.png)

CKEditor를 이용하여 여러 태그로 게시물을 작성할 수 있고, 첨부파일 업로드 기능을 구현하였습니다.

<img width="911" alt="마이페이지" src="https://user-images.githubusercontent.com/41267046/81646224-d424a300-9465-11ea-9935-88b65ea02aa1.PNG">

Spring Security를 사용하여 회원 관리를 하였고, Ajax를 이용하여 실시간 중복검사, 회원 정보 변경,회원 탈퇴를 구현하였습니다.
