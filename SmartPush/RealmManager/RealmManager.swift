//
//  RealmManager.swift
//  SmartPush
//
//  Created by A_Mcflurry on 2/17/24.
//

import UIKit
import RealmSwift

class RealmRepository {
	enum RealmTypes {
		case pushModel
		case category
	}

	var realm: Realm {
		return try! Realm()
	}

	// MARK: - Read
	func fetchData<T: RealmFetchable>(type: T.Type) -> Results<T> {
		return realm.objects(type)
	}
}

//enum RealmManagerPlus {
//	case pushModel(update: Update?)
//	case category(name: String)
//
//	enum Update {
//		case star
//		case todo
//	}
//
//	var realm: Realm {
//		return try! Realm()
//	}
//
//	private func getModelType() -> Object: RealmFetchable {
//		switch self {
//		case .pushModel:
//			return PushModel.self
//		case .category:
//			return Categorys.self
//		}
//	}
//
//	// MARK: - Create
//	func createData(_ model: Object) {
//		do {
//			try realm.write {
//				realm.add(model)
//			}
//		} catch {
//			print(error.localizedDescription)
//		}
//	}
//
//	// MARK: - Read
//	func fetchData() -> Results<Object> {
//		let objectType: AnyClass = self.getModelType()
//		 return realm.objects(objectType)
//	}
//
//	// MARK: - Update
//	func updateDate(_ model: Object) {
//		do {
//			try realm.write {
//
//				let value: [String: Any?]
//				let item = model as! PushModel
//
//				switch self {
//				case .pushModel(let update):
//					switch update {
//					case .star:
//						item.stared.toggle()
//					case .todo:
//						item.complete.toggle()
//					case nil:
//						break
//					}
//					value = [
//						"id": item.id,
//						"addDate": item.addDate,
//						"complete": item.complete,
//						"stared": item.stared,
//						"title": item.title,
//						"memo": item.memo ?? "",
//						"deadline": item.deadlineDate,
//						"category": item.category,
//						"priority": item.priority
//					]
//
//				case .category:
//
//					let item = model as! Categorys
//					value = [
//						"id": item.id,
//						"addDate": item.addDate,
//						"category": item.category
//					]
//				}
//				realm.create(self.getModelType(), value: value, update: .modified)
//			}
//		} catch {
//			print(error.localizedDescription)
//		}
//	}
//
//	// MARK: - Delete
//	func deleteData(_ id: UUID) {
//		do {
//			try realm.write {
//				if let data = realm.object(ofType: self.getModelType(), forPrimaryKey: id) {
//					// if case문을 배워놓고 쓸대가 없다고 생각했는데 이런곳에 쓰면 좋겠더라구요
//					if case .category = self {
//						realm.objects(PushModel.self).where { $0.category.category == (data as! PushModel).category?.category }.forEach {
//							$0.category?.category = nil
//						}
//					}
//					realm.delete(data)
//				}
//			}
//		} catch {
//			print(error.localizedDescription)
//		}
//	}
//}

// https://velog.io/@yuiop1029/iOS-연구해본-Database-Event-Driven-Reloading-View
// 이런식으로 사용해도 Observer Pattern이라고 할 수 있는지 궁금해요. 패턴에 정답은 없다고 하지만...

class DBObserver {
	static let shared = DBObserver()
	private init() { }

	private var closures: [(AnyClass, (()->Void))] = []

	func occurEvent() {
		for item in closures {
			DispatchQueue.main.async {
				item.1()
			}
		}
	}

	func bind(withObject object: AnyClass, _ newClosure: @escaping ()->Void) {
		for item in closures where item.0 == object { closures = closures.filter { $0.0 != object } }
		print("add closure", object)
		self.closures.append((object, newClosure))
	}
}



class RealmManager {
	var realm: Realm {
		return try! Realm()
	}

	private func changeValue() {
		DBObserver.shared.occurEvent()
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


	func saveImageToDocument(image: UIImage, withId id: String) {
		guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

		let fileUrl = documentDirectory.appendingPathComponent("\(id).jpeg")
		guard let data = image.jpegData(compressionQuality: 0.5) else { return }
		do {
			try data.write(to: fileUrl)
		} catch {
			print(error.localizedDescription)
		}
	}

	func deleteImageToDocument(withId id: String) {
		guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
		let fileUrl = documentDirectory.appendingPathComponent("\(id).jpeg")
		if FileManager.default.fileExists(atPath: fileUrl.path()) {
			do {
				try FileManager.default.removeItem(at: fileUrl)
			} catch {
				print(error.localizedDescription)
			}
		}
	}

	func loadImageToDocument(withId id: String) -> UIImage {
		guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "star")! }
		let fileUrl = documentDirectory.appendingPathComponent("\(id).jpeg")
		if FileManager.default.fileExists(atPath: fileUrl.path()) {
			return UIImage(contentsOfFile: fileUrl.path())!
		}
		return UIImage(systemName: "star")!
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

	func deleteAll() {
		do {
			try realm.write {
				realm.deleteAll()
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func deleteItem(_ item: PushModel) {
		do {
			try realm.write {
				if let data = realm.object(ofType: PushModel.self, forPrimaryKey: item.id) {
					realm.delete(data)
					self.changeValue()
				}
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func addItem(_ item: PushModel) {
		do {
			try realm.write {
				realm.add(item)
				self.changeValue()
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func updateItem(_ item: PushModel) {
		do {
			try realm.write {
				let value: [String: Any?] = [
					"id": item.id,
					"addDate": item.addDate,
					"complete": item.complete,
					"stared": item.stared,
					"title": item.title,
					"memo": item.memo,
					"deadline": item.deadlineDate,
					"category": item.category,
					"priority": item.priority
				]
				realm.create(PushModel.self, value: value, update: .modified)
				self.changeValue()
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func todoUpdate(_ id: UUID) {
		do {
			try realm.write {
				if let data = realm.object(ofType: PushModel.self, forPrimaryKey: id) {
					let value: [String: Any] = [
						"id": data.id,
						"complete": !data.complete
						]
					realm.create(PushModel.self, value: value, update: .modified)
					self.changeValue()
				}
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func starUpdate(_ id: UUID) {
		do {
			try realm.write {
				if let data = realm.object(ofType: PushModel.self, forPrimaryKey: id) {
					let value: [String: Any] = [
						"id": data.id,
						"stared": !data.stared
						]
					realm.create(PushModel.self, value: value, update: .modified)
					self.changeValue()
				}
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func makeCategory(categoryStr: String) -> Categorys {
		do {
			try RealmManager().realm.write {
				if let data = RealmManager().realm.objects(Categorys.self).where({ $0.category == categoryStr }).first {
					return data
				} else {
					if let categoryData = realm.objects(Categorys.self).randomElement() {
						changeValue()
						return categoryData
					}
					return Categorys(category: "카테고리 없음")
				}
			}
		} catch {
			print(error.localizedDescription)
		}
		return RealmManager().makeNoCategory()
	}

	func categoryUpdate(_ id: UUID, categorystr: String) {
		do {
			try realm.write {
				if let data = realm.object(ofType: PushModel.self, forPrimaryKey: id) {
					if let categoryData = realm.objects(Categorys.self).where({ $0.category == categorystr }).first {
						let value: [String: Any] = ["id": id, "category": categoryData]
						realm.create(PushModel.self, value: value, update: .modified)
						changeValue()
					}
				}
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func makeNoCategory() -> Categorys {
		do {
			try realm.write {
				if let categoryData = realm.objects(Categorys.self).where({ $0.category == "카테고리 없음" }).first {
					changeValue()
					return categoryData
				}
				return Categorys(category: "카테고리 없음")
			}
		} catch {
			print(error.localizedDescription)
			return Categorys(category: "카테고리 없음")
		}
		return Categorys(category: "카테고리 없음")
	}

	func fetchData() -> Results<PushModel> {
		return realm.objects(PushModel.self)
	}

	func fetchCategory() -> Results<Categorys> {
		return realm.objects(Categorys.self)
	}

	func deleteCategory(_ id: UUID) {
		do {
			try realm.write {
				if let data = realm.object(ofType: Categorys.self, forPrimaryKey: id) {
					realm.objects(PushModel.self).where { $0.category.category == data.category }.forEach {
						$0.category?.category = nil
					}
					realm.delete(data)
					changeValue()
				}
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func addCategory(withString value: String) {
		do {
			try realm.write {
				realm.add(Categorys(category: value))
				self.changeValue()
			}
		} catch {
			print(error.localizedDescription)
		}
	}

	func fetchDataWithDate(date: Date) -> Results<PushModel> {
		let start = Calendar.current.startOfDay(for: date)
		let end = Calendar.current.date(byAdding: .day, value: 1, to: start)!
		let predicate = NSPredicate (format: "deadlineDate >= %@ && deadlineDate < %@",start as NSDate, end as NSDate)
		return realm.objects(PushModel.self).filter(predicate)
	}
}
