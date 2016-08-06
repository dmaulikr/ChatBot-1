#import <UIKit/UIKit.h>
#import "Repository.h"
#import "SendController.h"

@interface ChatController : UITableViewController <UITextViewDelegate,SendControllerDelegate> {
	Buddy *buddy;
	Repository *repository;
}
@property(nonatomic,retain) Buddy *buddy;
@property(nonatomic,retain) Repository *repository;
@property(nonatomic,retain) NSArray *responses;
@property(nonatomic,assign) BOOL useTheBot;

@end
