# Memo+ <img src = "https://user-images.githubusercontent.com/61109660/188441235-7eee6800-160d-4fdd-b2fe-53c810baf97a.png" align=left width = 100>

> iPhone 기본 메모 앱 따라잡기

<br />

> 과제 기한 = 1차 개발) 22.08.31 - 22.09.05  
> (리팩토링 진행 예정)


<br />

## 느낀 점

> (Coming Soon)

<br />

## 📌 적용해보고자 했던 것
- Project Management · Scheduling
  - GitHub Projects, iteration rule를 활용해서 작업 전 공수 산정을 해보는 경험을 했고, 일정 관리를 체계적으로 해보려고 시도했습니다.

- Git-Flow
  - `issue - branch - pull request`의 흐름을 통해 git flow를 연습했습니다.
  - develop branch가 default가 되고, issue에 해당하는 branch를 만들어 작업을 진행했습니다.
  - 작업을 마친 브랜치는 pull request를 날리고 develop branch에 merge합니다.
    ```
    main - 현재는 main branch가 default branch가 되어 있습니다.
    develop(default)
    feature/#issue_number
    ```
  
- Code Convention
  - SwiftLint를 이용해서 코드 컨벤션 통일하고자 했고, 뷰와 로직을 짜는데 더 집중할 수 있었습니다.
  - Danger를 이용한 코드 검토 작업 자동화를 해보려고 했고, 컨벤션에 대한 더블 체킹을 할 수 있었습니다.

- Light/Dark Mode
  - 라이트모드와 다크모드를 대응할 수 있도록 해보았습니다.
  - 시스템 컬러와 커스텀 컬러 셋을 이용했습니다.

- Design Pattern
  - Repository Pattern을 이용해서 RealmManager를 구현했고, DB 관련 작업을 추상화된 인터페이스를 통해서 할 수 있도록 했습니다.
  - Factory Pattern을 이용해서 내부 구현에 대해서는 모르도록 하고, 컬러셋을 사용하는 것에만 집중하도록 해보았습니다.
  
- MVVM Architecture
  - 비즈니스 로직을 ViewModel로 분리해보려고 했습니다.
  - Observable Helper 클래스를 구현하여 Data와 View의 Binding을 구현했습니다.

- DataBase Control using Realm
  - Local DataBase인 Realm을 이용해서 DataBase 컨트롤을 해보려고 노력했습니다.
  - CRUD의 전반적인 기능을 구현해보았습니다.
  
- Modulization using Local Framework
  - Framework를 만들어서 역할별로 모듈화를 해보았습니다.
