//
//  UploadImageInformationObject.m
//  Networking-testTwo
//
//  Created by WangQiao on 16/8/16.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "UploadImageInformationObject.h"
#import <UIKit/UIKit.h>

@implementation UploadImageInformationObject

+ (instancetype)uploadImageInformationObjectWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType {

    UploadImageInformationObject *obj = [[[self class] alloc] init];
    
    obj.data     = data;
    obj.name     = name;
    obj.fileName = fileName;
    obj.mimeType = mimeType;
    
    return obj;
}

@end
