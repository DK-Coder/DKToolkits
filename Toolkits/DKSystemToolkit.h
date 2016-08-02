//
//  DKSystemToolkit.h
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKSystemToolkit : NSObject

/**
 *  获取iOS版本
 *
 *  @return 
 */
+ (float)systemVersion;

/**
 *  获取app的版本号
 *
 *  @return 
 */
+ (float)appVersion;

/**
 *  获取app的名称
 *
 *  @return 
 */
+ (NSString *)appName;

/**
 *  获取设备的机型，比如是iPhone或者iPod或者iPad
 *
 *  @return
 */
+ (NSString *)deviceModel;

/**
 *  获取设备名称
 *
 *  @return
 */
+ (NSString *)deviceName;

/**
 *  获取设备平台的名称，比如iPhone5或者iPhone6。（模拟器无效）
 *
 *  @return 
 */
+ (NSString *)devicePlatform;
@end
