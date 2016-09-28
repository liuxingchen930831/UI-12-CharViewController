//
//  XCMessageCell.m
//  聊天布局周一
//
//  Created by liuxingchen on 16/9/26.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "XCMessageCell.h"
#import "XCMessage.h"
#import "Masonry.h"
@interface XCMessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIImageView *meIcon;

@property (weak, nonatomic) IBOutlet UIImageView *otherIcon;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;

@end
@implementation XCMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.messageBtn.titleLabel.numberOfLines = 0 ;
    self.otherBtn.titleLabel.numberOfLines = 0 ;
    //设置button的内边距距离上
    self.messageBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
    self.otherBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 20);
}

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"messageCell";
    XCMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    }
    return cell;
}
-(void)setMessage:(XCMessage *)message
{
    _message = message;
    
    if (message.timeHidden) {
        self.timeLabel.hidden = YES;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else {
        self.timeLabel.hidden = NO;
        self.timeLabel.text = message.time;
        [self.timeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
        }];
    }
    if (message.type == MessageTypeMe) {
        [self settingShowButton:self.messageBtn showIcon:self.meIcon hiddenButton:self.otherBtn hiddentIcon:self.otherIcon];
    }else if (message.type == MessageTypeOther){
        [self settingShowButton:self.otherBtn showIcon:self.otherIcon hiddenButton:self.messageBtn hiddentIcon:self.meIcon];
    }
}
-(void)settingShowButton:(UIButton *)showButton
                showIcon:(UIImageView *)showIcon
            hiddenButton:(UIButton *) hiddenButton
             hiddentIcon:(UIImageView *)hiddenIcon
{
    showButton.hidden =NO;
    showIcon.hidden =NO;
    hiddenButton.hidden = YES;
    hiddenIcon.hidden = YES;
    [showButton setTitle:self.message.text forState:UIControlStateNormal];
    // 强制刷新一次
    [self layoutIfNeeded];
    // 设置按钮的高度就是titleLabel的高度
    [showButton mas_updateConstraints:^(MASConstraintMaker *make) {
        // 加30是因为按钮的高度和label的高度一样，所以如果想让内部的label看着好点需要+30
        CGFloat buttonH = (showButton.titleLabel.frame.size.height+30);
        make.height.mas_equalTo(buttonH);
    }];
    [self layoutIfNeeded];
    CGFloat messageBtnY =CGRectGetMaxY(showButton.frame);
    CGFloat meIconY = CGRectGetMaxY(showIcon.frame);
    self.message.cellHeigth = MAX(meIconY,messageBtnY) +10;
}
@end
