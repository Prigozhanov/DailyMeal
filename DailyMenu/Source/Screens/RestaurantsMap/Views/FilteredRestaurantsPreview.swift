//
//  Created by Vladimir on 2/24/20.
//  Copyright © 2020 epam. All rights reserved.
//

import CollectionKit

class FilteredRestaurantsPreview: UIView {
	
	typealias Item = IntClosure
	
	private var item: Item
	
	private lazy var collectionView = CollectionView(provider: basicProvider)
	
	private var cellItems: [FilteredRestaurantsPreviewCell.Item] = []
	
	private var currentPage = 0
	private let cellWidth: CGFloat = 200
	private var edgeInset: CGFloat = 0
	private var targetPoint: CGPoint = .zero
	
	private let emptyStateViewHeight: CGFloat = 40
	private lazy var emptyStateView: UILabel = {
		let label = UILabel.makeText("No restaurants found")
		label.backgroundColor = Colors.white.color
		label.setRoundCorners(emptyStateViewHeight / 2)
		label.textAlignment = .center
		return label
	}()
	
	private lazy var dataSource = ArrayDataSource(data: cellItems)
	
	private lazy var viewSource = ClosureViewSource { (view: FilteredRestaurantsPreviewCell, data: FilteredRestaurantsPreviewCell.Item, _) in
		view.configure(item: data)
	}
	
	private lazy var sizeSource = { [weak self](index: Int, data: FilteredRestaurantsPreviewCell.Item, collectionSize: CGSize) -> CGSize in
		return CGSize(width: self?.cellWidth ?? 0, height: 130)
	}
	
	private lazy var basicProvider =  BasicProvider(
		dataSource: dataSource,
		viewSource: viewSource,
		sizeSource: sizeSource,
		layout: FlowLayout(lineSpacing: 10, alignItems: .end, alignContent: .start).transposed(),
		tapHandler: { [weak self] handler in
			self?.cellItems[handler.index].onSelectAction()
	})
	
	init(item: @escaping Item) {
		self.item = item
		
		super.init(frame: .zero)
		
		addSubview(collectionView)
		collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
		
		collectionView.provider = basicProvider
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.alwaysBounceHorizontal = true
		collectionView.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) { fatalError() }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		edgeInset = frame.width / 2 - CGFloat(cellWidth / 2)
		collectionView.contentInset = UIEdgeInsets(top: 0, left: edgeInset, bottom: 0, right: edgeInset)
		collectionView.scrollTo(edge: .left, animated: false)
	}
	
	func configure(cellItems: [FilteredRestaurantsPreviewCell.Item]) {
		isUserInteractionEnabled = true
		emptyStateView.removeFromSuperview()
		self.cellItems = cellItems
		dataSource.data = cellItems
		collectionView.reloadData()
		collectionView.scrollTo(edge: .left, animated: false)
		
		if cellItems.isEmpty {
			showEmptyState()
		}
	}
	
	private func showEmptyState() {
		isUserInteractionEnabled = false
		addSubview(emptyStateView)
		emptyStateView.snp.makeConstraints {
			$0.center.equalToSuperview()
			$0.width.equalTo(200)
			$0.height.equalTo(emptyStateViewHeight)
		}
	}
	
}

extension FilteredRestaurantsPreview: UIScrollViewDelegate {
	
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		let targetXContentOffset = CGFloat(targetContentOffset.pointee.x)
		let currentOffset = collectionView.contentOffset
		let pageCount = dataSource.data.count
		let pageWidth = cellWidth + 10
		
		if velocity.x == 0 {
			if  collectionView.contentOffset.x - targetPoint.x <  pageWidth / 2 {
				currentPage -= 1
				let point = CGPoint(x: CGFloat(CGFloat(currentPage) * pageWidth) - edgeInset, y: targetContentOffset.pointee.y)
				targetContentOffset.pointee = point
				targetPoint = point
			} else {
				let point = CGPoint(x: CGFloat(CGFloat(currentPage) * pageWidth) - edgeInset, y: targetContentOffset.pointee.y)
				targetContentOffset.pointee = point
				targetPoint = point
				currentPage += 1
			}
			return
		} else if targetXContentOffset < edgeInset + pageWidth {
			currentPage = targetXContentOffset > CGFloat(currentOffset.x + pageWidth / 2) ? currentPage + 1 : currentPage - 1
		} else {
			currentPage = targetXContentOffset > CGFloat(currentOffset.x - pageWidth / 2) ? currentPage + 1 : currentPage - 1
		}

		var point = CGPoint(x: CGFloat(CGFloat(currentPage) * pageWidth) - edgeInset, y: targetContentOffset.pointee.y)

		if currentPage == pageCount {
			point = CGPoint(x: CGFloat(CGFloat(currentPage) * pageWidth) + edgeInset, y: targetContentOffset.pointee.y)
			targetContentOffset.pointee = point
			return
		}

		if currentPage <= 0 {
			currentPage = 0
			point = CGPoint(x: CGFloat(CGFloat(currentPage) * pageWidth) - edgeInset, y: targetContentOffset.pointee.y)
		}

		if currentPage >= pageCount {
			currentPage = pageCount
			point = CGPoint(x: CGFloat(CGFloat(currentPage) * pageWidth) + edgeInset, y: targetContentOffset.pointee.y)
		}
		
		targetContentOffset.pointee = point
		targetPoint = point
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		if currentPage < dataSource.data.count, currentPage >= 0 {
			item(dataSource.data[currentPage].id)
		}
		
	}
	
}
