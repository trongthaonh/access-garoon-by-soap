//
//  AppDelegate.m
//  sales-force
//
//  Created by kiss on 2015/12/22.
//  Copyright © 2015年 kiss. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
@interface AppDelegate ()

@property (strong, atomic)    NSArray *_reportArray;
@property (strong, atomic)    NSDictionary *_messageArray;
@property (strong, atomic)    NSArray *_workflowArray;
@property (strong, atomic)    NSDictionary *_bbsDictionary;
@property (strong, atomic)    NSDictionary *_userProfile;

@end

@implementation AppDelegate

@synthesize _reportArray;
@synthesize _messageArray;
@synthesize _workflowArray;
@synthesize _bbsDictionary;
@synthesize _userProfile;

- (void)setupTabBar
{
	RootViewController *rootViewController = (RootViewController *)[[self window] rootViewController];
	NSMutableArray *tabbarItems = [NSMutableArray arrayWithArray:[rootViewController viewControllers]];
	NSString *removeTag = @"";
    int     i;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
		removeTag = @"TodayContainer ViewController";
	}
	else{
		removeTag = @"TodayTable ViewController";
	}
	if(removeTag.length > 0){
		for(i = 0; i < [tabbarItems count]; i++){
			UIViewController *item = [tabbarItems objectAtIndex:i];
			if([item.title isEqual:removeTag]){
				[tabbarItems removeObjectAtIndex:i];
				break;
			}
		}
		[rootViewController setViewControllers:tabbarItems];
	}
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _reportArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ReportSample" ofType:@"plist"]];
    _messageArray = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MessageSample" ofType:@"plist"]];
    _workflowArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WorkflowSample" ofType:@"plist"]];
    _bbsDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BBSSample" ofType:@"plist"]];
    _userProfile = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"UserSample" ofType:@"plist"]];
    [self setupTabBar];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(NSArray *)allReportArray
{
    return(_reportArray);
}

-(NSDictionary *)allMessageDictionary
{
    return(_messageArray);
}

-(NSArray *)allWorkflowArray
{
    return(_workflowArray);
}

-(NSDictionary *)allBBSFolder
{
    return(_bbsDictionary);
}

-(NSDictionary *)userProfile
{
    return(_userProfile);
}

@end