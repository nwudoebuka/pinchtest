//
//  MainCoordinator.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
  var navigationController: UINavigationController?
  
  func eventOccured(with type: Event) {
      switch type {
      case .albumTapped(let albumID):
        let vc:PhotosViewController & Coordinating = PhotosViewController.instantiate()
        vc.coordinator = self
        vc.albumId = albumID
       navigationController?.pushViewController(vc, animated: true)
        break
      case .photoTapped(data: let data):
        let vc:PhotoDetailsViewController & Coordinating = PhotoDetailsViewController.instantiate()
        vc.coordinator = self
        vc.data = data
       navigationController?.pushViewController(vc, animated: true)
        break
      }
  }
  
  func start() {
    var vc:UIViewController & Coordinating = ViewController.instantiate()
      vc.coordinator = self
      navigationController?.setViewControllers([vc], animated: true)
  }
  
  
  
}

