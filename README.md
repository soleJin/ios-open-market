## **우리 팀만의 규칙 [1조 - 밤, 솔]**

- 디스코드에 있을 때는 언제든지 편하게 연락
- 매일 TIL 쓰기 (짧아도 괜찮아요🙂)

## **스크럼**

- 스크럼 시간은 매일 오전 11시
- 나눌 내용
    - 컨디션 공유
    - 어제 공부한 내용 공유
    - 오늘 공부할 내용 공유
    - 서로의 TIL에서 궁금한 사항 / 이슈 사항 공유

## **프로젝트**

- Branch
    - '1-sole' branch에는 최종 제출할 내용을 PR 보내고 머지는 상대방이.
    - 'step1-sole-feat', 'step1-bam-fix' branch 에서 작업 후 해당 branch를 깃헙에 푸쉬.
    - 'stepn' branch에 각자 브렌치에서 작업한 내용을 머지. (step1-sole-feat -> step1 머지)
    - 'stepn' 에 있는 상대방의 작업 내용을 로컬에서 pull하고 자신의 브렌치로 머지. (step1 -> step1-bam-feat 머지)
- 커밋메세지 규칙
    - 커밋단위 :  빌드되는 상태에서, 기능단위로 커밋하기.
    - "<Type>: <Contents>"
    - Type 규칙
        - feat: 기능구현
        - refactor: 기능수정
        - fix: 버그 수정
        - style: 동작에 영향없는 코드변경, 이름변경
        - test: 테스트 추가, 테스트 리팩토링
        - docs: 문서수정
    - 코딩 컨벤션
        - Swift API 디자인 가이드라인을 준수하기.
        - naming에 신경쓰기.
        - 문서화 주석(///)은 기능을 이해하기 힘든 함수만 작성. (단축키: Command + Option + /).
        - 의미없는 띄어쓰기 안하도록 주의하기.
- 기능 분리 잘 되도록 주의하기. (1 함수 1 기능 지향)
