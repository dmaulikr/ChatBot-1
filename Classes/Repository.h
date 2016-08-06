#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Buddy.h"
#import "Message.h"

@class AppDelegate;

@interface Repository : NSObject {
}
@property (nonatomic, strong) AppDelegate *delegate;

- (NSArray*)findBuddies;
- (NSArray*)findMessages;
- (Buddy*)buddyWithName:(NSString*)name;
- (void)asyncSave;
- (Message*)messageForBuddy:(Buddy*)buddy;
@end
