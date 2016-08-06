#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Message.h"


@interface Buddy : NSManagedObject {

}
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSArray *messages;
@property(nonatomic,readonly) Message *lastMessage;
@end


