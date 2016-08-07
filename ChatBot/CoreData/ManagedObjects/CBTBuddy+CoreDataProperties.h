//
//  CBTBuddy+CoreDataProperties.h
//  TestTask
//
//  Created by William Boles on 07/08/2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CBTBuddy.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBTBuddy (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<CBTMessage *> *unorderedMessages;

@end

@interface CBTBuddy (CoreDataGeneratedAccessors)

- (void)addUnorderedMessagesObject:(CBTMessage *)value;
- (void)removeUnorderedMessagesObject:(CBTMessage *)value;
- (void)addUnorderedMessages:(NSSet<CBTMessage *> *)values;
- (void)removeUnorderedMessages:(NSSet<CBTMessage *> *)values;

@end

NS_ASSUME_NONNULL_END
