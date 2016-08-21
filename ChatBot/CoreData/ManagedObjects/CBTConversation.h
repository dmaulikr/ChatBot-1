//
//  CBTConversation.h
//  ChatBot
//
//  Created by William Boles on 21/08/2016.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CBTBuddy, CBTMessage;

NS_ASSUME_NONNULL_BEGIN

@interface CBTConversation : NSManagedObject

- (nullable CBTMessage *)lastMessage;

@end

NS_ASSUME_NONNULL_END

#import "CBTConversation+CoreDataProperties.h"
