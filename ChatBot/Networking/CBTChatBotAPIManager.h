//
//  CBTChatBotAPIManager.h
//  TestTask
//
//  Created by William Boles on 14/08/2016.
//
//

#import <Foundation/Foundation.h>

@interface CBTChatBotAPIManager : NSObject

+ (void)retrieveBotIDWithCompletion:(void(^)(NSString *botID, NSError *error))completion;

+ (void)retrieveBotCust2FromBotWithID:(NSString *)botID
                           completion:(void(^)(NSString *botcust2, NSError *error))completion;

+ (void)requestReplyFromBotWithID:(NSString *)botID
                         botCust2:(NSString *)botCust2
                      lastMessage:(NSString *)lastMessage
                       completion:(void(^)(NSString *reply, NSError *error))completion;

@end
