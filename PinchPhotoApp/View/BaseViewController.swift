//
//  BaseViewController.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import UIKit
import CoreData

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  func showMessage(_ title:String,_ msg:String){
      let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)

      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        }))

      present(alert, animated: true, completion: nil)
  }
  
  func clearEntity(_ entity:String){
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }
    let managedContext = appDelegate.persistentContainer.viewContext
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

    do {
        try managedContext.execute(deleteRequest)
    } catch let error as NSError {
        // TODO: handle the error
    }
  }
}
