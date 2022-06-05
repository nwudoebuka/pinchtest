//
//  Coordinator.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import Foundation
import UIKit
enum Event {
  case albumTapped(albumID:Int)
  case photoTapped(data:PhotoResponseElement)
}

protocol Coordinator {
    var navigationController:UINavigationController? {get set}
    func eventOccured(with type:Event)
    func start()
}

protocol Coordinating{
    var coordinator:Coordinator?{get set}
}
