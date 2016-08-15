//
//  CBTMessage.h
//  TestTask
//
//  Created by William Boles on 07/08/2016.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CBTBuddy;

NS_ASSUME_NONNULL_BEGIN

@interface CBTMessage : NSManagedObject

@property (weak, nonatomic,readonly) NSDate *time;
@property (nonatomic, assign) BOOL fromMe;
@property (weak, nonatomic,readonly) NSString *header;

@end

NS_ASSUME_NONNULL_END

#import "CBTMessage+CoreDataProperties.h"
