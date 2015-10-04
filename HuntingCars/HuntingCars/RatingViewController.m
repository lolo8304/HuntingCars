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
        [self prepareVehicleData];
        
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

- (void) prepareVehicleData {
    [self.totalScoreLabel setText: @"88%"];
    
        VehicleDAO* vehicle =[[ApplicationState instance] getCurrentFoundCar];
        vehicle = [[ApplicationState instance] loadVehicleDetails: vehicle ];
    
        NSMutableArray* choosen = [[ApplicationState instance] chosenCars ];
        int nof = [ choosen count];
        [self.huntingCarLabel setText: [NSString stringWithFormat:@"%d", nof]];
    
        [self.vehicleHeading1Label setText: [vehicle vehicleMainHeading1]];
        [self.vehicleHeading2Label setText: [vehicle vehicleMainHeading2]];
        
        NSURL* url = [vehicle image0];
        if (url) {
            [self.vehicleImage1 setImage: [self getImageFromURL: url]];
        } else {
            [self.vehicleImage1 setImage: [UIImage imageNamed: @"no-image-found" ]];
        }
}


- (UIImage*)getImageFromURL: (NSURL*) urlString {
    NSData *imageData =[NSData dataWithContentsOfURL: urlString];
    return [UIImage imageWithData: imageData];
}


- (IBAction)thumbsUpButtonPressed:(id)sender {
    [[ApplicationState instance] likeCurrentVehicle];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
        [self prepareVehicleData];
        NSLog(@"Finished work in background");
        dispatch_async(dispatch_get_main_queue(), ^ {
            NSLog(@"Back on main thread");
        });
    });
}

- (IBAction)thumbsDownButtonPressed:(id)sender {
    [[ApplicationState instance] dislikeCurrentVehicle];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^ {
        [self prepareVehicleData];
        NSLog(@"Finished work in background");
        dispatch_async(dispatch_get_main_queue(), ^ {
            NSLog(@"Back on main thread");
        });
    });
}
@end
