//
//  HtmlView.swift
//  TvMaze
//
//  Created by Francisco Cordoba on 18/4/25.
//

import Foundation

extension String {
    func htmlToString() -> String {
        do {
            return try NSAttributedString(data: self.data(using: .utf8)!,
                                          options: [.documentType: NSAttributedString.DocumentType.html],
                                          documentAttributes: nil).string
        } catch {
            return "N/A"
        }
    }
}
