<img src= "클러치 스냅샷.png" align="left" >

# 클러치

> 핵심 기능
> 
- CODEF API를 활용해 부동산 물건에 대한 공시지가 확인 기능 구현
- Oauth2.0 기반 소셜로그인 기능 구현
- JWT 토큰 기반 회원인증 기능 구현
- Multipart 기반 이미지 업로더 구현
- Alamofire기반 REST API 네트워크 통신 기능 구현

---

> 기술 스택
> 
- **언어**: Swift
- **프레임워크**: UIkit
- **디자인패턴**: MVC + Singleton
- **라이브러리**: Alamofire, SwiftyJson, SnapKit, Gifu, IQKeyboardManager

---

> 적용한 CS 지식
> 
- 컴퓨터네트워크: REST API의 개념

---

> 서비스
> 
- **최소 버전**: iOS 13.0
- **개발 인원**: 3인
- **개발 기간** : 2023.06.31 ~ 2022.08.26
- **협업**: Git, Figma

---

> 트러블 슈팅
> 
1. **이미지 용량 최적화**

**Issue**

- 이미지 업로드 시 용량을 최적화해 서버 비용 절감

**Solution**

- `jpegData(compressionQuality: CGFloat)` 메서드를 활용해, `jpeg` 확장자로 변환
- 이때, `compressionQuality` 파라미터를 통해 압축률을 지정(0.0 ~ 1.0)

**Result**

- PNG 양식 대비 **4배 이하**의 용량 압축 성공

```swift
AF.upload(multipartFormData: { (multipart) in
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
		                 multipart.append(jsonData, withName: "requestDto", mimeType: "application/json")
						}
        }
        for (index, image) in images.enumerated()  {
            let imageData = image.jpegData(compressionQuality: 0.7)!
            multipart.append(imageData, withName: "img", fileName: "\(userName)_\(index).jpg", mimeType: "image/jpeg")
        }
    }, to: url, method: .post, headers: headers).validate().responseJSON { response in ...
```

2. **UserDefaults**를 활용한 **로그인 cache** 관리

**Issue**

- ****UserDefaults****없이 JWT token을 관리할 경우, **앱을 재실행하면 다시 로그인을 해야하는 문제 발생**

**Solution**

- **로그인 cache**를 관리하는 싱글톤 클래스를 생성

**Result**

```swift
class LoginUserCache {
    static let shared = LoginUserCache()
    private init () {}
    private let loginKey = "userToken"
    
    func check() -> String? {
        if let userHash = UserDefaults.standard.object(forKey: loginKey) as? String {
            return userHash
        }
        return nil
    }
    
    func store(token: String){
        UserDefaults.standard.set(store, forKey: loginKey)
    }
    
    func logout(){
        UserDefaults.standard.removeObject(forKey: loginKey)
    }
}
```

---

> 회고
> 

**What I Learned**

- 기획, 모바일, 서버, 디자인 파트와 협업 경험
- REST API 환경에서 네트워크 통신 작업
- 소셜 로그인 기반 회원 인증 경험
- Custom Alert, TextFields 등의 CustomUI 제작 경험

**Areas for Improvement**

- 네트워크 예외 처리
- 여러 파트와 협업 과정에서 다소 의사 소통 이슈가 있었음

이번 프로젝트에서 가장 어려웠던 점은 **협업**이었다. 우선 iOS 파트 내에서 각자의 실력이 모두 달랐고 작성하는 코드 스타일 등의 차이도 있었다. 주 1회 주기로 브랜치를 머지해서 main 브랜치를 관리하려고 했으나 솔직히 잘 지켜지지 않았다. `git - flow`와 같은 브랜치 관리전략의 중요성을 체감했다. 

다음으로 서버, 디자인 파트와의 소통이었다. 가장 기억에 남는 에피소드는 이미지 업로드 기능 구현이었는데, 모바일 파트에서 아무리 봐도 코드에는 이상이 없어 보였다. 에러코드, 파라미터 등 하나 하나 모든 요소들을 꼼꼼하게 고려했다. 그럼에도, 통신이 정상적으로 처리되지 않았는데 알고보니 서버 파트에서 비용 때문에 일정 용량 이상의 파일이 업로드 되면 요청을 취소하도록 처리했었다. 이런 형태의 의사 소통 이슈가 몇가지 있었다. 

한편으로 가끔 디자이너가 기술적으로 불가능해 보이는 GUI를 제작해오면, 최대한 수용할 수 있는 요소들은 수용하되 불가능한 이유를 간곡하게 설득했다. 또한 초반에 디자인 시스템을 조금이라도 잡고 갔더라면 더욱 효율적으로 제작할 수 있었지 않았을까 하는 아쉬움도 있었다.  

> 📒 커밋 메시지 형식
> 

| 유형 | 설명 | 예시 |
| --- | --- | --- |
| FIX | 버그 또는 오류 해결 | [FIX] #10 - 콜백 오류 수정 |
| ADD | 새로운 코드, 라이브러리, 뷰, 또는 액티비티 추가 | [ADD] #11 - LoginActivity 추가 |
| FEAT | 새로운 기능 구현 | [FEAT] #11 - Google 로그인 추가 |
| DEL | 불필요한 코드 삭제 | [DEL] #12 - 불필요한 패키지 삭제 |
| REMOVE | 파일 삭제 | [REMOVE] #12 - 중복 파일 삭제 |
| REFACTOR | 내부 로직은 변경하지 않고 코드 개선 (세미콜론, 줄바꿈 포함) | [REFACTOR] #15 - MVP 아키텍처를 MVVM으로 변경 |
| CHORE | 그 외의 작업 (버전 코드 수정, 패키지 구조 변경, 파일 이동 등) | [CHORE] #20 - 불필요한 패키지 삭제 |
| DESIGN | 화면 디자인 수정 | [DESIGN] #30 - iPhone 12 레이아웃 조정 |
| COMMENT | 필요한 주석 추가 또는 변경 | [COMMENT] #30 - 메인 뷰컨 주석 추가 |
| DOCS | README 또는 위키 등 문서 내용 추가 또는 변경 | [DOCS] #30 - README 내용 추가 |
| TEST | 테스트 코드 추가 | [TEST] #30 - 로그인 토큰 테스트 코드 추가 |
