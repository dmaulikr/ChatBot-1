#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Buddy;

@interface Message : NSManagedObject {

}
@property(nonatomic,strong) NSString *text;
@property(nonatomic,strong) Buddy *source;
@property(weak, nonatomic,readonly) NSDate *time;
@property(nonatomic,assign) BOOL fromMe;
@property(weak, nonatomic,readonly) NSString *header;
@end
