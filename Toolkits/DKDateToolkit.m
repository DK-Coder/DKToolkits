//
//  DKDateToolkit.m
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKDateToolkit.h"
#import "DKStringToolkit.h"

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
@end
