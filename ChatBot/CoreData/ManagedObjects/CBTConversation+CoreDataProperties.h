//
//  CBTConversation+CoreDataProperties.h
//  ChatBot
//
//  Created by William Boles on 21/08/2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CBTConversation.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBTConversation (CoreDataProperties)

@property (nullable, nonatomic, retain) CBTBuddy *buddy;
@property (nullable, nonatomic, retain) NSSet<CBTMessage *> *messages;

@end

@interface CBTConversation (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(CBTMessage *)value;
- (void)removeMessagesObject:(CBTMessage *)value;
- (void)addMessages:(NSSet<CBTMessage *> *)values;
- (void)removeMessages:(NSSet<CBTMessage *> *)values;

@end

NS_ASSUME_NONNULL_END
