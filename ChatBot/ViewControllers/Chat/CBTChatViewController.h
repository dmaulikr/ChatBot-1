#import <UIKit/UIKit.h>
#import "CBTRepository.h"
#import "CBTSendViewController.h"

@interface CBTChatViewController : UITableViewController <UITextViewDelegate, CBTSendControllerDelegate>

@property (nonatomic, strong) CBTBuddy *buddy;
@property (nonatomic, strong) CBTRepository *repository;
@property (nonatomic, strong) NSArray *responses;
@property (nonatomic, assign) BOOL useTheBot;

@end
