//
//  DKDateToolkit.m
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKDateToolkit.h"
#import "DKStringToolkit.h"

static NSDateFormatter *dateFormatter;

@implementation DKDateToolkit

+ (NSString *)parseTimeToFormat:(int)formatType timeInSecond:(NSInteger)timeInSecond
{
    NSInteger hour = 0;
    NSInteger min = 0;
    NSInteger sec = 0;
    if (timeInSecond < 60) {
        sec = timeInSecond;
    } else if (timeInSecond < 3600) {
        min = timeInSecond / 60;
        sec = timeInSecond % 60;
    } else {
        hour = timeInSecond / 3600;
        if (timeInSecond % 3600 < 60) {
            min = 0;
            sec = timeInSecond % 3600;
        } else {
            min = timeInSecond % 3600 / 60;
            sec = timeInSecond % 3600 % 60;
        }
    }
    NSString *hourInStr = nil;
    NSString *minInStr = nil;
    NSString *secInStr = nil;
    if (formatType == 1) {
        hourInStr = hour < 10 ? [NSString stringWithFormat:@"0%ld", (long)hour] : [NSString stringWithFormat:@"%ld", (long)hour];
        minInStr = min < 10 ? [NSString stringWithFormat:@"0%ld", (long)min] : [NSString stringWithFormat:@"%ld", (long)min];
        secInStr = sec < 10 ? [NSString stringWithFormat:@"0%ld", (long)sec] : [NSString stringWithFormat:@"%ld", (long)sec];
        return [NSString stringWithFormat:@"%@:%@:%@", hourInStr, minInStr, secInStr];
    } else {
        hourInStr = [NSString stringWithFormat:@"%ld", (long)hour];
        minInStr = [NSString stringWithFormat:@"%ld", (long)min];
        secInStr = [NSString stringWithFormat:@"%ld", (long)sec];
        return [NSString stringWithFormat:@"%@小时%@分%@秒", hourInStr, minInStr, secInStr];
    }
}

+ (NSString *)getCurrentDateWithFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)getOneTypeOfDateTime:(NSString *)dateTime returnType:(ReturnDateTimeType)returnType
{
    dateTime = [DKStringToolkit replaceNullToEmpty:dateTime];
    switch (returnType) {
        case ReturnDateTimeTypeAll:
            return [DKStringToolkit trimCapitalTInDateFromServer:dateTime];
        case ReturnDateTimeTypeDate:
            return [[DKStringToolkit parseDateTimeStringToArray:dateTime] firstObject];
        case ReturnDateTimeTypeTime:
            return [[DKStringToolkit parseDateTimeStringToArray:dateTime] lastObject];
        default:
            return [DKStringToolkit trimCapitalTInDateFromServer:dateTime];
    }
}

+ (NSString *)dateStringWithDateTimeString:(NSString *)dateTime dateFormat:(DKDateToolkitDateFormatType)dateFormatType timeFormat:(DKDateToolkitTimeFormatType)timeFormatType needSpaceBetween:(BOOL)needSpace
{
    [self initDateFormatter];
    NSString *format = [NSString stringWithFormat:@"%@%@%@", [self generateDateFormatWithType:dateFormatType], needSpace ? @" " : @"", [self generateTimeFormatWithType:timeFormatType]];
    [dateFormatter setDateFormat:format];
    
    NSString *result = nil;
    NSDate *date = [dateFormatter dateFromString:dateTime];
    NSTimeInterval timeStamp = [date timeIntervalSince1970];
    
    NSDate *now = [NSDate date];
    NSTimeInterval currentTimeStamp = [now timeIntervalSince1970];
    // 计算当前时区与UTC的相差秒数
    NSInteger timeZoneOffset = [[NSTimeZone localTimeZone] secondsFromGMTForDate:now];
    // 计算差值，单位为“秒”,还要减去当前时区与utc的差值
    NSTimeInterval minusValue = currentTimeStamp - timeStamp - timeZoneOffset;
    if (minusValue <= 10) {
        result = @"刚刚";
    } else if (minusValue < 3600) {
        result = [NSString stringWithFormat:@"%.0f分钟前", minusValue / 60];
    } else if (minusValue < (3600 * 24)) {
        result = [NSString stringWithFormat:@"%.0f小时前", minusValue / 3600];
    } else if (minusValue < (3600 * 24 * 2)) {
        result = @"昨天";
    } else {
        result = dateTime;
    }
    
    return result;
}

+ (NSString *)dateStringWithDateTimeString:(NSString *)dateTime
{
    return [self dateStringWithDateTimeString:dateTime dateFormat:DKDateToolkitDateFormatTypeHyphen timeFormat:DKDateToolkitTimeFormatTypeColon needSpaceBetween:YES];
}

#pragma mark - 类内部方法
+ (void)initDateFormatter
{
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
}

+ (NSString *)generateDateFormatWithType:(DKDateToolkitDateFormatType)type
{
    NSString *formerFormatString = nil;
    NSString *laterFormatString = nil;
    NSString *afterDayFormatString = @"";
    switch (type) {
        case DKDateToolkitDateFormatTypeNone:
            formerFormatString = @"";
            laterFormatString = formerFormatString;
            break;
        case DKDateToolkitDateFormatTypeDiagonal:
            formerFormatString = @"/";
            laterFormatString = formerFormatString;
            break;
        case DKDateToolkitDateFormatTypeYearMonthDayInChinese:
            formerFormatString = @"年";
            laterFormatString = @"月";
            afterDayFormatString = @"日";
            break;
        case DKDateToolkitDateFormatTypeHyphen:
        default:
            formerFormatString = @"-";
            laterFormatString = formerFormatString;
            break;
    }
    
    return [NSString stringWithFormat:@"yyyy%@MM%@dd%@", formerFormatString, laterFormatString, afterDayFormatString];
}

+ (NSString *)generateTimeFormatWithType:(DKDateToolkitTimeFormatType)type
{
    NSString *formerFormatString = nil;
    NSString *laterFormatString = nil;
    switch (type) {
        case DKDateToolkitTimeFormatTypeNone:
            formerFormatString = @"";
            laterFormatString = formerFormatString;
            break;
        case DKDateToolkitTimeFormatTypeColon:
        default:
            formerFormatString = @":";
            laterFormatString = formerFormatString;
            break;
    }
    
    return [NSString stringWithFormat:@"HH%@mm%@ss", formerFormatString, laterFormatString];
}
@end
