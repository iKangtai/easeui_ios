//
//  EaseConversationModel.m
//  EaseIMKit
//
//  Created by 娜塔莎 on 2020/11/10.
//

#import "EaseConversationModel.h"
#import "EaseConversationModelUtil.h"
#import "EMDefines.h"
#import "IconResourceManage.h"

@interface EaseConversationModel()

@property (nonatomic, strong) EMConversation *conversation;

@end

@implementation EaseConversationModel

- (instancetype)initWithEMConversation:(EMConversation *)conversation
{
    self = [super init];
    if (self) {
        _conversation = conversation;
    }
    
    return self;
}

//会话对象昵称
- (NSString *)getConversationNickname:(EMConversation*)conversation
{
    NSString *nickname = nil;
    if (conversation.type == EMConversationTypeGroupChat || conversation.type == EMConversationTypeChatRoom) {
        nickname = [conversation.ext objectForKey:@"subject"];
        if ([nickname length] == 0 && conversation.type == EMConversationTypeGroupChat) {
            NSArray *groupArray = [[EMClient sharedClient].groupManager getJoinedGroups];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.conversationId]) {
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.groupName forKey:@"subject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    nickname = group.groupName;
                    break;
                }
            }
        }
    }
    return nickname;
}

#pragma mark - getter

- (NSString*)conversationId
{
    return _conversation.conversationId;
}

- (EMConversationType)conversationType
{
    return _conversation.type;
}

- (int)unreadMessagesCount
{
    if ([_conversation.conversationId isEqualToString:EMSYSTEMNOTIFICATIONID]) {
        return EMNotificationHelper.shared.unreadCount;
    }
    
    return _conversation.unreadMessagesCount;
}

- (NSDictionary*)ext
{
    return _conversation.ext;
}

- (EMMessage*)latestMessage
{
    return _conversation.latestMessage;
}

- (UIImage*)avatarImg
{
    if (_conversation.type == EMConversationTypeChat)
        return [IconResourceManage imageNamed:@"defaultAvatar" class:[self class]];
    if (_conversation.type == EMConversationTypeGroupChat)
        return [IconResourceManage imageNamed:@"groupConversation" class:[self class]];
    if (_conversation.type == EMConversationTypeChatRoom)
        return [IconResourceManage imageNamed:@"chatroomConversation" class:[self class]];
    if ([_conversation.conversationId isEqualToString:EMSYSTEMNOTIFICATIONID])
        return [IconResourceManage imageNamed:@"systemNotify" class:[self class]];
    
    return nil;
}

- (NSString*)conversationNickname
{
    _conversationNickname = [self getConversationNickname:_conversation];
    if (!_conversationNickname) {
        _conversationNickname = _conversation.conversationId;
        if ([_conversationNickname isEqualToString:EMSYSTEMNOTIFICATIONID]) {
            _conversationNickname = @"系统通知";
        }
    }
    
    return _conversationNickname;
}

- (BOOL)isStick
{
    return [self isConversationStick:_conversation];
}

#pragma mark - private

//是否置顶
- (BOOL)isConversationStick:(EMConversation*)conversation
{
    if ([conversation.ext objectForKey:CONVERSATION_STICK] && ![(NSNumber *)[conversation.ext objectForKey:CONVERSATION_STICK] isEqualToNumber:[NSNumber numberWithLong:0]]) {
        return YES;
    }
    
    return NO;
}

@end