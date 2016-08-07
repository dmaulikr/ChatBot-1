#import "CBTRepository.h"
#import "GPNSObjectAdditions.h"
#import "CBTAppDelegate.h"

@implementation CBTRepository

- (NSArray *)findBuddies {
	return [self.delegate findAllOfEntity:NSStringFromClass([CBTBuddy class])];
}

- (NSArray *)findMessages {
	return [self.delegate findAllOfEntity:NSStringFromClass([CBTMessage class])];
}

- (CBTBuddy *)buddyWithName:(NSString *)name {
	CBTBuddy *result = [self.delegate entityForName:NSStringFromClass([CBTBuddy class])];
	result.name = name;
	return result;
}

- (CBTMessage *)messageForBuddy:(CBTBuddy *)buddy {
	CBTMessage *msg = [self.delegate entityForName:NSStringFromClass([CBTMessage class])];
	msg.source = buddy;
	[self.delegate.managedObjectContext refreshObject:buddy mergeChanges:YES];
	return msg;
}

- (void)asyncSave {
	[self.delegate performSelector:@selector(save) withObject:nil afterDelay:0];
}

@end
