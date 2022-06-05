//
//  PhotosViewController.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import UIKit
import RxSwift

class PhotosViewController: BaseViewController,Storyboarded,Coordinating {
  var coordinator: Coordinator?
  var albumId:Int?
  var isLoading = true
  @IBOutlet weak var tableV: UITableView?
  let viewModel = ViewModel()
  let disposeBag = DisposeBag()
  var tableData:[PhotoResponseElement]?
  let refreshControl = UIRefreshControl()
  var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
      tableV?.tableFooterView = UIView()
      refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
         refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
      tableV?.addSubview(refreshControl) // not required when using UITableViewController
      addObservers()
      guard let id = albumId else{
        return
      }
      getPhotos(id,1)
     
    }
    
  private func getPhotos(_ id:Int,_ page:Int){
    viewModel.getPhotos(id, page)
  }
  
  @objc func refresh(_ sender: AnyObject) {
    guard let id = albumId else{
      return
    }
    getPhotos(id,currentPage)
  }

  func addObservers(){
    viewModel.photos.subscribe(
      onNext: { [weak self] photosResp in
        if self?.tableData == nil{
          self?.tableData = photosResp
        }else{
        self?.tableData! += photosResp
        }
        self?.isLoading = false
        self?.tableV?.tableFooterView = nil
        self?.refreshControl.endRefreshing()
        self?.tableV?.reloadData()
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

}

extension PhotosViewController: UITableViewDelegate,UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
    cell.configure((tableData?[indexPath.row])!)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    coordinator?.eventOccured(with: .photoTapped(data: (tableData?[indexPath.row])!))
  }
  
  func createFooterSpinner()->UIView{
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
    let spinner = UIActivityIndicatorView()
    spinner.style = .large
    spinner.startAnimating()
    spinner.center = footerView.center
    footerView.addSubview(spinner)
    spinner.startAnimating()
    return footerView
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let position = scrollView.contentOffset.y
   
    if position > ((tableV?.contentSize.height)! - scrollView.frame.size.height){
     
      if !isLoading{
        isLoading = true
        self.tableV?.tableFooterView = createFooterSpinner()
              guard let id = albumId else{
                return
              }
              currentPage = currentPage + 1
              getPhotos(id,currentPage)
      }
     
     
     

    }
  }
  
}
