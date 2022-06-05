//
//  AlbumTableViewCell.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import UIKit
import CoreData

class AlbumTableViewCell: UITableViewCell {
    static let identifier = "AlbumTableViewCell"
  @IBOutlet weak var nameLabel:UILabel?
  @IBOutlet weak var numberLbl:UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      let selectionView = UIView()
      selectionView.backgroundColor = UIColor.clear
      selectedBackgroundView = selectionView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  func configure(data: NSManagedObject,position: Int){
    nameLabel?.text = data.value(forKeyPath: "name") as? String
    numberLbl?.text = String(position)
  }

}
