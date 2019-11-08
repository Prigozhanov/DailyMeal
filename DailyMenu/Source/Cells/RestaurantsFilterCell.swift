//  Created by Vladimir on 11/8/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit

class RestaurantsFilterCell: UICollectionViewCell {
  
  private var filterView: UIView!
  private var filterNameLabel: UILabel!
  
  override var isSelected: Bool {
    didSet {
      print("is selected: \(self.isSelected)")
      setSelected(isSelected)
    }
  }
  
  func configureCellWith(image: UIImage, title: String) {
    filterView = UIView()
    addSubview(filterView)
    filterView.snp.makeConstraints { $0.edges.equalToSuperview() }
    filterView.backgroundColor = Colors.white.color
    filterView.setRoundCorners(10)
    filterView.setShadow(offset: CGSize(width: 0, height: 4.0), opacity: 0.03, radius: 5)
    
    let imageView = UIImageView(image: image)
    filterView.addSubview(imageView)
    imageView.snp.makeConstraints {
        $0.leading.equalTo(Layout.largeMargin)
        $0.top.equalTo(Layout.largeMargin)
        $0.bottom.equalTo(-Layout.largeMargin)
        $0.width.equalTo(50)
    }
    imageView.contentMode = .scaleAspectFit
    
    filterNameLabel = UILabel.makeSmallText(title)
    filterView.addSubview(filterNameLabel)
    filterNameLabel.snp.makeConstraints {
        $0.leading.equalTo(imageView.snp.trailing).offset(Layout.commonMargin)
        $0.top.equalTo(Layout.largeMargin)
        $0.trailing.equalTo(-Layout.largeMargin)
    }
    
    let restaurantCountLabel = UILabel.makeSmallText("{count} Restaurants")
    filterView.addSubview(restaurantCountLabel)
    restaurantCountLabel.snp.makeConstraints {
        $0.leading.equalTo(imageView.snp.trailing).offset(Layout.commonMargin)
        $0.bottom.equalTo(imageView.snp.bottom)
        $0.trailing.equalTo(-Layout.largeMargin)
    }
    restaurantCountLabel.textColor = Colors.gray.color
    restaurantCountLabel.font = UIFont.systemFont(ofSize: 10)

    backgroundColor = Colors.lightGray.color
    
    setSelected(isSelected)
  }
  
  var borderView: UIView?
  func setSelected(_ selected: Bool) {
    borderView?.removeFromSuperview()
    if selected {
      borderView = UIView()
      addSubview(borderView!)
      borderView?.snp.makeConstraints { $0.edges.equalToSuperview() }
      borderView?.setRoundCorners(filterView.layer.cornerRadius)
      borderView?.setBorder(width: 1, color: Colors.blue.color.cgColor)
      
      setFocused(true)
      
      filterNameLabel.textColor = Colors.blue.color
    } else {
      borderView?.removeFromSuperview()
      borderView = nil
      filterNameLabel.textColor = Colors.black.color
    }
  }
  
  func setFocused(_ focused: Bool) {
    filterView.alpha = focused ? 1 : 0.5
  }
  
}
