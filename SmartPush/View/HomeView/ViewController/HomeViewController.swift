//
//  HomeViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

class HomeViewController: BaseViewController {

	let homeView = HomeView()
	let datas: [PushModel] = []

	override func loadView() {
		self.view = homeView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		navigationItem.title = "푸시알림 설정"
		navigationController?.navigationBar.prefersLargeTitles = true
		setCollectionView()

		let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
		navigationItem.rightBarButtonItem = addButton
	}
	@objc func addButtonTapped() {
		transition(withStyle: .presentFullNavigation, viewController: AddScheduleViewController.self)
	}
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return datas.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
		cell.senderNameLabel.text = datas[indexPath.item].title
//		cell.senderNameLabel.text = datas[indexPath.item].date
		return cell
	}
	
	func setCollectionView() {
		homeView.collectionView.delegate = self
		homeView.collectionView.dataSource = self
		homeView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
	}
}
