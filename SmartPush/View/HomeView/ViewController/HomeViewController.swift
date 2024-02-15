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

	var defaultListItems: [ListItem] = [
		 ListItem(title: "오늘", color: UIColor.systemBlue, imageName: "calendar.circle.fill", count: 0),
		 ListItem(title: "예정", color: UIColor.orange, imageName: "newspaper.circle.fill", count: 0),
		 ListItem(title: "전체", color: UIColor.darkGray, imageName: "archivebox.circle.fill", count: 0),
		 ListItem(title: "중요", color: UIColor.systemYellow, imageName: "flag.circle.fill", count: 0),
		 ListItem(title: "완료", color: UIColor.darkGray, imageName: "checkmark.circle.fill", count: 0)
	]

	override func loadView() {
		self.view = homeView
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		let realm = try! Realm()
		datas = realm.objects(PushModel.self)

		defaultListItems[0].count = datas.filter {
			let calendar = Calendar.current
			let itemDateComponents = calendar.dateComponents([.year, .month, .day], from: $0.deadline)
			let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: Date())

			return itemDateComponents.year == currentDateComponents.year && itemDateComponents.month == currentDateComponents.month && itemDateComponents.day == currentDateComponents.day
		}.count

		defaultListItems[1].count = datas.filter { $0.deadline > Date() }.count
		defaultListItems[2].count = datas.count
		defaultListItems[3].count = datas.filter { $0.stared }.count
		defaultListItems[4].count = datas.filter { $0.complete }.count

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
		return defaultListItems.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
		cell.senderNameLabel.text = defaultListItems[indexPath.row].title
		cell.imageView.image = UIImage(systemName: defaultListItems[indexPath.row].imageName)
		cell.imageView.tintColor = defaultListItems[indexPath.row].color
		cell.countLabel.text = "\(defaultListItems[indexPath.row].count)"
		return cell
	}
	
	func setCollectionView() {
		homeView.collectionView.delegate = self
		homeView.collectionView.dataSource = self
		homeView.collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
	}
}
