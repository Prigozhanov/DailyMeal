//
//  Created by Vladimir on 1/21/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Extensions
import AloeStackView
import CollectionKit

class CartItemView: UIView {
    
    struct Item {
        let cartItem: CartItem
        let onRemoveItem: (CartItemView) -> ()
        let onChangeCount: IntClosure
    }
    
    private var item: Item
    
    private lazy var optionsDataSource = ArrayDataSource(data: self.item.cartItem.options.filter { $0.applied })
    private lazy var optionsCollectionProvider = BasicProvider(
        dataSource: optionsDataSource,
        viewSource: ClosureViewSource(viewUpdater: { [weak self] (view: FoodOptionCell, data: CartItem.Option, index: Int) in
            view.configure(with: FoodOptionCell.Item(option: data, onRemoveOption: { [weak self] (_) in
                guard let self = self else { return }
                data.applied = false
                self.optionsDataSource.data.remove(at: index)
                self.optionsDataSource.reloadData()
                AppDelegate.shared.context.cartService.view?.reloadCalculationsRows()
            }))
        }),
        sizeSource: { [weak self] (index: Int, data: CartItem.Option, collectionSize: CGSize) -> CGSize in
            guard let self = self else { return .zero }
            return CGSize(
                width: NSString(string: data.option.rawValue)
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
    
    init(item: Item) {
        self.item = item

        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    public func setup() {
        let cardView = CardView(shadowSize: .medium, customInsets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(100)
        }
        let counter = ItemCounter(axis: .veritcal, valueChanged: item.onChangeCount)
        //            self?.item.cartItem.count = value
        //            self?.item.onChangeCount(value)
        
        counter.updateValue(item.cartItem.count)
        cardView.contentView.addSubview(counter)
        counter.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(Layout.commonInset)
            $0.width.equalTo(50)
        }
        
        let imageCardView = CardView(shadowSize: .small, customInsets: .zero)
        cardView.contentView.addSubview(imageCardView)
        imageCardView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(counter.snp.trailing).offset(Layout.commonMargin)
            $0.size.equalTo(counter.snp.height)
        }
        cardView.contentView.addSubview(itemImage)
        itemImage.contentMode = .scaleAspectFit
        itemImage.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(counter.snp.trailing).offset(Layout.commonMargin)
            $0.size.equalTo(counter.snp.height)
        }
        if let url = URL(string: item.cartItem.imageURL.orEmpty) {
             itemImage.sd_setImage(with: url)
        }
        
        let itemNameLabel = UILabel.makeText(item.cartItem.name)
        itemNameLabel.numberOfLines = 2
        itemNameLabel.font = FontFamily.semibold
        cardView.contentView.addSubview(itemNameLabel)
        itemNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(itemImage.snp.trailing).offset(Layout.largeMargin)
        }
        
        let itemPrice = UILabel.makeText(Formatter.Currency.toString(item.cartItem.price))
        itemPrice.font = FontFamily.semibold
        itemPrice.textColor = Colors.blue.color
        cardView.contentView.addSubview(itemPrice)
        itemPrice.snp.makeConstraints {
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(Layout.commonMargin)
            $0.leading.equalTo(itemNameLabel)
            $0.bottom.equalToSuperview().inset(Layout.commonInset)
        }
        
        let removeButton = UIButton()
        removeButton.setImage(Images.Icons.cross.image, for: .normal)
        removeButton.backgroundColor = Colors.lightRed.color
        removeButton.setRoundCorners(4)
        removeButton.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        removeButton.setActionHandler(controlEvents: .touchUpInside) { [unowned self] _ in
            self.item.onRemoveItem(self)
        }
        cardView.contentView.addSubview(removeButton)
        removeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(itemNameLabel.snp.trailing)
            $0.size.equalTo(18)
        }
        
        cardView.contentView.addSubview(optionsCollection)
        optionsCollection.snp.makeConstraints {
            $0.top.equalTo(itemPrice.snp.bottom)
            $0.trailing.equalToSuperview().inset(Layout.commonInset)
            $0.leading.equalTo(itemImage.snp.trailing).offset(Layout.largeMargin)
            $0.bottom.equalToSuperview()
        }
    }
    
}