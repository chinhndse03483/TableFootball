//
//  MainViewViewController.h
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZNSegmentedControl;

@interface MainViewViewController : UIViewController
@property (weak, nonatomic) IBOutlet DZNSegmentedControl *control;

@property (weak, nonatomic) IBOutlet UITableView *tbv;

@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;



@end
