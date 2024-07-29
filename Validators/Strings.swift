//
//  Strings.swift
//  SweetTreats
//
//  Created by user263110 on 7/29/24.
//

import Foundation


// https://stackoverflow.com/questions/29381994/check-string-for-nil-empty/54337441#54337441
extension Optional where Wrapped == String {
    var isEmptyOrNil: Bool {
        return self?.isEmpty ?? true
    }
    
    var isWhitespace: Bool {
        return self?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    var isEmptyOrNilOrWhitespace: Bool {
        return isEmptyOrNil || isWhitespace
    }
}

extension String {
    var isEmptyOrNil: Bool {
        return self.isEmpty
    }
    
    var isWhitespace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    var isEmptyOrNilOrWhitespace: Bool {
        return isEmptyOrNil || isWhitespace
    }
}
