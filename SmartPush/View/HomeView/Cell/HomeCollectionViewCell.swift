//
//  HomeCollectionViewCell.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit
import SnapKit

class HomeCollectionViewCell: BaseCollectionViewCell {
	let senderNameLabel = UILabel()
	let countLabel = UILabel()
	let imageView = UIImageView()

	override func configureHierarchy() {
		[senderNameLabel, countLabel, imageView].forEach { addSubview($0) }
	}

	override func configureLayout() {
		imageView.snp.makeConstraints {
			$0.top.leading.equalToSuperview().inset(10)
			$0.width.height.equalTo(40)
		}

		senderNameLabel.snp.makeConstraints {
			$0.top.greaterThanOrEqualTo(imageView.snp.bottom)
			$0.leading.equalToSuperview().inset(10)
			$0.bottom.equalToSuperview().inset(10)
		}

		countLabel.snp.makeConstraints {
			$0.top.trailing.equalToSuperview().inset(10)
			$0.leading.greaterThanOrEqualTo(imageView.snp.trailing).offset(10)
		}
	}

	override func configureView() {
		countLabel.font = .boldSystemFont(ofSize: 30)
		countLabel.text = "0"
		senderNameLabel.font = .systemFont(ofSize: 18)
		self.layer.cornerRadius = 20
		self.backgroundColor = .gray
		imageView.clipsToBounds = true
		DispatchQueue.main.async {
			self.imageView.layer.cornerRadius = self.imageView.frame.width/2
		}

	}
}

#Preview {
	UINavigationController(rootViewController: HomeViewController())
}
