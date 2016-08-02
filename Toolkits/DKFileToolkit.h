//
//  DKFileToolkit.h
//  DKToolkits
//
//  Created by xuli on 16/7/22.
//  Copyright © 2016年 dk-coder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKFileToolkit : NSObject

/**
 *  在指定的沙盒路径下创建文件夹
 *
 *  @param path 沙盒路径
 */
+ (void)createFolderPath:(NSString *)path;

/**
 *  获取沙盒中的下载路径(默认下载路径不存在，需要手动创建downloads目录)
 *
 *  @return 
 */
+ (NSString *)downloadPath;

/**
 *  获取指定沙盒路径下的文件集合
 *
 *  @param path 指定的沙盒路径
 *
 *  @return 返回路径下的所有文件集合
 */
+ (NSArray *)AllFilesAtPath:(NSString *)path;

/**
 *  判断某个文件是否已下载(是否已在downloads目录下)，fileName为文件名(不包括扩展名)
 */
+ (BOOL)isExitsAtDownloadPathWithFileName:(NSString *)fileName;

/**
 *  获取文件的扩展名
 *
 *  @param path 文件名
 *
 *  @return 扩展名
 */
+ (NSString *)fileExtension:(NSString *)path;

/**
 *  删除指定沙盒路径下的文件
 *
 *  @param path 文件的绝对路径
 *
 *  @return YES表示删除成功，NO表示删除失败
 */
+ (BOOL)deleteFileAtPath:(NSURL *)path;

/**
 *  获取临时目录的大小
 *
 *  @return 临时目录的大小
 */
+ (NSString *)tempDirectorySize;

/**
 *  清空临时目录下的文件
 *
 *  @return YES表示成功，NO表示失败
 */
+ (BOOL)clearTempDirectory;

/**
 *  将文件的大小的“字节数”转换为以K、M、G为单位的数字
 *
 *  @param fileSize 字节数
 *
 *  @return 
 */
+ (NSString *)fileSizeFromCGFloat:(float)fileSize;
@end
