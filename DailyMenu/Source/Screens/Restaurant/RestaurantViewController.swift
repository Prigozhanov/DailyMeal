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
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return collectionView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    init(viewModel: RestaurantViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        
        view.backgroundColor = Colors.commonBackground.color
        
        view.addSubview(navigationBarBackground)
        view.addSubview(navigationBarControls)
        navigationBarControls.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(100)
        }
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(navigationBarControls.snp.bottom)
        }
        collectionView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    private func addGradeintToHeader() {
        let gradientLayer = CAGradientLayer()
        let colors = [Colors.black.color.cgColor, UIColor.clear.cgColor]
        let locations: [NSNumber] = [-2, 1]
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
    var dummy: [String] {
        return [
            "WAWA",
            "WAWA",
            "WAWA",
            "WAWA",
            "WAWA",
            "WAWA"
        ]
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dummy.count
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
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeaderId, for: indexPath)
            
            let label = UILabel.makeLargeText("Section 1")
            sectionHeader.addSubview(label)
            label.font = FontFamily.Poppins.semiBold.font(size: 22)
            label.snp.makeConstraints {
                $0.top.bottom.equalToSuperview().inset(Layout.largeMargin)
                $0.leading.equalTo(Layout.largeMargin * 2)
            }
            
            let itemsCount = UILabel.makeSmallText("\(dummy.count) items")
            sectionHeader.addSubview(itemsCount)
            itemsCount.snp.makeConstraints {
                $0.centerY.equalTo(label.snp.centerY)
                $0.leading.equalTo(label.snp.trailing).offset(Layout.largeMargin)
            }
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
