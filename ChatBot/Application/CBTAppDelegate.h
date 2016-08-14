#import <UIKit/UIKit.h>
#import "CBTRepository.h"

@interface CBTAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;
@property (nonatomic, strong) CBTRepository *repository;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSArray *)findAllOfEntity:(NSString *)entityName;
- (void)addHardCodedBuddies;
- (void)addSortDescriptors;
- (id)entityForName:(NSString *)name;

@end

