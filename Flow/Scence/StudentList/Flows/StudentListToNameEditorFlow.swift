//
//  MainCoordinator.swift
//  CoordinatorPattern
//
//  Created by Amirreza Eghtedari on 1/19/1400 AP.
//

import UIKit

class StudentListToNameEditorFlow: StudentNameEditorService {

	weak var viewController: UIViewController?
	var completion: ((Student) -> Void)?
	
	func edit(student: Student, completion: @escaping (Student) -> Void) {
		self.completion = completion
		var (studentEditor, studentViewController) = StudentNameEditorViewControllerFactory.build()
		studentEditor.serviceDelegate = self
		studentEditor.edit(student: student)
		viewController?.show(studentViewController, sender: self)
		self.completion = completion
	}
}

extension StudentListToNameEditorFlow: StudentNameEditorServiceDelegate {
	
	func studentEditorServiceDidModify(student: Student) {
		
		completion?(student)
		
		guard let vc = self.viewController else { return }
		viewController?.navigationController?.popToViewController(vc, animated: true)

	}
}
