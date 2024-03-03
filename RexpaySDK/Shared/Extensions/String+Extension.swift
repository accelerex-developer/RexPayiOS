//
//  String+Extension.swift
//  RexpaySDK
//
//  Created by Abdullah on 27/01/2024.
//
import Foundation
extension String {
    
    var isValidName: Bool {
        let nameRegex = "^\\w{2,18}$"
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateName = NSPredicate(format: "SELF MATCHES %@", nameRegex)
        let isValidateName = validateName.evaluate(with: trimmedString)
        return isValidateName
    }
    
    var isValidNumericValueOnly: Bool {
        let numberRegEx  = "[0-9]{11}+"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: self)
    }
    
    var isValidEmailAddress: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.trimmingCharacters(in: .whitespaces))
    }
    
    var isValidPassword: Bool {
        return self.count >= 8 ? true : false
    }
}
