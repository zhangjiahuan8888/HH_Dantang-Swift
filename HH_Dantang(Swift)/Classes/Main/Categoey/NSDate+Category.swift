//
//  NSDate+Category.swift
//  DSWeibo
//
//  Created by xiaomage on 16/9/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

extension NSDate
{
        class func dateWithStr(time: String) ->NSDate {
        /*
        NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
        NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
        
        NSString *weekStr = [weekday objectAtIndex:components.weekday];
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"MM月dd日"];
        
        // 毫秒值转化为秒
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[NSString stringWithFormat:@"%lld",data] doubleValue]/ 1000.0];
        NSString* dateString = [formatter stringFromDate:date];
        NSString *dateStr = [NSString stringWithFormat:@"%@ %@",dateString,weekStr];
        return dateStr;

        */

//        let weekday = ["星期日","星期一","星期二","星期三","星期四","星期五","星期六",""]
//        let newDate = NSDate(timeIntervalSince1970: time)
//        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
//        let weekdayComponent = calendar?.components(NSCalendarUnit.NSWeekOfYearCalendarUnit, fromDate: newDate)
//        let weekStr = weekday[(weekdayComponent?.weekday)!]
//        print(weekStr)
        
        // 1.将服务器返回给我们的时间字符串转换为NSDate
        // 1.1.创建formatter
        let formatter = NSDateFormatter()
        // 1.2.设置时间的格式
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        // 1.3设置时间的区域(真机必须设置, 否则可能不能转换成功)
        formatter.locale = NSLocale(localeIdentifier: "en")
        // 1.4转换字符串, 转换好的时间是去除时区的时间
        let createdDate = formatter.dateFromString(time)!
        
        return createdDate
    }
    
    static func timeStampToString(timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:NSTimeInterval = string.doubleValue
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="MM月dd日"
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        print(dfmatter.stringFromDate(date))
        return dfmatter.stringFromDate(date)
    }
    
}
