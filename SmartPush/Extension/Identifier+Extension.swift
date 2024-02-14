//
//  Identifier+Extension.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/14/24.
//

import UIKit

protocol ReusableViewProtocol {
	static var identifier: String { get }
}

extension UIView: ReusableViewProtocol {
	static var identifier: String {
		return String(describing: self)
	}
}

extension UIViewController: ReusableViewProtocol {
	static var identifier: String {
		return String(describing: self)
	}
}
