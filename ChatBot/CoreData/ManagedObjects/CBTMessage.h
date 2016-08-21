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

@property (nonatomic, assign) BOOL fromMe;

@end

NS_ASSUME_NONNULL_END

#import "CBTMessage+CoreDataProperties.h"
