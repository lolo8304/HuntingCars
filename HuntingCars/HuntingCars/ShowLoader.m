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
UIActivityIndicatorView *spinner;

- (id)initWithController: (UIViewController*) controller {
    viewController = controller;
    return self;
}


- (void) perform: (dispatch_block_t) block {
    
    spinner = [[UIActivityIndicatorView alloc]
               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [viewController.view addSubview:spinner];
    [spinner startAnimating];

    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
        
        block();
        
        NSLog(@"Finished work in background");
        dispatch_async(dispatch_get_main_queue(), ^ {
            NSLog(@"Back on main thread");
            
            [spinner stopAnimating];

        });
    });

}




@end
