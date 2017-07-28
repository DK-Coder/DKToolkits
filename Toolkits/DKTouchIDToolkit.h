//
//  DKTouchIDToolkit.h
//  DKToolkits
//
//  Created by NSLog on 2017/7/28.
//  Copyright © 2017年 dk-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^evaluateCompleteBlock)(BOOL success, NSString *result);
typedef void(^evaluateFallBackBlock)(BOOL fallback);

@interface DKTouchIDToolkit : NSObject

/**
 *  Touch ID是否可用，如果可用返回nil，不可用返回原因
 */
+ (NSString *)canUseTouchID;

/**
 *  验证Touch ID
 */
+ (void)verifyFingerWithTitle:(NSString *)title complete:(evaluateCompleteBlock)block fallBack:(evaluateFallBackBlock)fallback;
@end
