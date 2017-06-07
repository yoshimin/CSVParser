//
//  CSVParser.swift
//  CSV
//
//  Created by 新谷　よしみ on 2017/05/12.
//  Copyright © 2017年 新谷　よしみ. All rights reserved.
//

import Foundation

class CSVParser {
    static let lineBreakPattern = "\n(?=(([^\"]*\"){2})*[^\"]*$)"
    static let commaPattern = ",(?=(([^\"]*\"){2})*[^\"]*$)"
    static let doubleQuatationPattern = "^\"|\"$"
    static let CR = "\r"
    static let CRLF = "\r\n"
    static let LF = "\n"
    
    class func parse(_ csv: String) -> Array<Array<String>> {
        var str = csv.replacingOccurrences(of: CRLF, with: LF)
        str = str.replacingOccurrences(of: CR, with: LF)
        
        let lines = str.components(pattern: lineBreakPattern)
        var rows = Array<Array<String>>()
        for (_, component) in lines.enumerated() {
            let uneditedColumns = component.components(pattern: commaPattern)
            var columns = Array<String>()
            for (_, column) in uneditedColumns.enumerated() {
                let col = column.replace(pattern: doubleQuatationPattern, with: "")
                columns.append(col)
            }
            rows.append(columns)
        }
        return rows
    }
}

extension String {
    func components(pattern: String) -> Array<String> {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return [self]
        }
        
        let matches = regex.matches(in: self, range: NSMakeRange(0, self.characters.count))
        
        var backward = self
        var location = 0
        var components = Array<String>()
        for (_, result) in matches.enumerated() {
            let nsStr: NSString = self as NSString
            let forward = nsStr.substring(with: NSMakeRange(location, (result.range.location - location)))
            location = result.range.location + result.range.length
            backward = nsStr.substring(from: location)
            components.append(forward)
        }
        components.append(backward)
        
        return components
    }
    
    func replace(pattern: String, with replacement: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return self
        }
        
        let matches = regex.matches(in: self, range: NSMakeRange(0, self.characters.count))
        
        var nsStr = self as NSString
        for (_, result) in matches.reversed().enumerated() {
            nsStr = nsStr.replacingCharacters(in: result.range, with: replacement) as NSString
        }
        
        return nsStr as String
    }
}
