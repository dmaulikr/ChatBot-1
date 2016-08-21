//
//  CBTMessage.m
//  TestTask
//
//  Created by William Boles on 07/08/2016.
//
//

#import "CBTMessage.h"
#import "CBTBuddy.h"

@implementation CBTMessage

#pragma mark - Me

- (BOOL)fromMe {
    [self willAccessValueForKey:@"fromMe"];
    NSNumber *result = [self primitiveValueForKey:@"fromMe"];
    [self didAccessValueForKey:@"fromMe"];
    return result.boolValue;
}

- (void)setFromMe:(BOOL)fromMe {
    [self willChangeValueForKey:@"fromMe"];
    [self setPrimitiveValue:@(fromMe) forKey:@"fromMe"];
    [self didChangeValueForKey:@"fromMe"];
}

@end
