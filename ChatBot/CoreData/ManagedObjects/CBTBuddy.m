//
//  CBTBuddy.m
//  TestTask
//
//  Created by William Boles on 07/08/2016.
//
//

#import "CBTBuddy.h"
#import "CBTMessage.h"

@implementation CBTBuddy

@dynamic messages;

#pragma mark - Message

- (CBTMessage *)lastMessage {
    for (CBTMessage *message in [self.messages reverseObjectEnumerator]) {
        if (!message.fromMe) {
            return message;
        }
    }
    
    return nil;
}

@end
