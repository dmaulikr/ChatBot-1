#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Message.h"

@interface Buddy : NSManagedObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *messages;
@property (weak, nonatomic,readonly) Message *lastMessage;
@end


