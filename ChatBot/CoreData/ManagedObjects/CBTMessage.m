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

#pragma mark - Init

- (instancetype)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if (self) {
        [self setValue:@([NSDate date].timeIntervalSinceReferenceDate) forKey:@"timeSinceReferenceDate"];
    }
    
    return self;
}

#pragma mark - Time

- (NSDate *)time {
    return [NSDate dateWithTimeIntervalSinceReferenceDate:[[self valueForKey:@"timeSinceReferenceDate"] doubleValue]];
}

#pragma mark - Header

- (NSString *)header {
    static NSDateFormatter *format = nil;
    if(format == nil) {
        format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"MMM dd, HH:mm";
    }
    
    NSString *name = self.fromMe ? @"Me" : (self.source).name;
    return [NSString stringWithFormat:@"%@ at %@", name, [format stringFromDate:self.time]];
}

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
