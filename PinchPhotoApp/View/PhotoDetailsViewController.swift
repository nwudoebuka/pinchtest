//
//  PhotoDetailsViewController.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import UIKit

class PhotoDetailsViewController: BaseViewController,Storyboarded,Coordinating,UIScrollViewDelegate  {
  var coordinator: Coordinator?
  var data: PhotoResponseElement?
  @IBOutlet weak var scrolView: UIScrollView?
  @IBOutlet weak var titleLabel: UILabel?
  @IBOutlet weak var img: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
      scrolView?.delegate = self
      scrolView?.minimumZoomScale = 1.0
      scrolView?.maximumZoomScale = 1.05
      if let dto = data{
        img?.setImage(with: dto.thumbnailURL)
        titleLabel?.text = dto.title
      }
     
    }
    
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return img
  }

}
