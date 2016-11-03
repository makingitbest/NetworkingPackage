//
//  ViewController.m
//  NetworkingPackaging
//
//  Created by WangQiao on 16/8/17.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewController.h"
#import "Networking.h"
#import "UploadImageInformationObject.h"

typedef enum : NSUInteger {
    
    kGetRequestTag,
    kPostRequestTag,
    kUploadRequestTypeOneTag,
    kUploadRequestTypeTwoTag,
    
} ERequestTag;

@interface ViewController ()<NetworkingDelegate>

@property (nonatomic, strong)Networking *uploadOneNetworking;
@property (nonatomic, strong)Networking *uploadTwoNetworking;
@property (nonatomic, strong)Networking *getNetworking;
@property (nonatomic, strong)Networking *postNetworking;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    {
        self.uploadOneNetworking              = [[Networking alloc] init];
        self.uploadOneNetworking.urlString    = @"http://101.201.78.24/api/user/update";
        self.uploadOneNetworking.parameters   = @{@"auth_token"          : @"MTksODE2NTk=",
                                                  @"birthday"            : @"1991-03-21",
                                                  @"city"                : @"",
                                                  @"email"               : @"",
                                                  @"followActivityTypes" : @"",
                                                  @"followScopes"        : @"18,14,10,6",
                                                  @"nickname"            : @"Lady-Wang",
                                                  @"realname"            : @"王同学"};
        self.uploadOneNetworking.requestBodyType   = kHTTPBodyType;
        self.uploadOneNetworking.responseDataType  = kJSONResponseType;
        self.uploadOneNetworking.requestMethod     = kUpLoadMethodType;
        self.uploadOneNetworking.delegate          = self;
        self.uploadOneNetworking.tag               = kUploadRequestTypeOneTag;
        self.uploadOneNetworking.networkInfomation = @"上传图片数据的第一种请求";

        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat       = @"yyyyMMddHHmmss";
        NSString *imageName        = [formatter stringFromDate:[NSDate date]];
        NSString *fileName         = [NSString stringWithFormat:@"%@.jpg",imageName];
        NSData *imageData          = UIImageJPEGRepresentation([UIImage imageNamed:@"17700521"], 1);
        NSLog(@"upload image size: %ld k", (long)(imageData.length / 1024));
        
        UploadImageInformationObject *infoObject = [UploadImageInformationObject uploadImageInformationObjectWithData:imageData
                                                                                                                 name:@"file"
                                                                                                             fileName:fileName
                                                                                                             mimeType:@"image/png"];
        self.uploadOneNetworking.imageObjects    = @[infoObject];
        [self.uploadOneNetworking startRequest];
    }
    
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat       = @"yyyyMMddHHmmss";
        NSString *imageName        = [formatter stringFromDate:[NSDate date]];
        NSString *fileName         = [NSString stringWithFormat:@"%@.jpg",imageName];
        NSData *imageData          = UIImageJPEGRepresentation([UIImage imageNamed:@"17700521"], 1);
        NSLog(@"upload image size: %ld k", (long)(imageData.length / 1024));
        
        UploadImageInformationObject *infoObject = [UploadImageInformationObject uploadImageInformationObjectWithData:imageData
                                                                                                                 name:@"file"
                                                                                                             fileName:fileName
                                                                                                             mimeType:@"image/png"];
        self.uploadTwoNetworking.imageObjects = @[infoObject];
        
        self.uploadTwoNetworking = [Networking uploadPicturesWithUrlString:@"http://101.201.78.24/api/user/update"
                                                          requestParameter:@{@"auth_token"          : @"MTksODE2NTk=",
                                                                             @"birthday"            : @"1991-03-10",
                                                                             @"city"                : @"",
                                                                             @"email"               : @"",
                                                                             @"followActivityTypes" : @"",
                                                                             @"followScopes"        : @"18,14,10,6",
                                                                             @"nickname"            : @"Lady-Wang",
                                                                             @"realname"            : @"隔壁老王"}
                                                              imageObjects:@[infoObject]
                                                                  delegate:self
                                                               requestBody:kHTTPBodyType
                                                          responseDataType:kJSONResponseType];
        self.uploadTwoNetworking.networkInfomation = @"上传图片数据的第二种请求";
        self.uploadTwoNetworking.tag = kUploadRequestTypeTwoTag;
        [self.uploadTwoNetworking startRequest];
    }
    
    {
        self.getNetworking = [Networking networkingWithUrlString:@"http://api.chuandazhiapp.com/v2/channels/5/items?limit=20&offset=0&gender=2&generation=1"
                                                requestParameter:nil
                                                        delegate:self
                                                     requestBody:kHTTPBodyType
                                                responseDataType:kJSONResponseType
                                                   requestMethod:kGETMethodType];
        self.getNetworking.networkInfomation = @"get 请求";
        self.getNetworking.tag               = kGetRequestTag;
        [self.getNetworking startRequest];
    }
    
    {
        self.postNetworking = [Networking networkingWithUrlString:@"http://act.techcode.com/api/company/view?id=33340"
                                                 requestParameter:nil
                                                         delegate:self
                                                      requestBody:kHTTPBodyType
                                                 responseDataType:kJSONResponseType
                                                    requestMethod:kPOSTMethodType];
        self.postNetworking.networkInfomation = @"post 请求";
        self.postNetworking.tag               = kPostRequestTag;
        [self.postNetworking startRequest];
    }
}

- (void)netwrokingSuccess:(Networking *)networking data:(id)data {
    
    if (networking.tag == kGetRequestTag) {
        
        NSLog(@"GET请求成功");
        NSLog(@"GET请求成功\n data = %@",data);
        
    }  else if (networking.tag == kPostRequestTag) {
        
        NSLog(@"POST请求成功");
        NSLog(@"POST请求成功 data是字典 \n： data= %@",data);
        
    }else if (networking.tag  == kUploadRequestTypeOneTag) {
        
        NSLog(@"上传图片相关信息的第一种方法成功\n data= %@",data);
        
    } else if (networking.tag == kUploadRequestTypeTwoTag) {
        
        NSLog(@"上传图片相关信息的第二种方法成功\n data= %@",data);
        
    }
}

- (void)networkingFailed:(Networking *)networking error:(NSError *)error {
    
    
    if (networking.tag == kGetRequestTag) {
        
        NSLog(@"\nGET请求\n error = %@",error);
        
    }  else if (networking.tag == kPostRequestTag) {
        
        NSLog(@"\nPOST请求\n error = %@",error);
        
    }else if (networking.tag  == kUploadRequestTypeOneTag) {
        
        NSLog(@"\n上传图片相关信息的第一种方法error = %@",error);
        
    } else if (networking.tag == kUploadRequestTypeTwoTag) {
        
        NSLog(@"\n上传图片相关信息的第二种方法error = %@",error);
    }
}

- (void)dealloc {
    
    [self.uploadOneNetworking cancleRequest];
    [self.uploadTwoNetworking cancleRequest];
    [self.getNetworking       cancleRequest];
    [self.postNetworking      cancleRequest];
}

@end
