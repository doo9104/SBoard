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

## 소개
스프링 프레임워크를 활용한 CRUD 게시판입니다.   
스프링 프레임워크의 개발환경 구축방법과 **MVC 패턴**에 대해 알게 되었습니다.   
게시물의 등록,조회,수정,삭제 기능을 구현 하였고, REST방식과 Ajax를 사용하는 댓글 기능으로 REST 구조에 대해 배웠습니다.   
MyBatis의 Mapper 인터페이스와 XML을 사용하여 데이터베이스에 접근하였습니다.   


백엔드는 스프링 프레임워크 구조로 스프링 시큐리티로 만들었으며, 게시판/댓글/회원/첨부파일과 관련된 테이블과 여러 DAO, DTO 객체로 구성되어 있습니다. 그리고 모든 리소스는 Oracle DB에 저장하였습니다.

## 구현 기능

- 로그인,회원가입(Spring-Security 사용)
- 회원가입시 이메일 인증을 통한 사용자 정보 검증
- 게시판(페이징/검색/글쓰기/첨부파일 첨부,삭제)
- 게시글 좋아요 기능
- 댓글 작성/수정
- 게시글 상세페이지(수정/삭제/CKEditor)
- 마이페이지(닉네임,비밀번호,이메일 변경/회원 탈퇴)
- 다국어 지원(한국어,일본어,영어)

## 테이블 구성

![Relational_1](https://user-images.githubusercontent.com/41267046/83415718-7f6bbb00-a45a-11ea-9131-3d371445cc56.png)

## 프로젝트 구현

![메인화면](https://user-images.githubusercontent.com/41267046/83415751-90b4c780-a45a-11ea-8c14-48cef20e101e.png)


메인 페이지입니다.  검색 기능와 게시글 페이징 기능을 구현하였습니다.

![다국어지원](https://user-images.githubusercontent.com/41267046/83415784-a0341080-a45a-11ea-9d08-95ae33ac8fe1.png)

SBoard는 한국어,영어,일본어를 지원하는 다국어 지원 게시판입니다.

![회원가입](https://user-images.githubusercontent.com/41267046/83415825-b5a93a80-a45a-11ea-9ba1-a613fe2a8742.png)

회원가입 페이지입니다. 실시간 Ajax 통신으로 입력 정보를 중복검사가 가능합니다.

<img width="506" alt="회원인증" src="https://user-images.githubusercontent.com/41267046/83415883-d07baf00-a45a-11ea-8371-a708409f6430.PNG">

회원가입을 하게되면 입력한 이메일로 메일인증 메일이 전송됩니다. 회원은 검증된 이메일로만 가입할 수 있습니다.

![게시글작성](https://user-images.githubusercontent.com/41267046/83415903-dec9cb00-a45a-11ea-99a7-4c45c9606b88.png)

게시글 등록화면입니다. 로그인 한 회원만 글을 작성할 수 있고, CKEditor를 적용하여 기존 Textarea의 한계를 극복하였습니다. 또한 첨부파일을 등록할 수 있습니다.

<img width="843" alt="좋아요" src="https://user-images.githubusercontent.com/41267046/83415946-eab58d00-a45a-11ea-81a7-0efa7cf2c1e6.PNG">

게시물에 좋아요 기능을 구현하였습니다. 좋아요 테이블은 게시판 테이블과 회원 테이블을 참조합니다.

<img width="906" alt="검색" src="https://user-images.githubusercontent.com/41267046/83415991-f7d27c00-a45a-11ea-89b8-5e6538f14b70.PNG">

게시물은 제목,내용,작성자 등 4가지 방법으로 검색할 수 있습니다.

<img width="895" alt="댓글" src="https://user-images.githubusercontent.com/41267046/83416042-09b41f00-a45b-11ea-82e4-904cc3c697e3.png">

REST방식과 Ajax를 사용한 새로고침 없이 댓글이 등록됩니다. 

<img width="906" alt="마이페이지" src="https://user-images.githubusercontent.com/41267046/83416070-15074a80-a45b-11ea-804d-99e41fe5ff28.PNG">

계정 정보 수정을 통해 닉네임,비밀번호를 변경할 수 있습니다.
