//
//  ShowLoader.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "ShowLoader.h"

#import <UIKit/UIKit.h>

@implementation ShowLoader

UIViewController* viewController;
id sender;

- (id)initWithController: (UIViewController*) controller {
    viewController = controller;
    return self;
}

- (void) runWithHUD: (dispatch_block_t) block title: (NSString *) title success: (NSString *) successText failure: (NSString*) failureText {

    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [viewController.view addSubview:spinner];
    [spinner startAnimating];
    
    block();
    
    [spinner stopAnimating];
    
}



- (void) perform: (dispatch_block_t) block title: (NSString *) title success: (NSString *) successText failure: (NSString*) failureText segueWithIdentifier: (NSString *) segueId sender: sender  {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
        
        [self runWithHUD: block title: title success: successText failure: failureText];
        
        NSLog(@"Finished work in background");
        dispatch_async(dispatch_get_main_queue(), ^ {
            NSLog(@"Back on main thread");
            
            if (viewController.isViewLoaded && viewController.view.window && viewController.parentViewController != nil) {
                [viewController performSegueWithIdentifier: segueId sender:sender];}
            
        });
    });

}




@end
