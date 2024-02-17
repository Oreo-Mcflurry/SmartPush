//
//  HomeViewController.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import RealmSwift

class HomeViewController: BaseViewController {

	let homeView = HomeView()
	var datas: Results<PushModel>!

	override func loadView() {
		self.view = homeView
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		datas = RealmManager().fetchData()
		homeView.collectionView.reloadData()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func configureView() {
		navigationItem.title = "ALL"
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
		return ListItems.allCases.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
		cell.senderNameLabel.text = ListItems.allCases[indexPath.row].rawValue
		cell.imageView.image = UIImage(systemName: ListItems.allCases[indexPath.row].getImageName)
		cell.imageView.tintColor = ListItems.allCases[indexPath.row].getColor
		cell.countLabel.text = "\(ListItems.getFilteredData(enumCase: ListItems.allCases[indexPath.row], datas: datas).count)"
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let vc = DetailViewController()
		vc.type = ListItems.allCases[indexPath.item]
		navigationController?.pushViewController(vc, animated: true)
	}

	func setCollectionView() {
		homeView.collectionView.delegate = self
		homeView.collectionView.dataSource = self
		homeView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
	}
}


//switch indexPath.row {
//case 0:
//	let value = datas.filter {
//		let calendar = Calendar.current
//		let itemDateComponents = calendar.dateComponents([.year, .month, .day], from: $0.deadline)
//		let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())
//
//		return itemDateComponents.year == currentDateComponents.year && itemDateComponents.month == currentDateComponents.month && itemDateComponents.day == currentDateComponents.day
//	}.count
//	cell.countLabel.text = "\(value)"
//case 1:
//	cell.countLabel.text = "\(datas.filter { $0.deadline > Date() }.count)"
//case 2:
//	cell.countLabel.text = "\(datas.count)"
//case 3:
//	cell.countLabel.text = "\(datas.filter { $0.stared }.count)"
//case 4:
//	cell.countLabel.text = "\(datas.filter { $0.complete }.count)"
//default: print("이럴수가")
//}
