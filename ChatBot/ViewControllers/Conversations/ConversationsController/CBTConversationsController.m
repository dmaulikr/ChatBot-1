//
//  CBTBuddiesManager.m
//  ChatBot
//
//  Created by William Boles on 21/08/2016.
//
//

#import "CBTConversationsController.h"
#import <CoreDataServices/CoreDataServices-Swift.h>
#import "CBTBuddy.h"

@interface CBTConversationsController ()

@property (nonatomic, strong, readwrite) NSArray<CBTConversation *> *conversations;

@end

@implementation CBTConversationsController

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self addHardCodedConversationsIfNeeded];
    }
    
    return self;
}

#pragma mark - SetUp

- (void)addHardCodedConversationsIfNeeded
{
    if (self.conversations.count == 0)
    {
        [self addConversationWithBuddy:[self addBuddyWithName:@"Jacob"]];
        [self addConversationWithBuddy:[self addBuddyWithName:@"Bonnie"]];
        [self addConversationWithBuddy:[self addBuddyWithName:@"Matt"]];
        [self addConversationWithBuddy:[self addBuddyWithName:@"Kelly"]];
        
        [[CDSServiceManager sharedInstance] saveMainManagedObjectContext];
        
        self.conversations = nil;
    }
}

#pragma mark - Conversations

- (NSArray<CBTConversation *> *)conversations
{
    if (!_conversations)
    {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"buddy.name" ascending:YES];
        
        _conversations = (NSArray<CBTConversation *> *)[[CDSServiceManager sharedInstance].mainManagedObjectContext cds_retrieveEntriesForEntityClass:[CBTConversation class]
                                                                                                                         sortDescriptors:@[sortDescriptor]];
    }
    
    return _conversations;
}

#pragma mark - Conversations

- (CBTBuddy *)addBuddyWithName:(NSString *)name
{
    CBTBuddy *buddy = (CBTBuddy *)[NSEntityDescription cds_insertNewObjectForEntityForClass:[CBTBuddy class]
                                                                     inManagedObjectContext:[CDSServiceManager sharedInstance].mainManagedObjectContext];
    
    buddy.name = name;
    
    return buddy;
}

- (CBTConversation *)addConversationWithBuddy:(CBTBuddy *)buddy
{
    CBTConversation *conversation = (CBTConversation *)[NSEntityDescription cds_insertNewObjectForEntityForClass:[CBTConversation class]
                                                                     inManagedObjectContext:[CDSServiceManager sharedInstance].mainManagedObjectContext];
    conversation.buddy = buddy;
    
    return conversation;
}

@end
