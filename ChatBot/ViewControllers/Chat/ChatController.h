#import <UIKit/UIKit.h>
#import "Repository.h"
#import "SendController.h"

@interface ChatController : UITableViewController <UITextViewDelegate, SendControllerDelegate>

@property (nonatomic, strong) Buddy *buddy;
@property (nonatomic, strong) Repository *repository;
@property (nonatomic, strong) NSArray *responses;
@property (nonatomic, assign) BOOL useTheBot;

@end
