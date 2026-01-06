package com.fl.model;

public class NoticeDTO {
    // 1. 필수 컬럼 (DB 테이블과 매칭)
    private long num;           // 게시글 번호 (PK)
    private String userId;      // 작성자 아이디
    private String userName;    // 작성자 이름
    private String title;       // 제목
    private String content;     // 내용
    private String regDate;     // 등록일 (화면 표시용 String 권장)
    private int hitCount;       // 조회수
    private int notice;         // 공지 여부 (1: 필독/상단고정, 0: 일반)

    // 2. 첨부파일용 (나중에 쓸 수 있으니 미리 넣어둠)
    private String saveFilename;      // 서버 저장 파일명
    private String originalFilename;  // 원본 파일명

    // 3. 부가 기능 (글 리스트에서 'New' 띄우기 등)
    private long gap; // 글 등록 후 흐른 시간(초 or 분)

    // --- Getter & Setter ---
    
    public long getNum() {
        return num;
    }
    public void setNum(long num) {
        this.num = num;
    }
    public String getUserId() {
        return userId;
    }
    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getUserName() {
        return userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
    public String getRegDate() {
        return regDate;
    }
    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }
    public int getHitCount() {
        return hitCount;
    }
    public void setHitCount(int hitCount) {
        this.hitCount = hitCount;
    }
    public int getNotice() {
        return notice;
    }
    public void setNotice(int notice) {
        this.notice = notice;
    }
    public String getSaveFilename() {
        return saveFilename;
    }
    public void setSaveFilename(String saveFilename) {
        this.saveFilename = saveFilename;
    }
    public String getOriginalFilename() {
        return originalFilename;
    }
    public void setOriginalFilename(String originalFilename) {
        this.originalFilename = originalFilename;
    }
    public long getGap() {
        return gap;
    }
    public void setGap(long gap) {
        this.gap = gap;
    }
}