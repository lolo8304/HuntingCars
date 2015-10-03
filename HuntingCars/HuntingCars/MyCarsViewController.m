//
//  MyCarsViewController.m
//  HuntingCars
//
//  Created by Lorenz Hänggi on 03/10/15.
//  Copyright © 2015 hackZurich. All rights reserved.
//

#import "MyCarsViewController.h"


//Sections
#define kMyCarDetailsSectionIndex 0
#define kMyCarNofSections 1


@interface MyCarsViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myCarsTableView;

@end

@implementation MyCarsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    //TODO dynamics: Size of myCars
    if (section == kMyCarDetailsSectionIndex) return 1;
    else return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"row=%ld section = %ld", (long)indexPath.row, (long)indexPath.section);
    /*
    if (indexPath.section==kMyCarDetailsSectionIndex) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCarDetails" forIndexPath:indexPath];
        
        return cell;
        
    }
    else if (indexPath.section==kProtectionSectionIndex) {
        ProtectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProtectionCell" forIndexPath:indexPath];
        
        
        if (indexPath.row == 0) {
            cell.desc.text = @"At home";
            cell.logo.image = [UIImage imageNamed:@"option-at-home.png"];
            [cell.informationButton setImage:[UIImage imageNamed:@"option-info.png"] forState:UIControlStateNormal];
            cell.status.image =[UIImage imageNamed:kStatusCheck];
            
            if ([ImagesModel sharedManager].currentImageIndex == kImacIndex) {
                cell.status.image =[UIImage imageNamed:kStatusCheck];
            }
            else if ([ImagesModel sharedManager].currentImageIndex == kVuittonIndex) {
                cell.status.image =[UIImage imageNamed:kStatusCheck];
            }
        }
        else if (indexPath.row == 1) {
            cell.desc.text = @"In the car";
            [cell.informationButton setImage:[UIImage imageNamed:@"option-info.png"] forState:UIControlStateNormal];
            cell.logo.image = [UIImage imageNamed:@"option-in-the-car.png"];
            cell.status.image =[UIImage imageNamed:kStatusKO];
            
            //option-info.png
            if ([ImagesModel sharedManager].currentImageIndex == kImacIndex) {
                cell.status.image =[UIImage imageNamed:kStatusWarning];
            }
            else if ([ImagesModel sharedManager].currentImageIndex == kVuittonIndex) {
                cell.status.image =[UIImage imageNamed:kStatusKO];
            }
            
        }
        else if (indexPath.row == 2) {
            cell.desc.text = @"Outside";
            [cell.informationButton setImage:[UIImage imageNamed:@"option-info.png"] forState:UIControlStateNormal];
            cell.logo.image = [UIImage imageNamed:@"option-outside.png"];
            cell.status.image =[UIImage imageNamed:kStatusWarning];
            if ([ImagesModel sharedManager].currentImageIndex == kImacIndex) {
                cell.status.image =[UIImage imageNamed:kStatusKO];
            }
            else if ([ImagesModel sharedManager].currentImageIndex == kVuittonIndex) {
                cell.status.image =[UIImage imageNamed:kStatusKO];
            }
            
        }
        else if (indexPath.row == 3) {
            cell.desc.text = @"Traveling";
            [cell.informationButton setImage:[UIImage imageNamed:@"option-info.png"] forState:UIControlStateNormal];
            cell.logo.image = [UIImage imageNamed:@"option-traveling.png"];
            cell.status.image =[UIImage imageNamed:kStatusWarning];
            
            if ([ImagesModel sharedManager].currentImageIndex == kImacIndex) {
                cell.status.image =[UIImage imageNamed:kStatusKO];
            }
            else if ([ImagesModel sharedManager].currentImageIndex == kVuittonIndex) {
                cell.status.image =[UIImage imageNamed:kStatusWarning];
            }
            
        }
        return cell;
     
    }
     */
    
    NSLog(@"Your assurance detail : Cell return nil row=%ld section = %ld", (long)indexPath.row, (long)indexPath.section);
    
    return nil;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString * cellIdentifier = nil;
    
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
    return cell;
    
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
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
}



#pragma mark - cell size
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 60;
    else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section==[self.tableView numberOfSections]-1) {
        return 60;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //if (section==0) return 0;
    /*
    if (section == 0 && self.numberOption == 0) {
        return 0;
    }
     */
    
    return 24;
}



@end
