#import "CBTBuddiesViewController.h"
#import "CBTChatViewController.h"
#import "GPNSObjectAdditions.h"
#import "CBTBuddy.h"
#import "CBTRepository.h"
#import "CBTBuddyTableViewCell.h"

@interface CBTBuddiesViewController ()
@property (nonatomic, strong) NSArray *buddies;
@end

@implementation CBTBuddiesViewController

#pragma mark - View lifecycle

- (void)loadView {
	[super loadView];
	NSAssert(self.repository != nil,@"Not initialized");
	self.title = NSLocalizedString(@"Buddies", nil) ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.buddies = [self.repository findBuddies];
	[self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.buddies).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //static NSString *CellIdentifier = @"BuddyCell";
    
    CBTBuddyTableViewCell *cell = (CBTBuddyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BuddyCell" forIndexPath:indexPath];
    
	CBTBuddy *buddy = (self.buddies)[indexPath.row];
    
    UIImage *avatar = [UIImage imageNamed:buddy.name];
    cell.avatarImageView.image = avatar;
    cell.nameLabel.text = buddy.name;
    cell.lastMessageLabel.text = buddy.lastMessage.text;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	CBTBuddy *buddy = (self.buddies)[indexPath.row];
	CBTChatViewController *ctrl = [CBTChatViewController xnew];
    ctrl.repository = self.repository;
	ctrl.buddy = buddy;
	[self.navigationController pushViewController:ctrl animated:YES];
}

@end

