//
//  DKDateToolkit.h
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ReturnDateTimeType) {
    ReturnDateTimeTypeAll = 0, /**< 需要返回除T之外的所有时间*/
    ReturnDateTimeTypeDate, /**< 需要返回日期*/
    ReturnDateTimeTypeTime /**< 需要返回时间*/
};

typedef NS_ENUM(NSUInteger, DKDateToolkitDateFormatType) {
    DKDateToolkitDateFormatTypeHyphen = 0, /**< 连字符 -*/
    DKDateToolkitDateFormatTypeYearMonthDayInChinese, /**< 年月日中文*/
    DKDateToolkitDateFormatTypeDiagonal, /**< 斜线 /*/
    DKDateToolkitDateFormatTypeNone
};

typedef NS_ENUM(NSUInteger, DKDateToolkitTimeFormatType) {
    DKDateToolkitTimeFormatTypeColon = 0, /**< 冒号 :*/
    DKDateToolkitTimeFormatTypeNone
};

@interface DKDateToolkit : NSObject

/**
 *  将秒数转换成时分秒格式的字符串,formatType为1转换成“冒号”分隔的时分秒，formatType为2转换成文字格式的时分秒
 */
+ (NSString *)parseTimeToFormat:(int)formatType timeInSecond:(NSInteger)timeInSecond;

+ (NSString *)getCurrentDateWithFormatter:(NSString *)formatter;

/**
 *  将服务器返回的带有T的日期进行处理，
 *
 *  @param dateTime 从服务器获取的时间
 *  @param returnType 需要返回的时间类型
 *
 *  @return 分割后的时间日期
 */
+ (NSString *)getOneTypeOfDateTime:(NSString *)dateTime returnType:(ReturnDateTimeType)returnType;

/**
 *  根据传入的时间戳与现在的时间戳进行对比，返回相应的日期相关的字符串
 *  比如：“今天”，”昨天“， ”刚刚“ 等
 */
+ (NSString *)dateStringWithDateTimeString:(NSString *)dateTime dateFormat:(DKDateToolkitDateFormatType)dateFormatType timeFormat:(DKDateToolkitTimeFormatType)timeFormatType needSpaceBetween:(BOOL)needSpace;

/**
 *  根据传入的时间戳与现在的时间戳进行对比，返回相应的日期相关的字符串
 *  比如：“今天”，”昨天“， ”刚刚“ 等
 *  注意！！传入的日期格式必须为： yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)dateStringWithDateTimeString:(NSString *)dateTime;

/**
 *  满足奇葩需求，获取当前时间与某个时间点之间均等分后的每个时间点
 * @param timeStr 某个时间点，可以是时间点一整串08:00:00，也可以是整点数字8，也可以是08
 * @param amount 需要均等分成多少份的份数
 * @param className 数组中存储的类型，默认返回NSDate，也支持NSString类型
 * @return 返回字典中。key表示某个的时间点，value表示这个时间点距离timeStr的秒数
 */
- (NSDictionary *)divideTimeIntervalFromTime:(NSString *)timeStr into:(NSUInteger)amount returnType:(Class)className;
@end
