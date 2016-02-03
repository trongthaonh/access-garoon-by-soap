//
//  AppDelegate.h
//  sales-force
//
//  Created by kiss on 2015/12/22.
//  Copyright © 2015年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(NSArray *)allReportArray;
-(NSDictionary *)allMessageDictionary;
-(NSArray *)allWorkflowArray;
-(NSDictionary *)allBBSFolder;
-(NSDictionary *)userProfile;

@end

