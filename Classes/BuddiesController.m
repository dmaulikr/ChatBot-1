#import "BuddiesController.h"
#import "ChatController.h"
#import "GPNSObjectAdditions.h"
#import "Buddy.h"


@interface BuddiesController ()
@property(nonatomic,retain) NSArray *buddies;
@end

@implementation BuddiesController
@synthesize buddies, repository;

- (void)dealloc {
	self.buddies = nil;
	self.repository = nil;
    [super dealloc];
}

#pragma mark -
#pragma mark View lifecycle

- (void)loadView {
	[super loadView];
	NSAssert(self.repository != nil,@"Not initialized");
	self.title = @"Buddies";
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil] autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.buddies = [self.repository findBuddies];
	[self.tableView reloadData];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.buddies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BuddyCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	Buddy *buddy = [self.buddies objectAtIndex:indexPath.row];
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",buddy.name]];
	cell.textLabel.text = buddy.name;
	cell.detailTextLabel.text = buddy.lastMessage.text;
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Buddy *buddy = [self.buddies objectAtIndex:indexPath.row];
	ChatController *ctrl = [ChatController xnew];
    ctrl.repository = self.repository;
	ctrl.buddy = buddy;
	[self.navigationController pushViewController:ctrl animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 48;
}

@end

