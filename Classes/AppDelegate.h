#import <UIKit/UIKit.h>
#import "Repository.h"


@interface AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
	Repository *repository;
@private
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) Repository *repository;
@property (nonatomic, readonly) NSManagedObjectContext *context;
@property (nonatomic, readonly) NSManagedObjectModel *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

- (NSString *)applicationDocumentsDirectory;
- (NSArray*)findAllOfEntity:(NSString*)entityName;
- (void)addHardCodedBuddies;
- (void)addSortDescriptors;
- (id)entityForName:(NSString*)name;

@end

