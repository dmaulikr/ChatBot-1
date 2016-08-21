#import "CBTAppDelegate.h"
#import "CBTConversationsViewController.h"
#import "CBTConversationsController.h"
#import <CoreDataServices/CoreDataServices-Swift.h>

@interface CBTAppDelegate ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CBTAppDelegate

#pragma mark - ApplicationLifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[CDSServiceManager sharedInstance] setupModelURLWithModelName:@"ChatBot"];
    
    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    CBTConversationsViewController *buddiesViewController = (CBTConversationsViewController *)navigationController.topViewController;
    buddiesViewController.conversationsController = [[CBTConversationsController alloc] init];

	return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	[[CDSServiceManager sharedInstance] saveMainManagedObjectContext];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[[CDSServiceManager sharedInstance] saveMainManagedObjectContext];
}

@end

