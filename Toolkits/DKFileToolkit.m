//
//  DKFileToolkit.m
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import "DKFileToolkit.h"
#import "DKStringToolkit.h"

@implementation DKFileToolkit

+ (void)createFolderPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *downloadFolderPath = [self downloadPath];
    if (![fileManager fileExistsAtPath:downloadFolderPath]) {
        [fileManager createDirectoryAtPath:downloadFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

+ (NSString *)downloadPath
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"downloads"];
}

+ (NSArray *)AllFilesAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager subpathsAtPath:path];
}

+ (BOOL)isExitsAtDownloadPathWithFileName:(NSString *)fileName
{
    NSArray *array = [self AllFilesAtPath:[self downloadPath]];
    for (NSString *name in array) {
        if ([name isEqualToString:fileName]) {
            return YES;
        }
    }
    return NO;
}

+ (NSString *)fileExtension:(NSString *)path
{
    return [path pathExtension];
}

+ (BOOL)deleteFileAtPath:(NSURL *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL removeSuccess = [fileManager removeItemAtURL:path error:&error];
    if (!error) {
        return removeSuccess;
    } else {
        return NO;
    }
}

+ (NSString *)tempDirectorySize
{
    NSString *tempPath = NSTemporaryDirectory();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    float folderSize = 0.f;
    if ([fileManager fileExistsAtPath:tempPath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:tempPath];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[tempPath stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        //        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return [self fileSizeFromCGFloat:folderSize];
    }
    return @"0字节";
}

+ (unsigned long long)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        unsigned long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    return 0;
}

+ (BOOL)clearTempDirectory
{
    NSString *tempPath = NSTemporaryDirectory();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:tempPath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:tempPath];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[tempPath stringByAppendingPathComponent:fileName];
            BOOL isSuccess = [self deleteFileAtPath:[NSURL fileURLWithPath:absolutePath]];
            if (!isSuccess) {
                return NO;
            }
        }
    }
    return YES;
}

+ (NSString *)getSizeUnitByDivideTimes:(int)times
{
    switch (times) {
        case 1:
            return @"K";
            break;
        case 2:
            return @"M";
            break;
        case 3:
            return @"G";
            break;
        default:
            return @"字节";
            break;
    }
}

+ (NSString *)fileSizeFromCGFloat:(float)fileSize
{
    int divideTimes = 0;
    while (fileSize > 1024.f) {
        divideTimes++;
        fileSize /= 1024.f;
    }
    
    return [NSString stringWithFormat:@"%@%@", [DKStringToolkit trimFirstDigitZero:fileSize], [self getSizeUnitByDivideTimes:divideTimes]];
}
@end
