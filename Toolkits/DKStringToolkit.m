//
//  DKStringToolkit.m
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKStringToolkit.h"

@implementation DKStringToolkit

+ (NSString *)stringTrimWhiteSpace:(NSString *)needTrim
{
    if (needTrim) {
        return [needTrim stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    } else {
        return @"";
    }
}

+ (NSString *)trimFirstDigitZero:(float)number
{
    NSString *returnNumber = [NSString stringWithFormat:@"%.1f", number];
    
    NSArray *array = [returnNumber componentsSeparatedByString:@"."];
    
    if ([[array lastObject] isEqualToString:@"0"]) {
        return [array firstObject];
    } else {
        return returnNumber;
    }
}

+ (NSString *)parseObjectTypeToString:(id)obj
{
    return [NSString stringWithFormat:@"%@", obj];
}

+ (NSString *)trimCapitalTInDateFromServer:(NSString *)dateTime
{
    if ([self isString:dateTime containsString:@"T"]) {
        return [dateTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    } else {
        NSArray *arrayDateTime = [self seperate14NumbersToSixParts:dateTime];
        if (arrayDateTime.count == 6) {
            return [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@", arrayDateTime[0], arrayDateTime[1], arrayDateTime[2], arrayDateTime[3], arrayDateTime[4], arrayDateTime[5]];
        } else {
            return dateTime;
        }
    }
}

+ (NSArray *)parseDateTimeStringToArray:(NSString *)dateTime
{
    if ([self isString:dateTime containsString:@"T"]) {
        return [dateTime componentsSeparatedByString:@"T"];
    } else {
        NSArray *arrayDateTime = [self seperate14NumbersToSixParts:dateTime];
        if (arrayDateTime.count == 6) {
            return @[[NSString stringWithFormat:@"%@-%@-%@", arrayDateTime[0], arrayDateTime[1], arrayDateTime[2]],
                     [NSString stringWithFormat:@"%@:%@:%@", arrayDateTime[3], arrayDateTime[4], arrayDateTime[5]]];
        } else {
            return @[];
        }
    }
}

+ (BOOL)isString:(NSString *)originStr containsString:(NSString *)str
{
    NSRange range = [originStr rangeOfString:str options:NSCaseInsensitiveSearch];
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}
/**
 *  将yyyyMMddHHmmss格式的14位数字，分割成6部分
 *
 *  @param dateTime 14位格式的日期
 *
 *  @return
 */
+ (NSArray *)seperate14NumbersToSixParts:(NSString *)dateTime
{
    if (dateTime.length == 14) {
        NSString *year = [dateTime substringWithRange:NSMakeRange(0, 4)];
        NSString *month = [dateTime substringWithRange:NSMakeRange(4, 2)];
        NSString *day = [dateTime substringWithRange:NSMakeRange(6, 2)];
        NSString *hour = [dateTime substringWithRange:NSMakeRange(8, 2)];
        NSString *min = [dateTime substringWithRange:NSMakeRange(10, 2)];
        NSString *second = [dateTime substringWithRange:NSMakeRange(12, 2)];
        
        return @[year, month, day, hour, min, second];
    } else {
        return @[dateTime];
    }
}

+ (NSString *)replaceLineToYearAndMonthAndDay:(NSString *)date
{
    NSArray *arrayDate = [date componentsSeparatedByString:@"-"];
    
    if (arrayDate.count == 3) {
        return [NSString stringWithFormat:@"%@年%@月%@日", [arrayDate firstObject], [arrayDate objectAtIndex:1], [arrayDate lastObject]];
    } else {
        return date;
    }
}

+ (NSString *)replaceNullToEmpty:(id)str
{
    if ([str isKindOfClass:[NSNull class]]) {
        return @"";
    } else {
        return [self stringTrimWhiteSpace:[self parseObjectTypeToString:str]];
    }
}

+ (int)getTotalPageNumberByTotalResultCounts:(int)totalCounts pageCount:(int)pageCount
{
    int pageNumber = 0;
    if (pageCount != 0) {
        if (totalCounts % pageCount == 0) {
            pageNumber = totalCounts / pageCount;
        } else {
            pageNumber = totalCounts / pageCount + 1;
        }
    }
    
    return pageNumber;
}
@end
