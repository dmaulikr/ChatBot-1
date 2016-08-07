#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CBTBuddy.h"
#import "CBTMessage.h"

@class CBTAppDelegate;

@interface CBTRepository : NSObject

@property (nonatomic, strong) CBTAppDelegate *delegate;
@property (nonatomic, readonly, copy) NSArray *findBuddies;
@property (nonatomic, readonly, copy) NSArray *findMessages;

- (CBTBuddy *)buddyWithName:(NSString *)name;
- (void)asyncSave;
- (CBTMessage *)messageForBuddy:(CBTBuddy *)buddy;

@end
