//
//  DateFormatterHelper.swift
//  TheOfficeApp
//
//  Created by Daniel Teodoro on 24/11/20.
//

import Foundation


class DateFormatterHelper {
    func formatDate(from rawDateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"

        if let date = dateFormatterGet.date(from: rawDateString) {
            return dateFormatterPrint.string(from: date)
        } else {
            return "Unknow Date"
        }
    }
}
