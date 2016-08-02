//
//  DKEncryptionToolkit.h
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKEncryptionToolkit : NSObject

/**
 *  生成32位MD5加密后的字符串，小写
 *
 *  @param needEncrption 需要加密的字符串
 *
 *  @return 加密后的32位小写字符串
 */
+ (NSString *)MD5With32InLowerCase:(NSString *)needEncrption;

/**
 *  生成32位MD5加密后的字符串，大写
 *
 *  @param needEncrption 需要加密的字符串
 *
 *  @return 加密后的32位大写字符串
 */
+ (NSString *)MD5With32InUpperCase:(NSString *)needEncrption;

/**
 *  base64加密
 *
 *  @param needEncrption 需要加密的字符串
 *
 *  @return base64加密后的字符串
 */
+ (NSString *)base64Encrption:(NSString *)needEncrption;

/**
 *  base64解密
 *
 *  @param needDecoded 需要base64解密的字符串
 *
 *  @return base64解密后的字符串
 */
+ (NSString *)base64Decoded:(NSString *)needDecoded;

/**
 *  将json字符串转换成字典
 *
 *  @param jsonString json字符串
 *
 *  @return 字典
 */
+ (NSDictionary *)getJsonByJsonString:(NSString *)jsonString;
@end
