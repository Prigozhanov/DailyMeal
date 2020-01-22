//
//  Created by Vladimir on 1/21/20.
//  Copyright © 2020 epam. All rights reserved.
//

import UIKit
import AloeStackView
import CollectionKit

class CartItemView: UIView {
    
    private var onRemoveItem: (CartItemView) -> ()
    private var onChangeCount: IntClosure
    
    private var item: CartItem
    
    private lazy var optionsDataSource = ArrayDataSource(data: self.item.options)
    private lazy var optionsCollectionProvider = BasicProvider(
        dataSource: optionsDataSource,
        viewSource: ClosureViewSource(viewUpdater: { [weak self] (view: FoodOptionCell, data: FoodOption, index: Int) in
            view.configure(with: FoodOptionCell.Item(option: data, onRemoveOption: { [weak self] (_) in
                guard let self = self else { return }
                self.item.removeOption(at: index)
                self.optionsDataSource.data.remove(at: index)
                self.optionsDataSource.reloadData()
            }))
        }),
        sizeSource: { [weak self] (index: Int, data: FoodOption, collectionSize: CGSize) -> CGSize in
            guard let self = self else { return .zero }
            return CGSize(
                width: NSString(string: data.rawValue)
                    .size(withAttributes: [
                        NSAttributedString.Key.font : FontFamily.Poppins.regular.font(size: 11)!
                    ])
                    .width + 20,
                height: 15)
        }
    )
    
    private lazy var optionsCollection: CollectionView = {
        let collection = CollectionView(provider: self.optionsCollectionProvider)
        self.optionsCollectionProvider.layout = FlowLayout(lineSpacing: 5, interitemSpacing: 10, justifyContent: .start, alignItems: .start, alignContent: .start)
        collection.isScrollEnabled = false
        return collection
    }()
    
    private lazy var itemImage: UIImageView = {
        let itemImage = UIImageView(image: Images.foodItemPlaceholder.image)
        itemImage.setRoundCorners(Layout.cornerRadius)
        itemImage.contentMode = .scaleAspectFit
        return itemImage
    }()
    
    init(item: CartItem, onRemoveItem: @escaping (CartItemView) -> (), onChangeCount: @escaping IntClosure) {
        self.item = item
        self.onRemoveItem = onRemoveItem
        self.onChangeCount = onChangeCount
        
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    public func setup() {
        backgroundColor = Colors.white.color
        setRoundCorners(Layout.cornerRadius)
        setShadow(offset: CGSize(width: 0, height: 5.0), opacity: 0.05, radius: 20)
        snp.makeConstraints { $0.height.equalTo(100) }
        let counter = ItemCounter { [weak self] value in
            self?.item.count = value
            self?.onChangeCount(value)
        }
        counter.updateValue(item.count)
        addSubview(counter)
        counter.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.width.equalTo(50)
        }
        
        let shadow = UIView()
        addSubview(shadow)
        shadow.setRoundCorners(Layout.cornerRadius)
        shadow.setShadow(offset: CGSize(width: 0, height: 5), opacity: 0.1, radius: 10)
        shadow.backgroundColor = .white
        shadow.snp.makeConstraints { [weak self] in
            $0.top.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(counter.snp.trailing).offset(Layout.largeMargin)
            $0.size.equalTo(self?.snp.height ?? 0).inset(Layout.commonInset)
        }
        
        addSubview(itemImage)
        itemImage.snp.makeConstraints { [weak self] in
            $0.top.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(counter.snp.trailing).offset(Layout.largeMargin)
            $0.size.equalTo(self?.snp.height ?? 0).inset(Layout.commonInset)
        }
        
        let itemNameLabel = UILabel.makeText(item.name)
        itemNameLabel.font = FontFamily.semibold
        addSubview(itemNameLabel)
        itemNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(itemImage.snp.trailing).offset(Layout.largeMargin)
        }
        
        let itemPrice = UILabel.makeText(Formatter.Currency.toString(item.price))
        itemPrice.font = FontFamily.semibold
        itemPrice.textColor = Colors.blue.color
        addSubview(itemPrice)
        itemPrice.snp.makeConstraints {
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(Layout.commonMargin)
            $0.leading.equalTo(itemNameLabel)
        }
        
        let removeButton = UIButton()
        removeButton.setImage(Images.Icons.cross.image, for: .normal)
        removeButton.backgroundColor = Colors.lightRed.color
        removeButton.setRoundCorners(4)
        removeButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        removeButton.setActionHandler(controlEvents: .touchUpInside) { [unowned self] _ in
            self.onRemoveItem(self)
        }
        addSubview(removeButton)
        removeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(itemNameLabel.snp.trailing)
            $0.size.equalTo(18)
        }
        
        addSubview(optionsCollection)
        optionsCollection.snp.makeConstraints {
            $0.top.equalTo(itemPrice.snp.bottom)
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(itemImage.snp.trailing).offset(Layout.largeMargin)
            $0.bottom.equalToSuperview()
        }
    }
}
