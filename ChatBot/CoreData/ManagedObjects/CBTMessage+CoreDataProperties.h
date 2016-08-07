//
//  CBTMessage+CoreDataProperties.h
//  TestTask
//
//  Created by William Boles on 07/08/2016.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CBTMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface CBTMessage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *fromMe;
@property (nullable, nonatomic, retain) NSString *text;
@property (nullable, nonatomic, retain) NSNumber *timeSinceReferenceDate;
@property (nullable, nonatomic, retain) CBTBuddy *source;

@end

NS_ASSUME_NONNULL_END
