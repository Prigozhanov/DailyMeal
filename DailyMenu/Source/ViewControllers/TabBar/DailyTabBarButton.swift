//
//  Created by Vladimir on 2/28/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class DailyTabBarButton: UIView {
	
	struct Item {
		let title: String?
		let image: UIImage?
		let highlightedImage: UIImage?
		let didSelect: VoidClosure
	}
	
	let item: Item
	
	static let buttonWidth = 100
	
	private lazy var imageView: UIImageView = {
		let view = UIImageView(
			image: item.image,
			highlightedImage: item.highlightedImage
		)
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel.makeText(item.title)
		label.highlightedTextColor = Colors.blue.color
		label.textColor = Colors.white.color
		return label
	}()
	
	init(item: Item) {
		self.item = item
		
		super.init(frame: .zero)
		
		addSubviews([imageView, titleLabel])
		
		imageView.snp.makeConstraints {
			$0.top.equalToSuperview()
			$0.centerX.equalToSuperview()
			$0.size.equalTo(25)
		}
		
		titleLabel.snp.makeConstraints {
			$0.top.equalTo(imageView.snp.bottom).offset(10)
			$0.centerX.equalTo(imageView)
			$0.bottom.equalToSuperview()
		}
		
		snp.makeConstraints {
			$0.width.equalTo(100)
		}
		addGestureRecognizer(BlockTap(action: { [weak self] _ in
			self?.item.didSelect()
		}))
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	func setSelected(_ selected: Bool) {
		imageView.isHighlighted = selected
	}
	
	func setBadgeVisible(_ visible: Bool) {
		visible ? imageView.addBadge(color: Colors.badgeRed.color) : imageView.removeBadge()
	}
	
}
