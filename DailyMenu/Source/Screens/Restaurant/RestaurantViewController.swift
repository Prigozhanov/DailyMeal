//
//  Created by Vladimir on 11/14/19.
//  Copyright © 2019 epam. All rights reserved.
//

import UIKit
import TableKit

final class RestaurantViewController: UIViewController {
    
    let cellId = "ItemCell"
    let headerId = "HeaderCell"
    let sectionHeaderId = "SectionHeader"
    
    private var viewModel: RestaurantViewModel
    
    private var collectionViewTopPoint: CGPoint = .zero
    private var userScrollInitiated = false
    
    private var statusBarStyle: UIStatusBarStyle
    
    private var navigationBarBackground = UIImageView(image: Images.restaurentImagePlaceholder.image)
    
    private lazy var navigationBarControls: UIView = {
        let view = UIView()
        let backButton = UIButton.makeBackButton(self)
        view.addSubview(backButton)
        backButton.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(44)
        }
        let notificationButton = UIButton.makeNotificationButton()
        view.addSubview(notificationButton)
        notificationButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.largeMargin)
            $0.size.equalTo(44)
        }
        
        let title = UILabel.makeNavigationTitle("Restaurant")
        title.textColor = Colors.white.color
        view.addSubview(title)
        title.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(notificationButton.snp.centerY)
        }
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionView.backgroundColor = Colors.commonBackground.color
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(CollectionHeaderCell.self, forCellWithReuseIdentifier: headerId)
        collectionView.register(FoodItemCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(SectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        
        collectionView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return collectionView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    init(viewModel: RestaurantViewModel) {
        self.viewModel = viewModel
        statusBarStyle = .lightContent
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        view.addSubview(navigationBarBackground)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        collectionView.backgroundColor = .clear
        
        view.addSubview(navigationBarControls)
        navigationBarControls.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(100)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionViewTopPoint = collectionView.contentOffset
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationBarBackground.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(150 + view.safeAreaInsets.top)
        }
        view.layoutIfNeeded()
        addGradeintToHeader()
    }
    
    private let gradientLayer = CAGradientLayer()
    private func addGradeintToHeader() {
        gradientLayer.removeFromSuperlayer()
        let colors = [Colors.black.color.cgColor, UIColor.clear.cgColor]
        let locations: [NSNumber] = [-0.4, 1]
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.frame = navigationBarBackground.frame
        navigationBarBackground.layer.addSublayer(gradientLayer)
    }
    
}

//MARK: -  RestaurantView
extension RestaurantViewController: RestaurantView {
    
}

//MARK: -  Private
private extension RestaurantViewController {
    
}

extension RestaurantViewController: UICollectionViewDelegate {
    
    
}

extension RestaurantViewController: UICollectionViewDataSource {
    var dummy: [String: Array<String>] {
        return [
            "Dummy section 1": Array<String>(repeating: "Burger", count: 5),
            "Dummy section 2": Array<String>(repeating: "Pastry", count: 3),
            "Dummy section 3": Array<String>(repeating: "Pizza", count: 2)
        ]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dummy.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dummy[Array(dummy.keys)[section - 1]]?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerId, for: indexPath) as! CollectionHeaderCell
            cell.configure(with: viewModel.restaurant)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FoodItemCell
            cell.configure(with: FoodItemCell.Item(title: "Pastry", description: "Portland ugh fashion axe Hel vetica, Echo Parketica, Echo Park", price: "15.00"))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section > 0 {
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath) as! SectionHeaderCell
            sectionHeader.configure(
                section: Array(dummy.keys)[indexPath.section - 1],
                itemsCount: dummy[Array(dummy.keys)[indexPath.section - 1]]?.count ?? 0
            )
            return sectionHeader
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section > 0 {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
        return .zero
    }
}

extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 160)
        } else {
            return CGSize(width: collectionView.frame.width, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension RestaurantViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        userScrollInitiated = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetYValue = scrollView.contentOffset.y
        let alphaValue = offsetYValue / (collectionViewTopPoint.y / 2)
        
        if userScrollInitiated, abs(collectionViewTopPoint.y) - offsetYValue > 0 {
            updateNavigationBarAppearance(alphaValue)
            updateStatusBarAppearance(alphaValue)
        }
       
    }
    
    private func updateNavigationBarAppearance(_ alpha: CGFloat) {
        navigationBarBackground.alpha = alpha
        navigationBarControls.alpha = alpha
        navigationBarControls.isHidden = alpha <= 0.3
    }
    
    private func updateStatusBarAppearance(_ alpha: CGFloat) {
        statusBarStyle = alpha <= 0.5 ? .default : .lightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
}
