//
//  AppDelegate.m
//  Book
//
//  Created by Adrian Lee on 12/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "StartView.h"
#import "Chapter.h"

@interface AppDelegate ()
{
@private
	StartView *_startView;
	UINavigationController *_navco;
}

@property (strong, nonatomic) StartView *startView;
@property (strong, nonatomic) UINavigationController *navco;

- (void) saveChapter;
@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize startView = _startView;
@synthesize navco = _navco;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	// Override point for customization after application launch.
	self.window.backgroundColor = [UIColor whiteColor];

	[self setStartView:[[StartView alloc] init]];
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"封面" 
								       style:UIBarButtonItemStyleBordered 
								      target:nil 
								      action:nil];
	self.startView.navigationItem.backBarButtonItem = backButton;
	[self setNavco:[[UINavigationController alloc] initWithRootViewController:self.startView]];
	
	[self.window addSubview: self.navco.view];
	
	[self.window makeKeyAndVisible];
	
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Saves changes in the application's managed object context before the application terminates.
	[self saveContext];
}

- (void)saveContext
{
	NSError *error = nil;
	NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
	if (managedObjectContext != nil)
	{
		if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
		{
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		} 
	}
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
	NSLog(@"%@:%s:%d start", [self class], (char *)_cmd, __LINE__);
	
	if (__managedObjectContext != nil)
	{
		return __managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (coordinator != nil)
	{
		__managedObjectContext = [[NSManagedObjectContext alloc] init];
		[__managedObjectContext setPersistentStoreCoordinator:coordinator];
	}
	return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
	NSLog(@"%@:%s:%d start", [self class], (char *)_cmd, __LINE__);
	
	if (__managedObjectModel != nil)
	{
		return __managedObjectModel;
	}
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Book" withExtension:@"momd"];
	__managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return __managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
	if (__persistentStoreCoordinator != nil)
	{
		return __persistentStoreCoordinator;
	}
	
	NSString *storePath = [[NSBundle mainBundle] pathForResource: @"Book" 
							      ofType: @"sqlite"];

	
	NSURL *storeURL = [NSURL fileURLWithPath:storePath];
	
	NSError *error = nil;
	__persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
	{
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible;
		 * The schema for the persistent store is incompatible with current managed object model.
		 Check the error message to determine what the actual problem was.
		 
		 
		 If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
		 
		 If you encounter schema incompatibility errors during development, you can reduce their frequency by:
		 * Simply deleting the existing store:
		 [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
		 
		 * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
		 [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
		 
		 Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
		 
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}    
	
	return __persistentStoreCoordinator;
}

#pragma mark - Application's directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
	return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Temp testing method

- (void) saveChapter
{
	NSLog(@"%@:%s:%d start", [self class], (char *)_cmd, __LINE__);
	
	NSEntityDescription *ent = [NSEntityDescription entityForName:@"Chapter" inManagedObjectContext:self.managedObjectContext];
	Chapter *chapter = [[Chapter alloc] initWithEntity:ent insertIntoManagedObjectContext:nil];
	[chapter setTitle:@"中标题"];
	[chapter setDetail:@"中章节"];
	[chapter setTitleBig:@"大节"];
	[[self managedObjectContext] insertObject:chapter];
	
	chapter = [[Chapter alloc] initWithEntity:ent insertIntoManagedObjectContext:nil];
	[chapter setTitle:@"English Title"];
	[chapter setDetail:@"English Chapter"];
	[chapter setTitleBig:@"English Big Title"];
	[[self managedObjectContext] insertObject:chapter];
	
	NSError *error = nil;
	
	BOOL saveSuccess = [[self managedObjectContext] save:&error];
	if (YES == saveSuccess)
	{
		NSLog(@"Save success");
	}
	else
	{
		NSLog(@"Save failed:%@", error);
	}
	chapter = nil;
}

@end
