//
//  CBTBuddy.h
//  TestTask
//
//  Created by William Boles on 07/08/2016.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CBTMessage;

NS_ASSUME_NONNULL_BEGIN

@interface CBTBuddy : NSManagedObject

@property (weak, nonatomic,readonly) CBTMessage *lastMessage;
@property (nonatomic, strong) NSArray *messages;

@end

NS_ASSUME_NONNULL_END

#import "CBTBuddy+CoreDataProperties.h"
