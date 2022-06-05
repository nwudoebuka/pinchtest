//
//  ViewController.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 03/06/2022.
//

import UIKit
import RxSwift
import CoreData

class ViewController: BaseViewController,Storyboarded,Coordinating {
  var coordinator: Coordinator?
  let viewModel = ViewModel()
  let disposeBag = DisposeBag()
//  var tableData:[AlbumResponseItem]?
  var albums: [NSManagedObject] = []
  @IBOutlet weak var tableV:UITableView?
  let refreshControl = UIRefreshControl()
  override func viewDidLoad() {
    super.viewDidLoad()
    tableV?.tableFooterView = UIView()
    navigationController?.navigationBar.topItem?.title = "Albums"
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
       refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    tableV?.addSubview(refreshControl) // not required when using UITableViewController
    addObservers()
    getSavedAlbums()
    getAlbums()
   
  }
  
  func save(id: String,name: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "PhotoItem", in: managedContext)!
    let album = NSManagedObject(entity: entity, insertInto: managedContext)
    album.setValue(name, forKeyPath: "name")
    album.setValue(id, forKeyPath: "id")
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PhotoItem")

    do {
      let allSavedData = try managedContext.fetch(fetchRequest)
      
        try managedContext.save()
    
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
  }

  func getSavedAlbums(){
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PhotoItem")

    do {
      albums = try managedContext.fetch(fetchRequest)
      self.loadTable()
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
    debugPrint("saved album is \(albums)")
  }
  
  
  private func getAlbums(){
    viewModel.getAlbums()
  }
  

  
  @objc func refresh(_ sender: AnyObject) {
    
    getAlbums()
  }

  func addObservers(){
    viewModel.albums.subscribe(
      onNext: { [weak self] albumResp in
      debugPrint("album resp on view is \(albumResp)")
        
          if albumResp.count > 0{
            // delete everything from coredate
            self?.clearEntity("PhotoItem")
            for dto in albumResp{
              
              self?.save(id: String(dto.id), name: dto.title)
            }
            
          }
        self?.getSavedAlbums()
      
      },
      onError: { [weak self] error in
        self?.refreshControl.endRefreshing()
        if let err = error as? NetworkError{
          self?.showMessage("Failed", err.rawValue)
        }else{
          self?.showMessage("Failed", error.localizedDescription)
        }
     
      }
    ).disposed(by: disposeBag)
   
  }
  
  private func loadTable(){
    self.refreshControl.endRefreshing()
    self.tableV?.reloadData()
  }
  
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return albums.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as! AlbumTableViewCell
    cell.configure(data: albums[indexPath.row], position: indexPath.row + 1)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let id = Int(albums[indexPath.row].value(forKey: "id") as! String) else{
      return
    }
    coordinator?.eventOccured(with: .albumTapped(albumID: id))
  }
  
  
}
