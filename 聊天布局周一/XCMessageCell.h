//
//  XCMessageCell.h
//  聊天布局周一
//
//  Created by liuxingchen on 16/9/26.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XCMessage;
@interface XCMessageCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)XCMessage * message ;
@end
