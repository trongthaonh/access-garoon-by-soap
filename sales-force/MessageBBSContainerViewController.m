//
//  MessageBBSContainerViewController.m
//  sales-force
//
//  Created by kiss on 2016/01/18.
//  Copyright © 2016年 kiss. All rights reserved.
//
//  Heavily inspired by http://orderoo.wordpress.com/2012/02/23/container-view-controllers-in-the-storyboard/

#import "MessageBBSContainerViewController.h"
#import "MessageTableViewController.h"
#import "BBSTableViewController.h"

#define SegueIdentifierMessage @"embedMessage"
#define SegueIdentifierBBS @"embedBBS"

@interface MessageBBSContainerViewController()

@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (strong, nonatomic) UINavigationController *messageViewController;
@property (strong, nonatomic) UINavigationController *bbsViewController;
@property (assign, nonatomic) BOOL transitionInProgress;

@property (weak, nonatomic) id _option;

@end

@implementation MessageBBSContainerViewController

@synthesize _option;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.transitionInProgress = NO;
    self.currentSegueIdentifier = SegueIdentifierMessage;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if ([segue.identifier isEqualToString:SegueIdentifierMessage]) {
        if(self.messageViewController == nil){
            self.messageViewController = segue.destinationViewController;
        }
    }
    
    if ([segue.identifier isEqualToString:SegueIdentifierBBS]) {
        if(self.bbsViewController == nil){
            self.bbsViewController = segue.destinationViewController;
        }
    }
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:SegueIdentifierMessage]) {
        // If this is not the first time we're loading this.
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.messageViewController];
        }
        else {
            // If this is the very first time we're loading this we need to do
            // an initial load and not a swap.
            [self addChildViewController:segue.destinationViewController];
            UIView* destView = ((UIViewController *)segue.destinationViewController).view;
            destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:destView];
            [segue.destinationViewController didMoveToParentViewController:self];
        }
    }
    // By definition the second view controller will always be swapped with the
    // first one.
    else if ([segue.identifier isEqualToString:SegueIdentifierBBS]) {
        BBSTableViewController  *_bbsTableViewController;
        [self.bbsViewController popToViewController: [self.bbsViewController.viewControllers objectAtIndex:0] animated:NO];
        _bbsTableViewController = (BBSTableViewController *)[self.bbsViewController visibleViewController];
        [_bbsTableViewController setFolder:_option];
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.bbsViewController];
    }
}

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.transitionInProgress = NO;
    }];
}

-(void) swapViewController:(MessageBBSContainerViewTarget)target option:(id)option
{
    
    if (self.transitionInProgress) {
        return;
    }
    _option = option;
    if((target == TargetMessgae) && [self.currentSegueIdentifier isEqualToString:SegueIdentifierMessage]){
        MessageTableViewController  *_messageTableViewController;
        [self.messageViewController popToViewController: [self.messageViewController.viewControllers objectAtIndex:0] animated:NO];
        _messageTableViewController = (MessageTableViewController *)[self.messageViewController visibleViewController];
        [_messageTableViewController setCategory:[option intValue]];
    }else if((target == TargetBBS) && [self.currentSegueIdentifier isEqualToString:SegueIdentifierBBS]){
        BBSTableViewController  *_bbsTableViewController;
        [self.bbsViewController popToViewController: [self.bbsViewController.viewControllers objectAtIndex:0] animated:NO];
        _bbsTableViewController = (BBSTableViewController *)[self.bbsViewController visibleViewController];
        [_bbsTableViewController setFolder:option];
    }else{
        self.transitionInProgress = YES;
        self.currentSegueIdentifier = ([self.currentSegueIdentifier isEqualToString:SegueIdentifierMessage]) ? SegueIdentifierBBS : SegueIdentifierMessage;
        
        if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierMessage]) && self.messageViewController) {
            MessageTableViewController  *_messageTableViewController;
            [self.messageViewController popToViewController: [self.messageViewController.viewControllers objectAtIndex:0] animated:NO];
            _messageTableViewController = (MessageTableViewController *)[self.messageViewController visibleViewController];
            [_messageTableViewController setCategory:[option intValue]];
            [self swapFromViewController:self.bbsViewController toViewController:self.messageViewController];
            return;
        }
        
        if (([self.currentSegueIdentifier isEqualToString:SegueIdentifierBBS]) && self.bbsViewController) {
            BBSTableViewController  *_bbsTableViewController;
            [self.bbsViewController popToViewController: [self.bbsViewController.viewControllers objectAtIndex:0] animated:NO];
            _bbsTableViewController = (BBSTableViewController *)[self.bbsViewController visibleViewController];
            [_bbsTableViewController setFolder:option];
            [self swapFromViewController:self.messageViewController toViewController:self.bbsViewController];
            return;
        }
        
        [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
    }
}

@end
