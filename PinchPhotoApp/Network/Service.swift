//
//  Service.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
protocol ServiceProtocol {
  func getAlbums() -> Observable<AlbumResponse>
  func getPhotos(_ id: Int,_ page: Int) -> Observable<PhotoResponse>
}
class Service:ServiceProtocol {
  
  
  func getPhotos(_ id: Int,_ page: Int) -> Observable<PhotoResponse> {
    return Observable.create { observer -> Disposable in
      let url = "\(BASE_URL)\(PORT)/photos?albumId=\(id)&_page=\(page)"
        debugPrint("photos url is \(url)")
        AF.request(url)
                 .validate()
                 .responseJSON { response in
                     switch response.result {
                     case .success:
                         guard let data = response.data else {
                             // if no error provided by alamofire return .notFound error instead.
                             // .notFound should never happen here?
                             observer.onError(response.error ?? NetworkError.notFound)
                             return
                         }
                         do {
                             let friends = try JSONDecoder().decode(PhotoResponse.self, from: data)
                           
                             observer.onNext(friends)
                         } catch {
                             observer.onError(error)
                         }
                     case .failure(let error):
                       debugPrint("error code is \(response.response?.statusCode)")
                         if let statusCode = response.response?.statusCode{
                             switch statusCode{
                             case 400...409:
                                 observer.onError(NetworkError.badRequestOrUnAuthorized)
                                 break
                             case 429:
                               observer.onError(NetworkError.limitError)
                             case 500...509:
                                 observer.onError(NetworkError.serverError)
                                 break
                             default:
                                 observer.onError(NetworkError.unKnown)
                                 break
                             }
                             
                         }
                         observer.onError(error)
                     }
             }
        return Disposables.create()
    }
  }
  
    
    func getAlbums()  -> Observable<AlbumResponse> {
            return Observable.create { observer -> Disposable in
              let url = "\(BASE_URL)\(PORT)/albums"
              debugPrint("search url is \(url)")
                AF.request(url)
                         .validate()
                         .responseJSON { response in
                             switch response.result {
                             case .success:
                                 guard let data = response.data else {
                                     // if no error provided by alamofire return .notFound error instead.
                                     // .notFound should never happen here?
                                     observer.onError(response.error ?? NetworkError.notFound)
                                     return
                                 }
                                 do {
                                     let albums = try JSONDecoder().decode(AlbumResponse.self, from: data)
                                     observer.onNext(albums)
                                 } catch {
                                     observer.onError(error)
                                 }
                             case .failure(let error):
                               debugPrint("error code is \(response.response?.statusCode)")
                                 if let statusCode = response.response?.statusCode{
                                     switch statusCode{
                                     case 400...409:
                                         observer.onError(NetworkError.badRequestOrUnAuthorized)
                                         break
                                     case 429:
                                       observer.onError(NetworkError.limitError)
                                     case 500...509:
                                         observer.onError(NetworkError.serverError)
                                         break
                                     default:
                                         observer.onError(NetworkError.unKnown)
                                         break
                                     }
                                     
                                 }
                                 observer.onError(error)
                             }
                     }
                return Disposables.create()
            }
        }
    }



