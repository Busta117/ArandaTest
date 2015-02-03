//
//  ArandaUtilities.swift
//  ArandaTest
//
//  Created by Santiago Bustamante on 2/2/15.
//  Copyright (c) 2015 Santiago Bustamante. All rights reserved.
//

import UIKit

extension NSDate {
    
    
    func stringNoTimeZoneWithFormat(format: String = "MM/dd/yy") -> String{
        let formatter : NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        return formatter.stringFromDate(self)
    }
    
    func stringWithFormat(format: String) -> String{
        let formatter : NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        
        return formatter.stringFromDate(self)
    }
    
    
    //create a NSDate from a strind date with specific format
    class func dateFromString(dateString: String ,format:String) -> NSDate{
        
        let formatter : NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = format
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        
        return formatter.dateFromString(dateString)!
    }
    
}

extension String{
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var int64Value: Int64{
        return NSNumber(float: self.floatValue).longLongValue
    }
    
    func toFloat() -> Float{
        return self.floatValue
    }
    
    func formatedStringToFloat() -> Float{
        var trimmed = self.stringByTrimmingCharactersInSet(.symbolCharacterSet())
        trimmed = self.stringByReplacingOccurrencesOfString(",", withString: "", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        trimmed = trimmed.stringByTrimmingCharactersInSet(.letterCharacterSet())
        return trimmed.floatValue
    }
    
    func currencyFormat() -> String{
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.generatesDecimalNumbers = false
        formatter.maximumFractionDigits = 0
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        return formatter.stringFromNumber(self.floatValue)!
    }
}

extension UIAlertView {
    
    class func showAlert(title:String?, message:String?, cancelButton:String){
        var alert:UIAlertView = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: cancelButton)
        alert.show()
    }
}
