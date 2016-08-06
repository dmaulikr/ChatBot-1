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

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) Repository *repository;
@property (weak, nonatomic, readonly) NSManagedObjectContext *context;
@property (weak, nonatomic, readonly) NSManagedObjectModel *model;
@property (weak, nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;

- (NSString *)applicationDocumentsDirectory;
- (NSArray*)findAllOfEntity:(NSString*)entityName;
- (void)addHardCodedBuddies;
- (void)addSortDescriptors;
- (id)entityForName:(NSString*)name;

@end

