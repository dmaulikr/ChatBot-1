#import "Buddy.h"


@implementation Buddy
@dynamic name, messages;

- (void)dealloc {
	self.name = nil;
	self.messages = nil;
	[super dealloc];
}

- (Message*)lastMessage {
	for (Message *message in [self.messages reverseObjectEnumerator]) {
		if (!message.fromMe) {
			return message;
		}
	}
	return nil;
}

@end