//
//  ViewController.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "SurveyViewController.h"

@interface SurveyViewController ()


@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ageSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *familyStatusSegment;
@property (weak, nonatomic) IBOutlet UISlider *horsePowerSlider;
@property (weak, nonatomic) IBOutlet UISlider *priceSlider;

@property (weak, nonatomic) IBOutlet UISegmentedControl *designSegment1;
@property (weak, nonatomic) IBOutlet UISegmentedControl *designSegment2;
- (IBAction)designSegment1Changed:(id)sender;
- (IBAction)designSegment2Changed:(id)sender;

@end

@implementation SurveyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDesignSegment: (NSInteger) index {
    if (index < self.designSegment1.numberOfSegments) {
        [self.designSegment1 setSelectedSegmentIndex: index];
        [self designSegment1Changed: (id)nil];
    } else {
        [self.designSegment2 setSelectedSegmentIndex: (index - self.designSegment1.numberOfSegments) ];
        [self designSegment2Changed: (id)nil];
    }
}

- (NSInteger)getDesignSegment {
    if ([self.designSegment1 selectedSegmentIndex] >= 0) {
        return [self.designSegment1 selectedSegmentIndex];
    } else {
        return [self.designSegment2 selectedSegmentIndex] + self.designSegment1.numberOfSegments;
    }
}


- (IBAction)designSegment1Changed:(id)sender {

    [self.designSegment2 setSelected:false];
    [self.designSegment2 setSelectedSegmentIndex:-1];
    NSLog(@"current designSegment = %li", (long)[self getDesignSegment]);
}

- (IBAction)designSegment2Changed:(id)sender {
    [self.designSegment1 setSelected:false];
    [self.designSegment1 setSelectedSegmentIndex:-1];
    NSLog(@"current designSegment = %li", (long)[self getDesignSegment]);
}
@end
