//
//  XCMessage.h
//  聊天布局周一
//
//  Created by liuxingchen on 16/9/26.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum NSInteger{
    MessageTypeMe = 0,
    MessageTypeOther = 1
} MessageType;
@interface XCMessage : NSObject
@property(nonatomic,strong)NSString * text ;
@property(nonatomic,strong)NSString * time ;
@property(nonatomic,assign)MessageType type ;
@property(nonatomic,assign)CGFloat cellHeigth;
+(instancetype)messageWithDict:(NSDictionary *)dict;
@property(nonatomic,assign,getter=isHidden)BOOL timeHidden;
@end
