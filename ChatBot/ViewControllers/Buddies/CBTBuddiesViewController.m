#import "CBTBuddiesViewController.h"
#import "CBTChatViewController.h"
#import "GPNSObjectAdditions.h"
#import "CBTBuddy.h"
#import "CBTRepository.h"

@interface CBTBuddiesViewController ()
@property (nonatomic, strong) NSArray *buddies;
@end

@implementation CBTBuddiesViewController

#pragma mark - View lifecycle

- (void)loadView {
	[super loadView];
	NSAssert(self.repository != nil,@"Not initialized");
	self.title = @"Buddies";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.buddies = [self.repository findBuddies];
	[self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (self.buddies).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BuddyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	CBTBuddy *buddy = (self.buddies)[indexPath.row];
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",buddy.name]];
	cell.textLabel.text = buddy.name;
	cell.detailTextLabel.text = buddy.lastMessage.text;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 48;
}

@end

