//
//  DKStringToolkit.h
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKStringToolkit : NSObject

/**
 *  去除字符串两边的空格
 *
 *  @param needTrim 需要去空格的字符串
 *
 *  @return 去除空格后的字符串
 */
+ (NSString *)stringTrimWhiteSpace:(NSString *)needTrim;

/**
 *  去除小数点后为0的小数，比如将1.0变成1
 *
 *  @param number 需要去小数点后为0的数字
 *
 *  @return 去除小数点后为0的数字
 */
+ (NSString *)trimFirstDigitZero:(float)number;

/**
 *  将服务器返回的long类型的数字从字典中取出后，变成字符串类型
 *
 *  @param obj 需要转换成字符串类型的long类型数字
 *
 *  @return 变成字符串类型的数字
 */
+ (NSString *)parseObjectTypeToString:(id)obj;

/**
 *  去除服务器传回带有T日期中的T
 *
 *  @param needTrim 需要去T的字符串
 *
 *  @return 去除T后的字符串
 */
+ (NSString *)trimCapitalTInDateFromServer:(NSString *)dateTime;

/**
 *  将服务器返回的带有T的日期进行分割，返回数组中包含日期以及时间
 *
 *  @param needTrim 需要分割的时间日期
 *
 *  @return 分割后的时间日期
 */
+ (NSArray *)parseDateTimeStringToArray:(NSString *)dateTime;

/**
 *  将服务器返回的带有"-"的日期变成中文的年月日
 *
 *  @param date 从服务器获取的日期
 *
 *  @return 变成年月日格式的日期
 */
+ (NSString *)replaceLineToYearAndMonthAndDay:(NSString *)date;

/**
 *  将服务器返回的<null>值替换成空字符串@""
 *
 *  @param str 从服务器获取的时间
 *
 *  @return 空字符串@""
 */
+ (NSString *)replaceNullToEmpty:(id)str;

+ (BOOL)isString:(NSString *)originStr containsString:(NSString *)str;

/**
 *  根据最大记录条数和每页记录数计算总共有多少页
 */
+ (int)getTotalPageNumberByTotalResultCounts:(int)totalCounts pageCount:(int)pageCount;
@end
