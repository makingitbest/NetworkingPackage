//
//  Networking.m
//  Networking-testTwo
//
//  Created by WangQiao on 16/8/16.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "Networking.h"
#import "AFNetworking.h"

@interface Networking ()

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) AFHTTPSessionManager *session;

@end

@implementation Networking

- (instancetype)init {
    
    if (self = [super init]) {
        
        self.session  = [AFHTTPSessionManager manager];
        
        self.session.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"text/html",@"text/plain",@"application/json"]];
    }
    
    return self;
}

- (void)startRequest {
    
    if (self.requestBodyType == kHTTPBodyType) {
        
        self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
        
    } else if (self.requestBodyType == kJSONBodyType) {
        
        self.session.requestSerializer = [AFJSONRequestSerializer serializer];
        
    } else if (self.requestBodyType == kPlistBodyType) {
        
        self.session.requestSerializer = [AFPropertyListRequestSerializer serializer];
        
    } else {
        
        self.session.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    if (self.responseDataType == kHTTPResponseType) {
        
        self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    } else if (self.responseDataType == kJSONResponseType) {
        
        self.session.responseSerializer = [AFJSONResponseSerializer serializer];
        
    } else {
        
        self.session.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    if (self.requestMethod == kGETMethodType) {
        
        self.dataTask = [self.session GET:self.urlString parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(netwrokingSuccess:data:)]) {
                
                [self.delegate netwrokingSuccess:self data:responseObject];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(networkingFailed:error:)]) {
                
                [self.delegate networkingFailed:self error:error];
            }
        }];
        
    } else if (self.requestMethod == kPOSTMethodType) {
        
        self.dataTask = [self.session POST:self.urlString parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(netwrokingSuccess:data:)]) {
                
                [self.delegate netwrokingSuccess:self data:responseObject];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(networkingFailed:error:)]) {
                
                [self.delegate networkingFailed:self error:error];
            }
        }];
        
    } else if (self.requestMethod == kUpLoadMethodType) {
    
        self.dataTask = [self.session POST:self.urlString parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [self.imageObjects enumerateObjectsUsingBlock:^(UploadImageInformationObject *obj, NSUInteger idx, BOOL *stop) {
                
                [formData appendPartWithFileData:obj.data name:obj.name fileName:obj.fileName mimeType:obj.mimeType];
            }];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(netwrokingSuccess:data:)]) {
                
                [self.delegate netwrokingSuccess:self data:responseObject];
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(networkingFailed:error:)]) {
                
                [self.delegate networkingFailed:self error:error];
            }
        }];
    }
}

- (void)cancleRequest {
    
    [self.dataTask cancel];
}

+ (instancetype)networkingWithUrlString:(NSString *)urlString
                       requestParameter:(id)parameter
                               delegate:(id <NetworkingDelegate>)delegate
                            requestBody:(ERequestBodyType)requestBodyType
                       responseDataType:(EResponseDataType)responseDataType
                          requestMethod:(ERequestMethod)requestMethod {
    
    Networking *networking      = [[[self class] alloc] init];
    networking.delegate         = delegate;
    networking.urlString        = urlString;
    networking.parameters       = parameter;
    networking.requestBodyType  = requestBodyType;
    networking.responseDataType = responseDataType;
    networking.requestMethod    = requestMethod;
    
    return networking;
}

+ (instancetype)uploadPicturesWithUrlString:(NSString *)urlString
                           requestParameter:(id)parameter
                               imageObjects:(NSArray <UploadImageInformationObject *> *)imageObjects
                                   delegate:(id <NetworkingDelegate>)delegate
                                requestBody:(ERequestBodyType)requestBodyType
                           responseDataType:(EResponseDataType)responseDataType {

    Networking *networking      = [[[self class] alloc] init];
    networking.delegate         = delegate;
    networking.urlString        = urlString;
    networking.parameters       = parameter;
    networking.requestBodyType  = requestBodyType;
    networking.responseDataType = responseDataType;
    networking.requestMethod    = kUpLoadMethodType;
    networking.imageObjects     = imageObjects;
    
    return networking;
}

@end
