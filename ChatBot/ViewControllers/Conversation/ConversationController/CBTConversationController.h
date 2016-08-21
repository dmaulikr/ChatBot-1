//
//  CBTChatBotManager.h
//  TestTask
//
//  Created by William Boles on 21/08/2016.
//
//

#import <Foundation/Foundation.h>
#import "CBTConversation.h"
#import "CBTMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBTConversationController : NSObject

@property (nonatomic, strong, readonly) CBTConversation *conversation;
@property (nonatomic, strong, readonly) NSArray<CBTMessage *> *messages;

- (instancetype)initWithConversation:(CBTConversation *)conversation;

- (void)addMessage:(NSString *)message
        completion:(void(^)(NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
