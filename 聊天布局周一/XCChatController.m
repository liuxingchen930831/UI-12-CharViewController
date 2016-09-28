//
//  XCChatController.m
//  聊天布局周一
//
//  Created by liuxingchen on 16/9/26.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "XCChatController.h"
#import "XCMessage.h"
#import "XCMessageCell.h"
@interface XCChatController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpacing;
@property (weak, nonatomic) IBOutlet UITextField *messageFile;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 数据源 */
@property(nonatomic,strong)NSMutableArray  * messages ;
@end

@implementation XCChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIView *leftView = [[UIView alloc]init];
    leftView.frame =CGRectMake(0, 0, 10, 0);
    leftView.backgroundColor = [UIColor whiteColor];
    self.messageFile.leftView = leftView;
    self.messageFile.leftViewMode = UITextFieldViewModeAlways;
    //监听点击键盘事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWithShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWithHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)keyboardWithHidden:(NSNotification *)note
{
    self.bottomSpacing.constant = 0;
    
    double duration =[note.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
-(void)keyboardWithShow:(NSNotification *)note
{
   CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomSpacing.constant = rect.size.height;
    NSLog(@"%@---",note.userInfo);
  double duration =[note.userInfo [UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
-(NSMutableArray *)messages
{
    if (_messages ==nil) {
        _messages = [NSMutableArray arrayWithCapacity:0];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"messages.plist" ofType:nil];
        NSArray *messageArray = [NSArray arrayWithContentsOfFile:path];
        //记录上一条消息模型
        XCMessage *lastMessage = nil;
        for (NSDictionary *dict in messageArray) {
            XCMessage *message = [XCMessage messageWithDict:dict];
            message.timeHidden = [message.time isEqualToString:lastMessage.time];
            [_messages addObject:message];
            lastMessage = message;
        }
    }
    return _messages;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCMessageCell *cell = [XCMessageCell cellWithTableView:tableView];
    cell.message = self.messages[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XCMessage *message = self.messages[indexPath.row];
    return message.cellHeigth;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
