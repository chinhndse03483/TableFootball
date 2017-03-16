//
//  TableTableViewCell.h
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableObject.h"

@interface TableTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblPos;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblNameClub;
@property (weak, nonatomic) IBOutlet UILabel *lblPLD;
@property (weak, nonatomic) IBOutlet UILabel *lblGD;
@property (weak, nonatomic) IBOutlet UILabel *lblPTS;
- (void)displayCell:(TableObject *)tableObject;

@end
