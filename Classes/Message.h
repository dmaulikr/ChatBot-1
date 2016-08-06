#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Buddy;

@interface Message : NSManagedObject {

}
@property(nonatomic,retain) NSString *text;
@property(nonatomic,retain) Buddy *source;
@property(nonatomic,readonly) NSDate *time;
@property(nonatomic,assign) BOOL fromMe;
@property(nonatomic,readonly) NSString *header;
@end
