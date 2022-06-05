//
//  ViewModel.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import Foundation
import UIKit
import RxSwift

final class ViewModel: NSObject  {
  
    let disposeBag = DisposeBag()
    private var apiLoader: ServiceProtocol?
    var albums = PublishSubject<AlbumResponse>()
    var photos = PublishSubject<PhotoResponse>()
    required init(apiLoader: ServiceProtocol = Service()) {
        self.apiLoader = apiLoader
        super.init()
    }
    
    public func getAlbums() {
      apiLoader?.getAlbums().subscribe(
          onNext: { [weak self] albumResp in
              self?.albums.onNext(albumResp)
          },
          onError: { [weak self] error in
              self?.albums.onError(error)
          }
      )
      .disposed(by: disposeBag)
    }
    
    
  public func getPhotos(_ id: Int, _ page:Int) {
    apiLoader?.getPhotos(id,page).subscribe(
        onNext: { [weak self] photoResp in
            self?.photos.onNext(photoResp)
        },
        onError: { [weak self] error in
            self?.photos.onError(error)
        }
    )
    .disposed(by: disposeBag)
    }

}


