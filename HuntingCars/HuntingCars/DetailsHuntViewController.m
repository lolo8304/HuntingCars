//
//  DetailsHuntViewController.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "DetailsHuntViewController.h"
#import "AudioToolbox/AudioServices.h"

@interface DetailsHuntViewController ()

@end

@implementation DetailsHuntViewController


CFURLRef soundFileURLRefOther;
SystemSoundID	soundFileObjectOther;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playSound:(id)sender {
    [self playSound];
}

- (void) playSound{
    if (!soundFileURLRefOther) {
        NSURL* sound = [self getURLSound];
        soundFileURLRefOther = (CFURLRef)CFBridgingRetain(sound);
        AudioServicesCreateSystemSoundID (soundFileURLRefOther, &soundFileObjectOther);
    }
    AudioServicesPlaySystemSound (soundFileObjectOther);
}
- (NSURL *)getURLSound {
    return [[NSBundle mainBundle] URLForResource: @"Sound-Red"
                                   withExtension: @"aiff"];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
