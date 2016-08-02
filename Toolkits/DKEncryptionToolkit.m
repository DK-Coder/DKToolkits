//
//  DKEncryptionToolkit.m
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKEncryptionToolkit.h"
#import <CommonCrypto/CommonDigest.h>

@implementation DKEncryptionToolkit

+ (NSString *)MD5With32InLowerCase:(NSString *)needEncrption
{
    const char *cStr = [needEncrption UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (NSString *)MD5With32InUpperCase:(NSString *)needEncrption
{
    const char *cStr = [needEncrption UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (int)strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

+ (NSString *)base64Encrption:(id)needEncrption
{
    NSString *string = [NSString stringWithFormat:@"%@", needEncrption];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

+ (NSString *)base64Decoded:(NSString *)needDecoded
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:needDecoded options:0];
    
    NSString *decodedString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return decodedString;
}

+ (NSDictionary *)getJsonByJsonString:(NSString *)jsonString
{
    if (!jsonString || !jsonString.length) {
        return nil;
    }
    jsonString = [self removeUnescapedCharacter:jsonString];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dictJson = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        return nil;
    }
    return dictJson;
}

+ (NSString *)removeUnescapedCharacter:(NSString *)inputStr
{
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];
    if (range.location != NSNotFound) {
        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];
        while (range.location != NSNotFound) {
            [mutable deleteCharactersInRange:range];
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputStr;
}
@end
