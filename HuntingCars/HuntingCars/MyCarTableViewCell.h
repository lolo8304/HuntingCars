//
//  MyCarTableViewCell.h
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImage1;
@property (weak, nonatomic) IBOutlet UILabel *vehicleHeading1Label;
@property (weak, nonatomic) IBOutlet UILabel *milageLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *emissionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tcoLabel;



@end
