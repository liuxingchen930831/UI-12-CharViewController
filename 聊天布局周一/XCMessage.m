//
//  XCMessage.m
//  聊天布局周一
//
//  Created by liuxingchen on 16/9/26.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "XCMessage.h"

@implementation XCMessage
+(instancetype)messageWithDict:(NSDictionary *)dict
{
    XCMessage *message =[[self alloc]init];
    [message setValuesForKeysWithDictionary:dict];
    return message;
}
@end
