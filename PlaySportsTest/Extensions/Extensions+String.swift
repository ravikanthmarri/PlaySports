//
//  Extensions+String.swift
//  PlaySportsTest
//
//  Created by R K Marri on 14/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import Foundation

extension String{
    
    func parseVideoDurationOfYoutubeAPI() -> String {
        
//        var videoDurationString = videoDuration! as NSString
        var videoDurationString = self as NSString
        
        var hours: Int = 0
        var minutes: Int = 0
        var seconds: Int = 0
        let timeRange = videoDurationString.range(of: "T")
        
        videoDurationString = videoDurationString.substring(from: timeRange.location) as NSString
        while videoDurationString.length > 1 {
            
            videoDurationString = videoDurationString.substring(from: 1) as NSString
            
            let scanner = Scanner(string: videoDurationString as String) as Scanner
            var part: NSString?
            
            scanner.scanCharacters(from: NSCharacterSet.decimalDigits, into: &part)
            
            let partRange: NSRange = videoDurationString.range(of: part! as String)
            
            videoDurationString = videoDurationString.substring(from: partRange.location + partRange.length) as NSString
            let timeUnit: String = videoDurationString.substring(to: 1)
            
            
            if (timeUnit == "H") {
                hours = Int(part! as String)!
            }
            else if (timeUnit == "M") {
                minutes = Int(part! as String)!
            }
            else if (timeUnit == "S") {
                seconds   = Int(part! as String)!
            }
            else{
            }
        }
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
}
