//
//  Networking.h
//  Networking-testTwo
//
//  Created by WangQiao on 16/8/16.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadImageInformationObject.h"

/**
 处理请求题的类型
 */
typedef enum : NSUInteger {
    
    kHTTPBodyType,
    kJSONBodyType,
    kPlistBodyType,
    
} ERequestBodyType;

/**
 返回数据的类型
 */
typedef enum : NSUInteger {
    
    kHTTPResponseType,
    kJSONResponseType,
    
} EResponseDataType;

/**
 网络请求的方式
 */
typedef enum : NSUInteger {
    
    kGETMethodType,
    kPOSTMethodType,
    kUpLoadMethodType,
    
} ERequestMethod;

@class Networking;

@protocol NetworkingDelegate <NSObject>

/**
 *  请求成功
 *
 *  @param networking networking
 *  @param data       请求的数据
 */
- (void)netwrokingSuccess:(Networking *)networking data:(id)data;

/**
 *  请求失败
 *
 *  @param networking networking
 *  @param error      请求失败
 */
- (void)networkingFailed:(Networking *)networking error:(NSError *)error;

@end

@interface Networking : NSObject

@property (nonatomic, weak) id <NetworkingDelegate> delegate;

/**
 *  网址
 */
@property (nonatomic, strong) NSString *urlString;

/**
 *  传入的参数
 */
@property (nonatomic, strong) id  parameters;

/**
 *  请求body类型
 */
@property (nonatomic) ERequestBodyType requestBodyType;

/**
 *  返回数据的类型
 */
@property (nonatomic) EResponseDataType responseDataType;

/**
 *  网络请求方式
 */
@property (nonatomic) ERequestMethod requestMethod;

/**
 *  网络请求的tag值,方便区分多个网络请求在同一个控制器中
 */
@property (nonatomic) NSInteger tag;

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray <UploadImageInformationObject *> *imageObjects;

/**
 *  开始请求
 */
- (void)startRequest;

/**
 *  取消请求
 */
- (void)cancleRequest;

#pragma mark - 便利构造器

/**
 *  网络请求(可以是GE或者是POST)
 *
 *  @param urlString        网址
 *  @param parameter        网址的参数
 *  @param delegate         网络代理
 *  @param requestBodyType  请求body的类型
 *  @param responseDataType 回复参数的类型
 *  @param requestMethod    请求的方法,GET或者POST .在这里更改
 *
 *  @return networking
 */
+ (instancetype)networkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)parameter
                               delegate:(id <NetworkingDelegate>)delegate
                            requestBody:(ERequestBodyType)requestBodyType
                       responseDataType:(EResponseDataType)responseDataType
                          requestMethod:(ERequestMethod)requestMethod;

/**
 *  网络请求(Upload请求)
 *
 *  @param urlString        网址
 *  @param parameter        网址的参数
 *  @param imageObjects     上传的图片信息
 *  @param delegate         网络代理
 *  @param requestBodyType  请求的body类型
 *  @param responseDataType 回复参数的类型
 *
 *  @return networking
 */
+ (instancetype)uploadPicturesWithUrlString:(NSString *)urlString
                           requestParameter:(id)parameter
                               imageObjects:(NSArray <UploadImageInformationObject *> *)imageObjects
                                   delegate:(id <NetworkingDelegate>)delegate
                                requestBody:(ERequestBodyType)requestBodyType
                           responseDataType:(EResponseDataType)responseDataType;

@end
