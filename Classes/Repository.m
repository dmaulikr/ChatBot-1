#import "Repository.h"
#import "GPNSObjectAdditions.h"
#import "AppDelegate.h"


@implementation Repository
@synthesize delegate;

- (NSArray*)findBuddies {
	return [self.delegate findAllOfEntity:@"Buddy"];
}

- (NSArray*)findMessages {
	return [self.delegate findAllOfEntity:@"Message"];
}

- (Buddy*)buddyWithName:(NSString*)name {
	Buddy *result = [self.delegate entityForName:@"Buddy"];
	result.name = name;
	return result;
}

- (Message*)messageForBuddy:(Buddy*)buddy {
	Message *msg = [self.delegate entityForName:@"Message"];
	msg.source = buddy;
	[self.delegate.context refreshObject:buddy mergeChanges:YES];
	return msg;
}

- (void)asyncSave {
	[self.delegate performSelector:@selector(save) withObject:nil afterDelay:0];
}

@end
