//
//  DKSystemToolkit.m
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKSystemToolkit.h"
#import <UIKit/UIKit.h>

@implementation DKSystemToolkit

+ (float)systemVersion
{
    return [[UIDevice currentDevice].systemVersion floatValue];
}
@end
