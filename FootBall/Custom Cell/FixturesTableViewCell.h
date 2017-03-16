//
//  FixturesTableViewCell.h
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FixturesObject.h"

@interface FixturesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblStadium;
@property (weak, nonatomic) IBOutlet UIImageView *imgHomeTeam;
@property (weak, nonatomic) IBOutlet UIImageView *imgAwayTeam;
@property (weak, nonatomic) IBOutlet UILabel *lblNameHomeTeam;
@property (weak, nonatomic) IBOutlet UILabel *lblNameAwayTeam;
- (void)displayCell:(FixturesObject *)fixturesObject;
@end
