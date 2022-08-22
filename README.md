# WriteBookReview

## 프로젝트 소개
- 우연히 iOS 개발을 하시는 현직자분에게 멘토링을 받을 수 있는 좋은 기회가 생겨 iOS study에 참여하게 되었고, 한달동안 각자 간단한 앱을 구상하여 만든후 앱스토어에 출시 해보기로 하게 되었다.
- 간단하게 내가 읽은 책을 저장하고 독후감을 남길수 있는 어플
- 앱 배포 경험이 가장 큰 목적

## 사용한 기술 & 라이브러리
- snapKit, kingFisher, Alamofire, coredata, then
## 기능
내가 읽었던 책들을 검색해서 찾은후, 책에 대한 리뷰를 남기고 책을 저장할 수 있는 독후감 어플이다.
- 네이버 API를 활용하여 내가 읽었던 책을 검색하여 찾을 수 있다.
- 사용자가 똑같은 책을 중복해서 저장하려고 할 경우, 알림창이 뜨면서 중복으로 저장되는 것을 방지한다.
- coredata를 활용하여 사용자의 읽은 책을 저장한다.

## 프로젝트를 통해 배운 것

#### 코드로 뷰 구현하기
- 기존에는 스토리보드를 활용하여 화면을 구성했으나, 이 프로젝트에서 처음으로 코드로 뷰를 전부 짜 보았다. 처음에 막연하게 코드로 뷰를 짜는것이 매우 생소하고 삽질을 많이 했다. 하지만 앱을 완성하고 나서는 코드로 뷰를 짜는것에 대한 거부감도 많이 사라졌다. 코드로 뷰를 만들어서 사용해보니, 기존의 스토리보드가 가지고 있던 가장 큰 단점인 뷰를 재사용하는 부분에서 확실한 차이를 느낄수 있었다. 프로젝트 규모가 커지고 앱을 유지보수하는 측면에서 코드로 뷰를 짜는것이 훨씬더 효율적으로 앱을 만들수 있을거 같다.
#### CoreData  
- 핵심 기능을 구현하기 위해 유저의 정보를 저장하는 coredata를 활용해보았다. 간단하게 유저의 정보를 저장하는 UserDefault를 사용할수도 있었지만, 앱을 계속 유지보수하면서 앱의 규모를 키울 생각이 있었기에 좀더 복잡한 데이터를 처리할때 사용하는 CoreData를 활용하였다. FireBase를 사용하여 기능을 구현할수도 있었지만, 처음에 앱을 최대한 담백하게 만들고 그 이후에 유지보수하는 방향성으로 앱을 제작하기로 했었기 때문에 CoreData를 활용하였다.
## 구현영상

#### 책 검색하기 기능
![검색_기능_AdobeExpress](https://user-images.githubusercontent.com/89637673/185831850-08b44941-3621-4d4b-b62f-6b9d341546f8.gif)  
등록할 책을 찾기위해 검색을 할 수 있습니다.  
네이버 검색 API중 책을 검색할수 있는 API를 활용하여 검색기능을 구현했습니다. 표시되는 책의 갯수는 최대 10개입니다.  
<details>
<summary>코드 /summary>
<div markdown="1">

#### 네이버 책 검색 API에 get으로 호출하여 데이터를 불러오는 함수입니다.
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

</div>
</details>

#### 책 등록 기능
![책_등록_기능_AdobeExpress](https://user-images.githubusercontent.com/89637673/185832278-8ca7be0d-cd87-4e52-b8d4-a8ab2f7afeed.gif)  
이 앱의 핵심 기능입니다. 해당 셀을 누를 경우 책을 등록할수 있는 페이지로 이동합니다. 책의 간단한 정보를 보여주고 리뷰를 남길수 있습니다.  
리뷰는 선택사항이며, 버튼을 누르게 되면 첫 화면으로 이동하면서 등록된 책이 화면에 표시됩니다.  
#### 중복된 책 등록 방지 기능
![책_등록_중복_방지_AdobeExpress](https://user-images.githubusercontent.com/89637673/185832559-e82fbd00-dce1-4fc5-8315-fd0c4223359a.gif)  
이미 등록되어있는 책을 등록하려고 할 경우 등록이 되지 않습니다.

