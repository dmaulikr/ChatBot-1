#import <UIKit/UIKit.h>
#import "Repository.h"

@interface BuddiesController : UITableViewController {
	NSArray *buddies;
	Repository *repository;
}
@property(nonatomic,retain) Repository *repository;
@end