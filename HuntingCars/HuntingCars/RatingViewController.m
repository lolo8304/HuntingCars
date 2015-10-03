//
//  RatingViewController.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "RatingViewController.h"
#import "ShowLoader.h"
#import "ApplicationState.h"

@interface RatingViewController ()

- (IBAction)thumbsUpButtonPressed:(id)sender;
- (IBAction)thumbsDownButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *huntingCarLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *vehicleHeading1Label;
@property (weak, nonatomic) IBOutlet UILabel *vehicleHeading2Label;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImage1;




@end

@implementation RatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc]
               initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
        
        [[ApplicationState instance] searchWithCustomerProfile];
        
        NSLog(@"Finished work in background");
        dispatch_async(dispatch_get_main_queue(), ^ {
            NSLog(@"Back on main thread");
            
            [spinner stopAnimating];
            
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)thumbsUpButtonPressed:(id)sender {
}

- (IBAction)thumbsDownButtonPressed:(id)sender {
}
@end
