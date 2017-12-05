//
//  PLPageMenuContentViewCell.swift
//  HealthToAllFlesh
//
//  Created by Paul Lee on 16/03/2017.
//  Copyright © 2017 Paul Lee. All rights reserved.
//

import UIKit
import Reusable
extension PLPageMenuContentViewCell: Reusable {}
class PLPageMenuContentViewCell: UICollectionViewCell {
  var debuglabel: UILabel = {
    let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    let label = UILabel(frame: frame)
    return label
  }()

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(debuglabel)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    if contentView.subviews.count > 0 {
      contentView.subviews.forEach { $0.removeFromSuperview() }
    }
  }
}
