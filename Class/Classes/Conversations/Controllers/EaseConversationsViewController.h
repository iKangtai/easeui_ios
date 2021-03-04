//
//  EaseConversationsViewController.h
//  EaseIMKit
//
//  Created by 杜洁鹏 on 2020/10/29.
//

#import <UIKit/UIKit.h>
#import "EasePublicHeaders.h"
#import "EaseBaseTableViewController.h"

#import "EaseConversationViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EaseConversationsViewControllerDelegate <EaseBaseViewControllerDelegate>

@optional

- (UITableViewCell *)easeTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView *)easeTableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (NSArray<UIContextualAction *> *)easeTableView:(UITableView *)tableView
           trailingSwipeActionsForRowAtIndexPath:(NSIndexPath *)indexPath
                                         actions:(NSArray<UIContextualAction *> *)actions  API_AVAILABLE(ios(11.0));


- (NSArray<UITableViewRowAction *> *)easeTableView:(UITableView *)tableView
                      editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
                                           actions:(NSArray<UITableViewRowAction *> *)actions;

- (void)easeTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (id<EaseUserDelegate>)easeUserDelegateAtConversationId:(NSString *)conversationId
                                        conversationType:(EMConversationType)type;

@end

@interface EaseConversationsViewController : EaseBaseTableViewController
@property (nonatomic, strong) NSMutableArray *dataAry;
@property (nonatomic) id <EaseConversationsViewControllerDelegate> delegate;
/// 当前聊天对象：iPad 场景下，在会话列表里用特殊状态表示当前聊天对象
@property (nonatomic, copy) NSString *currentEaseId;
- (instancetype)initWithModel:(EaseConversationViewModel *)aModel;
@end

NS_ASSUME_NONNULL_END
