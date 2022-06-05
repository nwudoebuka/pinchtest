//
//  Storyboarded.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import Foundation
import UIKit

protocol Storyboarded {
  static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
  
  static func instantiate() -> Self{
    let id = String(describing: self)
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    //Storyboard IDs must Match ViewController names
    return storyboard.instantiateViewController(withIdentifier: id) as! Self
  }
  
}
