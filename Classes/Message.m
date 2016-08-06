#import "Message.h"
#import "Buddy.h"

@implementation Message
@dynamic text, source;

- (id)initWithEntity:(NSEntityDescription *)entity insertIntoManagedObjectContext:(NSManagedObjectContext *)context 
{
	self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
	[self setValue:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSinceReferenceDate]] forKey:@"timeSinceReferenceDate"];
	return self;
}

- (NSDate*) time {
	return [NSDate dateWithTimeIntervalSinceReferenceDate:[[self valueForKey:@"timeSinceReferenceDate"] doubleValue]];
}

- (NSString*)header {
	static NSDateFormatter *format = nil;
	if(format == nil) {
		format = [[NSDateFormatter alloc] init];
		[format setDateFormat:@"MMM dd, HH:mm"];
	}
	
	NSString *name = self.fromMe ? @"Me" : [self.source name];
	return [NSString stringWithFormat:@"%@ at %@", name, [format stringFromDate:self.time]];

}

- (BOOL)fromMe {
    [self willAccessValueForKey:@"fromMe"];
	NSNumber *result = [self primitiveValueForKey:@"fromMe"];
    [self didAccessValueForKey:@"fromMe"];
	return [result boolValue];
}

- (void)setFromMe:(BOOL)fromMe {
    [self willChangeValueForKey:@"fromMe"];
    [self setPrimitiveValue:[NSNumber numberWithBool:fromMe] forKey:@"fromMe"];
    [self didChangeValueForKey:@"fromMe"];
}

@end
