//
//  Created by Vladimir on 2/7/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit

class PhoneVerifiedViewController: UIViewController {

	private lazy var exploreButton = ActionButton(Localizable.PhoneVerification.explore) { _ in
        NotificationCenter.default.post(Notification(name: .userSignedUp))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.commonBackground.color
        
        let imagePlaceholder = UIImageView(image: Images.Placeholders.phoneVerified.image)
        imagePlaceholder.contentMode = .scaleAspectFit
        
		let titleLabel = UILabel.makeText(Localizable.PhoneVerification.phoneVerified)
        titleLabel.font = FontFamily.Poppins.semiBold.font(size: 18)
        titleLabel.numberOfLines = 2
        
        let subtitleLabel = UILabel.makeText(Localizable.PhoneVerification.phoneVerifiedSubtitle)
        subtitleLabel.font = FontFamily.Poppins.regular.font(size: 12)
        subtitleLabel.numberOfLines = 3
        subtitleLabel.textColor = Colors.gray.color
        
        view.addSubviews([imagePlaceholder, titleLabel, subtitleLabel, exploreButton])
        
        imagePlaceholder.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(50)
			$0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide)
			$0.height.lessThanOrEqualTo(200)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imagePlaceholder.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(imagePlaceholder)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(imagePlaceholder)
        }
        
        exploreButton.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(100)
            $0.leading.trailing.equalTo(imagePlaceholder)
            $0.height.equalTo(50)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
    }
	
}
