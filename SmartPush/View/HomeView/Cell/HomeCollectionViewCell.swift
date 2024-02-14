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
	let timeLabel = UILabel()

	override func configureHierarchy() {
		[senderNameLabel, timeLabel].forEach { addSubview($0) }
	}

	override func configureLayout() {
		senderNameLabel.snp.makeConstraints {
			$0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
		}

		timeLabel.snp.makeConstraints {
			$0.top.equalTo(senderNameLabel.snp.bottom).offset(20)
			$0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
			$0.bottom.greaterThanOrEqualTo(self)
		}
	}

	override func configureView() {

	}
}
