//
//  DKDefine.h
//  DKToolkits
//
//  Created by NSLog on 2017/7/28.
//  Copyright © 2017年 dk-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

#define weakifySelf() weakify(self, weakSelf)
#define weakify(object, objectName) __weak typeof(object) objectName = object
#define strongify(object, objectName) __strong typeof(object) objectName = object
#define strongifySelf() strongify(weakSelf, strongSelf)

@interface DKDefine : NSObject

@end
