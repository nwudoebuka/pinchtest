//
//  PhotosTableViewCell.swift
//  PinchPhotoApp
//
//  Created by WEMABANK on 04/06/2022.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    static let identifier = "PhotosTableViewCell"
  @IBOutlet weak var img:UIImageView?
  @IBOutlet weak var titleLabel:UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      let selectionView = UIView()
      selectionView.backgroundColor = UIColor.clear
      selectedBackgroundView = selectionView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
  
  func configure(_ data: PhotoResponseElement){
    titleLabel?.text = data.title
    img?.setImage(with: data.thumbnailURL)
  }
  
}
