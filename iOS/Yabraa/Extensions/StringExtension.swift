//
//  StringExtension.swift
//  Yabraa
//
//  Created by Hamada Ragab on 26/02/2023.
//

import Foundation
extension String {
//    func localized(bundle: Bundle = .main) -> String {
//        return NSLocalizedString(self, comment: "")
//    }
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func isNumeric() -> Bool {
          guard self.count > 0 else { return false }
          let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
          return Set(self).isSubset(of: nums)
      }
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

//    func convertToDate() -> Date?{
//        let dateFormatter = DateFormatter()
//        let tempLocale = dateFormatter.locale
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        let date = dateFormatter.date(from: self)!
//        return date
//    }
}
extension StringProtocol {
    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    subscript(_ range: Range<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
    
}

extension LosslessStringConvertible {
    var string: String { return .init(self) }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}
