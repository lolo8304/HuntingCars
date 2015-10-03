//
//  ShowLoader.h
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShowLoader : NSObject
- (id)initWithController: (UIViewController*) controller;
- (void) perform: (dispatch_block_t) block;
@end
