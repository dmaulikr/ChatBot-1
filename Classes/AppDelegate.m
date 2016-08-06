#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "BuddiesController.h"
#import "GPNSObjectAdditions.h"

@implementation AppDelegate
@synthesize window, navigationController, repository;


- (void)dealloc {
	self.navigationController = nil;
	self.window = nil;
	self.repository = nil;
	[super dealloc];
}

- (void)save {
	NSAssert(self.context != nil, @"Not initialized");
	NSError *error = nil;
	BOOL failed = [self.context hasChanges] && ![self.context save:&error];
	NSAssert1(!failed,@"Save failed %@",[error userInfo]);
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { 

	BuddiesController *buddies = [BuddiesController xnew];
	self.repository = [Repository xnew];
    self.repository.delegate = self;
    buddies.repository = self.repository;
    [self addSortDescriptors];
	[self addHardCodedBuddies];

	self.navigationController = [[UINavigationController alloc] initWithRootViewController:buddies];
	self.window = [[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
    window.rootViewController = self.navigationController;
    [window makeKeyAndVisible];

	return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self save];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
	[self save];
}

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSArray*)findAllOfEntity:(NSString*)entityName {
	NSFetchRequest *request = [NSFetchRequest xnew];
	id description = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.context];
	[request setEntity:description];
	NSError *error = nil;
	NSArray *result = [self.context executeFetchRequest:request error:&error];
	NSAssert1(error == nil,@"Read data failed %@",error);
	return result;
}

- (id)entityForName:(NSString*)name {
	return [NSEntityDescription insertNewObjectForEntityForName:name inManagedObjectContext:self.context];
}

- (void)addSortDescriptors {
	NSEntityDescription *desc = [[self.model entitiesByName] objectForKey:@"Buddy"];
	NSFetchedPropertyDescription *prop = [[desc propertiesByName] objectForKey:@"messages"];
	NSFetchRequest *fetchRequest = [prop fetchRequest];
	NSSortDescriptor *sort = [[[NSSortDescriptor alloc] initWithKey:@"timeSinceReferenceDate" ascending:YES] autorelease];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
}

- (Buddy*)buddyWithName:(NSString*)name {
	Buddy *result = [self entityForName:@"Buddy"];
	result.name = name;
	return result;
}

- (NSArray*)findBuddies {
	return [self findAllOfEntity:@"Buddy"];
}


- (void)addHardCodedBuddies {
	NSAssert(self.context != nil, @"Not initialized");
	if([[self findBuddies] count] > 0)
		return;
	[self buddyWithName:@"Jacob"];
	[self buddyWithName:@"Bonnie"];
	[self buddyWithName:@"Matt"];
	[self buddyWithName:@"Kelly"];
	[self save];
}

#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)context {
    
    if (self->context != nil)
        return self->context;
    
    self->context = [[NSManagedObjectContext xnew] retain];
    [self->context setPersistentStoreCoordinator:self.coordinator];
    return self.context;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)model {
    
    if (self->model != nil) {
        return self->model;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Model" ofType:@"mom"];
    self->model = [[[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]] autorelease];    
    return self->model;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)coordinator {
    
    if (self->coordinator != nil) {
        return self->coordinator;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Store.sqlite"]];
    
    NSError *error = nil;
    self->coordinator = [[[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.model] autorelease];
    [self->coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    return self->coordinator;
}

@end

