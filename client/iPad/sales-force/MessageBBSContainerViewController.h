//
//  MessageBBSContainerViewController.h
//  sales-force
//
//  Created by kiss on 2016/01/18.
//  Copyright © 2016年 kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageBBSContainerViewController : UIViewController

typedef enum{
    TargetMessgae,
    TargetBBS
}MessageBBSContainerViewTarget;

-(void) swapViewController:(MessageBBSContainerViewTarget)target option:(id)option;

@end
