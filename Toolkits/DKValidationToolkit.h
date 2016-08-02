//
//  DKValidationToolkit.h
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKValidationToolkit : NSObject

/**
 *  验证中国地区手机号格式
 *
 *  @param phoneNumber 11位手机号
 *
 *  @return YES表示格式正确，NO表示格式错误
 */
+ (BOOL)validatePhoneNumber:(NSString *)phoneNumber;

/**
 *  验证是否为纯数字
 *
 *  @param str 待验证的字符串
 *
 *  @return YES表示str为纯数字，NO表示str不是纯数字
 */
+ (BOOL)validatePureNumber:(NSString *)str;

/**
 *  验证字符串是否包含除英文字母和数字之外的字符
 *
 *  @param str 待验证的字符串
 *
 *  @return YES表示str只包含英文字母与数字，NO反之
 */
+ (BOOL)validateAlphaAndNumberic:(NSString *)str;

/**
 *  验证是否为格式正确的小数
 *
 *  @param str 待验证的字符串
 *
 *  @return YES表示str为正确的小数，NO表示str不是正确的小数
 */
+ (BOOL)validateDigitalNumber:(NSString *)str;

/**
 *  验证身份证号码格式
 *
 *  @param value 待验证的字符串
 *
 *  @return YES表示是格式正确的身份证号码，NO表示不是格式正确的数字
 */
+ (BOOL)validateIDCardNumber:(NSString *)value;

/**
 *  验证电子邮箱Email格式是否正确
 *
 *  @param email 待验证的字符串
 *
 *  @return YES表示为格式正确的电子邮箱，NO表示电子邮箱格式错误
 */
+ (BOOL)validateEmailFormat:(NSString *)email;
@end
