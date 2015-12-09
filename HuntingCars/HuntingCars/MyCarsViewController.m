//
//  MyCarsViewController.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "MyCarsViewController.h"
#import "ApplicationState.h"
#import "MyCarTableViewCell.h"
#import "VehicleDAO.h"


//Sections
#define kMyCarDetailsSectionIndex 0
#define kMyCarNofSections 1


@interface MyCarsViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myCarsTableView;

@end

@implementation MyCarsViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    

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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return kMyCarNofSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (section == kMyCarDetailsSectionIndex) return [[[ApplicationState instance] chosenCars] count];
    else return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"row=%ld section = %ld", (long)indexPath.row, (long)indexPath.section);

    if (indexPath.section==kMyCarDetailsSectionIndex) {
        
        MyCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCarDetails" forIndexPath:indexPath];
        
        // indexPath.row = index to choosenCar
        VehicleDAO* vehicle =[[ApplicationState instance] chosenCars][indexPath.row];
        [cell.vehicleHeading1Label setText: [vehicle vehicleMainHeading1]];
        
        [cell.totalScoreLabel setText: [vehicle totalScoreString]];
        [cell.milageLabel setText: [vehicle milage]];
        [cell.priceLabel setText: [vehicle price]];
        [cell.emissionLabel setText: [vehicle emissions]];
        [cell.tcoLabel setText:[vehicle tcoPerMonth ]];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^ {
            NSLog(@"Finished work in background");
            dispatch_async(dispatch_get_main_queue(), ^ {
                [cell.vehicleImage1 setImage: [vehicle uiImage0]];
                NSLog(@"Back on main thread");
            });
        });

/*
         dispatch_sync(dispatch_get_main_queue(), ^{
             [cell.vehicleImage1 setImage: [vehicle uiImage0]];
        });
*/
        return cell;
        
    }
    return nil;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString * cellIdentifier = nil;
    /*
    cellIdentifier = @"TitleHeader";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    UILabel *title = (UILabel *)[cell viewWithTag:1];
    
    if (section == 0 ) {
        title.text = @"YOUR OPTIONS";
    }
    else {
        title.text = @"YOUR PROTECTIONS";
    }
    [title sizeToFit];
    
    //title.font = [UIFont fontWithName:FONT_DEMI size:17.0f];
    if (cell == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
    return cell;*/
    return nil;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
    /*
    NSString * cellIdentifier = nil;
    //	else
    if (section == [self.tableView numberOfSections]-1) {
        cellIdentifier = @"PayFooter";
        
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        UILabel *title = (UILabel *)[cell viewWithTag:1];
        if (cell == nil){
            [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
        }
        return cell;
        
    }
    return nil;
     */
}



#pragma mark - cell size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == kMyCarDetailsSectionIndex) return 116;
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"huntDetails"]) {
        [ApplicationState instance].chosenCarsIndex = 0;
    }
}


@end
