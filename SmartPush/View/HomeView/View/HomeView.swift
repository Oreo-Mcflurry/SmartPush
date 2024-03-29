//
//  HomeView.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import SnapKit

class HomeView: BaseUIView {

	let collectionView = UICollectionView(frame: .zero, collectionViewLayout: HomeView.setCollectionViewLayout())
	let tableView = UITableView()
	override func configureHierarchy() {
		addSubview(collectionView)
		addSubview(tableView)
	}

	override func configureLayout() {
		collectionView.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
			$0.height.equalTo(350)
		}

		tableView.snp.makeConstraints {
			$0.top.equalTo(collectionView.snp.bottom)
			$0.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
		}
	}

	override func configureView() {
		collectionView.backgroundColor = .clear
		tableView.backgroundColor = .clear
	}

	static func setCollectionViewLayout() -> UICollectionViewLayout{
		let layout = UICollectionViewFlowLayout()
		let padding: CGFloat = 16
		layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-padding*3)/2, height: (UIScreen.main.bounds.width-padding*3)/4)
		layout.sectionInset = UIEdgeInsets(top: padding/2, left: padding, bottom: padding/2, right: padding)
		layout.minimumLineSpacing = padding
		layout.minimumInteritemSpacing = padding
		return layout
	}
}
