//
//  ViewController.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "SurveyViewController.h"
#import "CustomerProfile.h"
#import "ApplicationState.h"

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
@property (weak, nonatomic) IBOutlet UITextField *totalPriceField;


@property (weak, nonatomic)  CustomerProfile *customerProfile;

@end

@implementation SurveyViewController

- (void)initModelWith: (ApplicationState*) state {
    self.customerProfile = [state customerProfile];
    [self.priceSlider setValue: (float)[self.customerProfile priceToBuy]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initModelWith: [ApplicationState instance]];
    
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"DONE" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    self.totalPriceField.inputAccessoryView = numberToolbar;
    
}

-(void)cancelNumberPad{
    [self.totalPriceField resignFirstResponder];
    self.totalPriceField.text = @"";
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = self.totalPriceField.text;
    [self.totalPriceField resignFirstResponder];
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
