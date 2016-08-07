#import <CoreData/CoreData.h>
#import "CBTAppDelegate.h"
#import "CBTBuddiesViewController.h"
#import "GPNSObjectAdditions.h"

@interface CBTAppDelegate ()

@property (nonatomic, strong, readwrite) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readwrite) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readwrite) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CBTAppDelegate

#pragma mark - Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 

	CBTBuddiesViewController *buddies = [CBTBuddiesViewController xnew];
	self.repository = [CBTRepository xnew];
    self.repository.delegate = self;
    buddies.repository = self.repository;
    [self addSortDescriptors];
	[self addHardCodedBuddies];

	self.navigationController = [[UINavigationController alloc] initWithRootViewController:buddies];
	self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

	return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[self saveContext];
}

- (NSArray*)findAllOfEntity:(NSString*)entityName {
	NSFetchRequest *request = [NSFetchRequest xnew];
	id description = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
	request.entity = description;
	NSError *error = nil;
	NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
	NSAssert1(error == nil,@"Read data failed %@",error);
	return result;
}

- (id)entityForName:(NSString*)name {
	return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.managedObjectContext];
}

- (void)addSortDescriptors {
	NSEntityDescription *desc = (self.managedObjectModel).entitiesByName[NSStringFromClass([CBTBuddy class])];
	NSFetchedPropertyDescription *prop = desc.propertiesByName[@"messages"];
	NSFetchRequest *fetchRequest = prop.fetchRequest;
	NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"timeSinceReferenceDate" ascending:YES];
	fetchRequest.sortDescriptors = @[sort];
}

- (CBTBuddy *)buddyWithName:(NSString*)name {
	CBTBuddy *result = [self entityForName:NSStringFromClass([CBTBuddy class])];
	result.name = name;
	return result;
}

- (NSArray *)findBuddies {
	return [self findAllOfEntity:NSStringFromClass([CBTBuddy class])];
}

- (void)addHardCodedBuddies {
	NSAssert(self.managedObjectContext != nil, @"Not initialized");
	if([self findBuddies].count > 0)
		return;
	[self buddyWithName:@"Jacob"];
	[self buddyWithName:@"Bonnie"];
	[self buddyWithName:@"Matt"];
	[self buddyWithName:@"Kelly"];
	[self saveContext];
}

#pragma mark - CoreDatastack

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ChatBot" withExtension:@"momd"];
    //[[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]]
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ChatBot.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end

