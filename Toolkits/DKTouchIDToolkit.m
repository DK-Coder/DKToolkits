//
//  DKTouchIDToolkit.m
//  DKToolkits
//
//  Created by NSLog on 2017/7/28.
//  Copyright © 2017年 dk-coder. All rights reserved.
//

#import "DKTouchIDToolkit.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "DKDefine.h"

static LAContext *context;

@implementation DKTouchIDToolkit

+ (NSString *)canUseTouchID
{
    if (!context) {
        context = [[LAContext alloc] init];
    }
    NSError *error = nil;
    NSString *result = nil;
    
    [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    if (error) {
        result = [self getErrorMessageWithCode:error.code];
    }
    
    return result;
}

+ (void)verifyFingerWithTitle:(NSString *)title complete:(evaluateCompleteBlock)block fallBack:(evaluateFallBackBlock)fallback
{
    NSString *message = [self canUseTouchID];
    if (!message) {
        // 可以使用Touch ID
        weakifySelf();
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:title reply:^(BOOL success, NSError * _Nullable error) {
            strongifySelf();
            NSString *errorMessage = [strongSelf getErrorMessageWithCode:error.code];
            if ([errorMessage isEqualToString:@"输入密码"]) {
                if (fallback) {
                    fallback(YES);
                }
            } else if (block) {
                block(success, errorMessage);
            }
        }];
    } else {
        // Touch ID不可用
        if (block) {
            block(NO, message);
        }
    }
}

+ (NSString *)getErrorMessageWithCode:(NSInteger)code
{
    NSString *errorMessage = nil;
    switch (code) {
        case LAErrorTouchIDNotEnrolled:
            errorMessage = @"请先在设备上注册您的指纹";
            break;
        case LAErrorPasscodeNotSet:
            errorMessage = @"请先在设备上设置密码";
            break;
        case LAErrorTouchIDNotAvailable:
            errorMessage = @"该设备不支持Touch ID";
            break;
        case LAErrorAuthenticationFailed:
            errorMessage = @"验证错误，请重新验证";
            break;
        case LAErrorUserFallback:
            errorMessage = @"输入密码";
            break;
        case LAErrorUserCancel:
            errorMessage = @"用户已取消";
            break;
        case LAErrorAppCancel:
        case LAErrorSystemCancel:
            errorMessage = @"过程被终止";
            break;
        case LAErrorTouchIDLockout:
            errorMessage = @"Touch ID被锁定";
            break;
        default:
            break;
    }
    
    return errorMessage;
}
@end
