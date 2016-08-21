#import "CBTConversationViewController.h"
#import "CBTMessage.h"
#import "CBTBuddy.h"
#import "CBTMessageTableViewCell.h"

@interface CBTConversationViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *textFieldBottomConstraint;

@end

@implementation CBTConversationViewController

#pragma mark - ViewLifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.conversationController.conversation.buddy.name;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.tableView.estimatedRowHeight = 80.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView setNeedsLayout];
    [self.tableView layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadAndScrollToLastMessage];
}

#pragma mark - Setup

- (void)reloadAndScrollToLastMessage
{
    [self.tableView reloadData];
    
    NSInteger lastSection = self.conversationController.messages.count;
    if(lastSection > 0)
    {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:lastSection-1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.conversationController.messages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CBTMessage *message = self.conversationController.messages[indexPath.section];
    
    CBTMessageTableViewCell *cell = (CBTMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell" forIndexPath:indexPath];
    cell.messageLabel.text = message.text;
    
    if (message.fromMe)
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.messageLabel.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:1.0f alpha:1.0f];
        cell.messageLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(18.0f, 0.0f, 290.0f, 20.0f);
    label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor darkGrayColor];
    
    CBTMessage *message = self.conversationController.messages[section];
    
    if (message.fromMe)
    {
        label.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        label.textAlignment = NSTextAlignmentLeft;
    }
    
    // inset effect
    label.shadowColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.55f];
    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    label.text = [self contentForSectionHeader:section];
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    
    return view;
}

- (NSString *)contentForSectionHeader:(NSInteger)section
{
    static dispatch_once_t once;
    static NSDateFormatter *dateFormatter;
    dispatch_once(&once, ^
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MMM dd, HH:mm";
    });
    
    CBTMessage *message = self.conversationController.messages[section];
    
    NSString *authorOfMessage = nil;
    if (message.fromMe)
    {
        authorOfMessage = NSLocalizedString(@"Me", nil);
    }
    else
    {
        authorOfMessage = self.conversationController.conversation.buddy.name;
    }

    return [NSString stringWithFormat:NSLocalizedString(@"%@ at %@", nil), authorOfMessage, [dateFormatter stringFromDate:message.date]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    __weak CBTConversationViewController *weakSelf = self;
    [self.conversationController addMessage:textField.text
                                 completion:^(NSError *error)
     {
         if (!error)
         {
             [weakSelf reloadAndScrollToLastMessage];
         }
         else
         {
            //TODO: Handle error
         }
     }];
    
    self.textField.text = nil;
    [weakSelf reloadAndScrollToLastMessage];
    
    return YES;
}

#pragma mark - KeyboardNotifications

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGRect keyboardRect = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    self.textFieldBottomConstraint.constant = keyboardRect.size.height;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.textFieldBottomConstraint.constant = 0.0f;
}

@end

