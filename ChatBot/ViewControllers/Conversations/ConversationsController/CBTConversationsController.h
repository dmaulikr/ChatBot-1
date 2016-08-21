//
//  CBTBuddiesManager.h
//  ChatBot
//
//  Created by William Boles on 21/08/2016.
//
//

#import <Foundation/Foundation.h>
#import "CBTConversation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBTConversationsController : NSObject

@property (nonatomic, strong, readonly) NSArray<CBTConversation *> *conversations;

@end

NS_ASSUME_NONNULL_END
