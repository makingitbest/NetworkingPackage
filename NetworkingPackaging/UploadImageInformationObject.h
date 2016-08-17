//
//  UploadImageInformationObject.h
//  Networking-testTwo
//
//  Created by WangQiao on 16/8/16.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadImageInformationObject : NSObject

/**
 *  The data to be encoded and appended to the form data.
 */
@property (nonatomic, strong) NSData  *data;

/**
 *  The name to be associated with the specified data. This parameter must not be `nil`.
 */
@property (nonatomic, strong) NSString *name;

/**
 *  The filename to be associated with the specified data. This parameter must not be `nil`.
 */
@property (nonatomic, strong) NSString *fileName;

/**
 *  The MIME type of the specified data. (For example, the MIME type for a JPEG image is image/jpeg.) For a list of valid MIME types, see http://www.iana.org/assignments/media-types/. This parameter must not be `nil`.
 */
@property (nonatomic, strong) NSString *mimeType;

/**
 *  图片信息的传入
 *
 *  @param data     data
 *  @param name     name
 *  @param fileName fileName
 *  @param mimeType mimeType
 *
 *  @return UploadImageInformationObject对象
 */
+ (instancetype)uploadImageInformationObjectWithData:(NSData *)data name:(NSString *)name
                                            fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end
