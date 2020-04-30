//
//  Created by Vladimir on 3/1/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class OrderRouteDetailsView: UIView {
	
	struct Item {
		let restImageSrc: String
		let restTitle: String
		let restAddress: String
		let userImage: UIImage
		let userName: String
		let userAddress: String
	}
	
	private let item: Item
	
	// MARK: - RESTARURANT
	private lazy var restImageView: UIImageView = {
		let view = UIImageView()
		if let url = URL(string: item.restImageSrc) {
			view.kf.setImage(with: url)
		}
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	private lazy var restTitleLabel: UILabel = {
		let label = UILabel.makeSemiboldTitle(item.restTitle)
		return label
	}()
	
	lazy var restAddressLabel: UILabel = {
		let label = UILabel.makeExtraSmallText(item.restAddress)
		label.textColor = Colors.gray.color
		return label
	}()
	
	private var restDiscImageView = UIImageView(image: Images.Icons.disc.image)
	
	// MARK: - USER
	private lazy var userImageView: UIImageView = {
		let view = UIImageView(image: item.userImage)
		view.contentMode = .scaleAspectFit
		view.setRoundCorners(Layout.cornerRadius)
		return view
	}()
	
	private lazy var userTitleLabel: UILabel = {
		let label = UILabel.makeSemiboldTitle(item.userName)
		return label
	}()
	
	private lazy var userAddressLabel: UILabel = {
		let label = UILabel.makeExtraSmallText(item.userAddress)
		label.textColor = Colors.gray.color
		return label
	}()
	
	private var userPinImageView: UIImageView = {
		let view = UIImageView(image: Images.Icons.mapPin1.image)
		view.tintColor = Colors.blue.color
		view.contentMode = .scaleAspectFit
		return view
	}()
	
	init(item: Item) {
		self.item = item
		
		super.init(frame: .zero)
		
		addSubviews([
			restImageView,
			restTitleLabel,
			restDiscImageView,
			restAddressLabel,
			userImageView,
			userTitleLabel,
			userAddressLabel,
			userPinImageView
		])
		
		restImageView.snp.makeConstraints {
			$0.top.leading.equalToSuperview().inset(Layout.commonInset)
			$0.size.equalTo(50)
		}
		
		restTitleLabel.snp.makeConstraints {
			$0.top.equalTo(restImageView)
			$0.leading.equalTo(restImageView.snp.trailing).offset(Layout.largeMargin)
		}
		
		restDiscImageView.snp.makeConstraints {
			$0.bottom.equalTo(restImageView).inset(10)
			$0.size.equalTo(10)
			$0.leading.equalTo(restImageView.snp.trailing).offset(Layout.largeMargin)
		}
		
		restAddressLabel.snp.makeConstraints {
			$0.centerY.equalTo(restDiscImageView)
			$0.leading.equalTo(restDiscImageView.snp.trailing).offset(Layout.largeMargin)
		}
		
		userImageView.snp.makeConstraints {
			$0.top.equalTo(restImageView.snp.bottom).offset(30)
			$0.leading.equalTo(restImageView)
			$0.size.equalTo(50)
			$0.bottom.equalToSuperview().inset(Layout.commonInset)
		}
		
		userTitleLabel.snp.makeConstraints {
			$0.top.equalTo(userImageView)
			$0.leading.equalTo(userImageView.snp.trailing).offset(Layout.largeMargin)
		}
		
		userPinImageView.snp.makeConstraints {
			$0.bottom.equalTo(userImageView).inset(10)
			$0.width.equalTo(10)
			$0.leading.equalTo(userImageView.snp.trailing).offset(Layout.largeMargin)
		}
		
		userAddressLabel.snp.makeConstraints {
			$0.centerY.equalTo(userPinImageView)
			$0.leading.equalTo(userPinImageView.snp.trailing).offset(Layout.largeMargin)
		}
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		createDottedLine(
			from: CGPoint(x: restImageView.frame.midX, y: restImageView.frame.midY),
			to: CGPoint(x: userImageView.frame.midX, y: userImageView.frame.midY),
			width: 1,
			color: Colors.gray.color)
	}
	
}
