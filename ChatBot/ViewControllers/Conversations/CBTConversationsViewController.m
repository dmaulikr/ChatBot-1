#import "CBTConversationsViewController.h"
#import "CBTConversationViewController.h"
#import "CBTBuddy.h"
#import "CBTBuddyTableViewCell.h"
#import "CBTConversationsController.h"
#import "CBTConversationController.h"
#import "CBTMessage.h"

@interface CBTConversationsViewController ()

@end

@implementation CBTConversationsViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Buddies", nil);
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

	[self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.conversationsController.conversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBTBuddyTableViewCell *cell = (CBTBuddyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BuddyTableViewCell" forIndexPath:indexPath];
    
	CBTConversation *conversation = self.conversationsController.conversations[indexPath.row];
    CBTBuddy *buddy = conversation.buddy;
    
    UIImage *avatar = [UIImage imageNamed:buddy.name];
    cell.avatarImageView.image = avatar;
    cell.nameLabel.text = buddy.name;
    cell.lastMessageLabel.text = conversation.lastMessage.text;
    
    return cell;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ChatSelected"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)sender];
        CBTConversation *conversation = self.conversationsController.conversations[indexPath.row];
        
        CBTConversationController *controller = [[CBTConversationController alloc] initWithConversation:conversation];
        CBTConversationViewController *conversationViewController = [segue destinationViewController];
        conversationViewController.conversationController = controller;
    }
}

@end

