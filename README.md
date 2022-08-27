# WriteBookReview

> WriteBookReview https://apps.apple.com/kr/app/writebookreview/id1640264808

## 프로젝트 소개
- 간단하게 내가 읽은 책을 저장하고 독후감을 남길수 있는 어플입니다.
- 현재 참여중인 스터디에서, 한달동안 각자 간단한 앱을 구상하여 만든후 앱스토어에 출시 해보기로 하게 되었습니다.
- 앱 배포 경험이 가장 큰 목적이며, 추후 계속 기능을 추가하며 업데이트 할 예정입니다.

## 기술 스택
### Swift
- Swift 5
- UIKit
### 뷰 드로잉
- Code: Then, SnapKit
### 백엔드
- Local DB: CoreData
### 네트워킹
- Alamofire
### 개발 아키텍처 및 디자인 패턴
- MVC
### 이외에 사용한 오픈소스
- Kingfisher
## 기능
내가 읽었던 책들을 검색해서 찾은후, 책에 대한 리뷰를 남기고 책을 저장할 수 있는 독후감 어플입니다.

## 고민 & 구현 
#### 책 검색하기 기능
![검색_기능_AdobeExpress](https://user-images.githubusercontent.com/89637673/185831850-08b44941-3621-4d4b-b62f-6b9d341546f8.gif)  
등록할 책을 찾기위해 검색을 할 수 있습니다.  
네이버 검색 API중 책을 검색할수 있는 API를 활용하여 검색기능을 구현했습니다. 표시되는 책의 갯수는 최대 10개입니다.  
<details>
<summary>코드 보기</summary>
<div markdown="1">

#### 네이버 책 검색 API에 get으로 호출하여 데이터를 불러오는 함수입니다.
네트워킹 관련 동작이 비동기적으로 실행되기 때문에 데이터를 사용하는 cell등 여러 곳에서 데이터가 다 들어오기도 전에 앱이 실행되어 꺼지는 것을 방지하기 위해,  
escaping 클로저를 사용하여 데이터값을 보장받을수 있게 하였습니다.
```swift
func getUserSearchBookInformation(bookName: String, completion: @escaping (SearchResult) -> Void) {
        let baseUrl = "https://openapi.naver.com/v1/search/book.json?"
        
        let parameters: Parameters = [
            "query": "\(bookName)"]
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "idf3GPoDPvKowI7HsO3q",
            "X-Naver-Client-Secret": "mcVtbh9DrT"]
        
        AF.request(
            baseUrl,
            method: .get,
            parameters: parameters,
            headers: headers)
        .responseDecodable(of: SearchResult.self) { result in
            switch result.result {
            case .success(let success):
                completion(success)
                print("검색 성공")
            case .failure(let error):
                print(error)
                print("검색 실패")
            }
        }
    }
```

#### 검색을 하기 위해 키보드를 사용하게 되면 컨텐츠중 일부가 키보드에 가려져 보이지 않는 현상이 발생했습니다.  
이를 해결하기 위하여 NotificationCenter에 기본적으로 내장되어있는 keyboardWillShowNotification와 keyboardWillHideNotification의 시점을 이용해 해결하였습니다.  
처음에는 frame origin의 y값을 변경하여 뷰를 이동시켜서 구현하였으나, 이로 인해 기존에 키보드에 의해 가려지는 컨텐츠는 잘 보이나,  
최상단 이동한 y값 만큼의 컨텐츠가 또 보이지 않는 현상이 발생하였습니다.  
따라서 frame height 값을 키보드의 높이만큼 키우고 줄이는 방식을 사용해서 컨텐츠를 보두 화면에 보여주게 하고,  
키보드의 위치도 확보하는 방향으로 구현을 완료했습니다.
        
```swift
NotificationCenter.default.addObserver(self, selector: #selector(searchInProgress), name: UIResponder.keyboardWillShowNotification, object: nil)
NotificationCenter.default.addObserver(self, selector: #selector(endSearch), name: UIResponder.keyboardWillHideNotification, object: nil)  
```

키보드가 올라가고 내려갈때마다 view의 크기 조절
        
```swift
@objc func searchInProgress(noti: Notification) {
        guard let userInfo = noti.userInfo else {return}
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        self.view.frame.size.height -= keyboardFrame.height
    }
    @objc func endSearch(noti: Notification) {
        guard let userInfo = noti.userInfo else {return}
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        self.view.frame.size.height += keyboardFrame.height
    }
```
        
</div>
</details>

#### 책 등록 기능
![책_등록_기능_AdobeExpress](https://user-images.githubusercontent.com/89637673/185832278-8ca7be0d-cd87-4e52-b8d4-a8ab2f7afeed.gif)  
이 앱의 핵심 기능입니다. 해당 셀을 누를 경우 책을 등록할수 있는 페이지로 이동합니다. 책의 간단한 정보를 보여주고 리뷰를 남길수 있습니다.  
리뷰는 선택사항이며, 버튼을 누르게 되면 첫 화면으로 이동하면서 등록된 책이 화면에 표시됩니다.  

<details>
<summary>코드 보기</summary>
<div markdown="1">       
처음에 앱을 기획할때부터 첫 출시 버전은 최대한 담백하게 만들고, 그 이후에 기능을 계속 추가하는 방식으로 만들도록 기획했기때문에,  
데이터를 다루는 것들중 CoreData를 활용하여 구현했습니다.  
버튼을 누를경우 resignResponder()함수를 통해 키보드를 내리고, CoreData의 미리 만들어둔 entity에 접근하여 setValue를 통해 값을 저장합니다.  
filter함수를 통해 미리 저장되어있는 coreData의 데이터들과 현재 등록하는 책의 이름을 비교하여, 똑같은 책이름이 있을 경우 중복 등록을 방지합니다.  

```swift
@objc func addBookButtonTapped() {
        
        self.review.resignFirstResponder()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        do {
            let contact = try context.fetch(Book.fetchRequest()) as! [Book]
            let overlap = contact.filter { book in
                book.bookName?.description == self.bookName.text?.description
            }
            if overlap.count == 0 {
                let entity = NSEntityDescription.entity(forEntityName: "Book", in: context)
                if let entity = entity {
                    let book = NSManagedObject(entity: entity, insertInto: context)
                    book.setValue(bookName.text?.description, forKey: "bookName")
                    book.setValue(bookImageStrValue, forKey: "bookImage")
                    book.setValue(review.text, forKey: "bookReview")
                }
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
                guard let presentingViewController = self.presentingViewController as? UINavigationController else {return}
                dismiss(animated: true) {
                    print(presentingViewController)
                    presentingViewController.popToRootViewController(animated: true)
                }
            } else {
                print("이미 등록한 책입니다.")
                let sheet = UIAlertController(title: "알림", message: "이미 등록한 책입니다.", preferredStyle: .alert)
                sheet.addAction(UIAlertAction(title: "확인", style: .default, handler: { _ in
                    self.dismiss(animated: true)
                
                }))
                present(sheet, animated: true)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
```

![책_등록_중복_방지_AdobeExpress](https://user-images.githubusercontent.com/89637673/185832559-e82fbd00-dce1-4fc5-8315-fd0c4223359a.gif)  

</div>
</details>


## 프로젝트를 통해 배운 것
### 코드로 뷰 구현하기
평소에 스토리보드로만 뷰를 구성하다가 이번 프로젝트에서 코드로 뷰를 구성했습니다.
- 현재 앱의 수준을 생각했을때는 화면과 기능이 많지 않기 때문에 스토리보드로 편하게 작업이 가능했지만, 추후 앱에 기능이 추가됨때 따라 뷰를 재사용하는 이점을 활용하기 위해 코드로 뷰를 구성했습니다.  
#### Code Base
> 장점
- Xcode가 가벼워진다.
- 셀 재사용에 용이하다.
- UI 변동에 빠르게 대응할수 있음.
> 단점
- 스토리보드에 비해 화면을 한눈에 파악하기 어렵다.
- 어려운 러닝커브
#### Storyboard
> 장점
- Code base에 비해 화면을 파악하기 쉽다.
- 쉬운 러닝커브
> 단점
- Xcode가 상당히 무거워진다.(빌드 속도 down)
- 셀을 재사용할수 없다.
- 애니메이션, UI 변동에 빠르게 대응 하기 어렵다.

-> 앞으로는 Code Base로 뷰를 구성하게 될거 같지만, 두 방식의 장단점을 이해하고 상황에 맞추어 적절히 사용하는것이 좋을거 같습니다.
### CoreData 활용
등록된 책의 정보를 저장하기위해 CoreData를 활용하였습니다.
- 추후 앱의 기능들을 더 추가할 예정이고, 이에따른 다양한 Model을 활용해야 하기 때문에 CoreData를 활용하게 되었습니다.

