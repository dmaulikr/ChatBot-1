//
//  CBTConversation.m
//  ChatBot
//
//  Created by William Boles on 21/08/2016.
//
//

#import "CBTConversation.h"
#import "CBTBuddy.h"
#import "CBTMessage.h"
#import <CoreDataServices/CoreDataServices-Swift.h>

@implementation CBTConversation

#pragma mark - Messages

- (nullable CBTMessage *)lastMessage
{
    if (self.messages.count > 0)
    {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"conversation == %@", self];
        
        return (CBTMessage *)[[CDSServiceManager sharedInstance].mainManagedObjectContext cds_retrieveFirstEntryForEntityClass:[CBTMessage class]
                                                                                                       predicate:predicate
                                                                                                 sortDescriptors:@[sortDescriptor]];
    }
    
    return nil;
}

@end
