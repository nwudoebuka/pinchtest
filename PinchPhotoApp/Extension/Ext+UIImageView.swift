//
//  Ext+UIImageView.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
  func setImage(with urlString: String, placeholder: Bool = false){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        
        if placeholder{
            self.kf.setImage(with: resource, placeholder:  #imageLiteral(resourceName: "img_placeholder"))
        }else{
            self.kf.setImage(with: resource)
            kf.indicatorType = .activity
        }
        
    }
}
