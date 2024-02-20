//
//  Document+Extension.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/20/24.
//

import UIKit

extension UIViewController {
	enum ImageMange {
		case save(image: UIImage)
		case delete
		case load
	}

	@discardableResult
	func DocumnetImageManager(withId id: UUID, _ kind: ImageMange) -> UIImage? {
		guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
		let fileUrl = documentDirectory.appendingPathComponent("\(id).jpeg")

		switch kind {
		case .save(let image):
			guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
			do {
				try data.write(to: fileUrl)
			} catch {
				print(error.localizedDescription)
			}
			return nil
		case .delete:
			if FileManager.default.fileExists(atPath: fileUrl.path()) {
				do {
					try FileManager.default.removeItem(at: fileUrl)
				} catch {
					print(error.localizedDescription)
				}
			}
			return nil
		case .load:
			if FileManager.default.fileExists(atPath: fileUrl.path()) {
				return UIImage(contentsOfFile: fileUrl.path())
			} else {
				return UIImage(systemName: "star")
			}
		}
	}

	func getTodoSign(withBool value: Bool) -> UIImage {
		return value ? UIImage(systemName: "circle.fill")! : UIImage(systemName: "circle")!
	}

	func getStarSign(withBool value: Bool) -> UIImage {
		return value ? UIImage(systemName: "star.fill")! : UIImage(systemName: "star")!
	}

	func getTitle(_ item: PushModel) -> String {
		switch item.priority {
		case 0:
			return "\(item.title)!!!"
		case 1:
			return "\(item.title)!!"
		case 2:
			return "\(item.title)!"
		default:
			return item.title
		}
	}

	func getPriority(withPriority item: Int) -> String {
		switch item {
		case 0:
			return "상"
		case 1:
			return "중"
		case 2:
			return "하"
		default:
			return "알수없음"
		}
	}
}
