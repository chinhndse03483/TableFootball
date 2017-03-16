//
//  MainViewViewController.m
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import "MainViewViewController.h"
#import "DZNSegmentedControl.h"
#import "TableTableViewCell.h"
#import "AFNetworking.h"
#import "TableObject.h"
#import "FixturesObject.h"
#import "ProgressHUD.h"
#import "SVPullToRefresh.h"
#import "FixturesTableViewCell.h"


#define kGetTableByIdCompetitions @"http://api.football-data.org/v1/competitions/%@/leagueTable"
#define kGetFixturesByMatchDay @"http://api.football-data.org/v1/competitions/%@/fixtures?matchday=%@"

@interface MainViewViewController ()<DZNSegmentedControlDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *menuItems;
@property(nonatomic, strong) NSMutableArray *listClub;
@property(nonatomic, strong) NSDictionary *json;
@end


@implementation MainViewViewController
NSString *selectedSegmentIndex = @"0";
- (void)viewDidLoad {
    [super viewDidLoad];
    [ProgressHUD show];
    _tbv.estimatedRowHeight = 100.0;
    _tbv.rowHeight = UITableViewAutomaticDimension;
    _tbv.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _menuItems = @[[UIImage imageNamed:@"premier-league-logo"], [UIImage imageNamed:@"icn_emoji"], [UIImage imageNamed:@"icn_gift"]];
    _control.items = _menuItems;
    _control.delegate = self;
    _control.selectedSegmentIndex = 0;
    _control.bouncySelectionIndicator = YES;
    _control.height = 100.0f;
    _control.width = self.view.frame.size.width;
    _control.showsGroupingSeparators = YES;
    _control.inverseTitles = YES;
    _control.showsCount = NO;
    _control.autoAdjustSelectionIndicatorWidth = NO;
    _control.selectionIndicatorHeight = 4.0;
    _control.adjustsFontSizeToFitWidth = YES;
    [_control addTarget:self action:@selector(didChangeSegment:) forControlEvents:UIControlEventValueChanged];
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //do something expensive
        
        //dispatch back to the main (UI) thread to stop the activity indicator
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getDataTable];
        });
    });
    [self.tbv addPullToRefreshWithActionHandler:^{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //do something expensive
            
            //dispatch back to the main (UI) thread to stop the activity indicator
            dispatch_async(dispatch_get_main_queue(), ^{
                [_listClub removeAllObjects];
                [_tbv reloadData];
                NSNumber *selectedSegmentIndexInCell = @([selectedSegmentIndex intValue]);
                if([selectedSegmentIndexInCell isEqualToNumber:@0]){
                    [self getDataTable];
                }else if ([selectedSegmentIndexInCell isEqualToNumber:@1]){
                    [self getDataFixturesByMatchDay];
                }
                
            });
        });
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.clipsToBounds = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(UIStatusBarStyle) preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listClub.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *selectedSegmentIndexInCell = @([selectedSegmentIndex intValue]);
    if([selectedSegmentIndexInCell isEqualToNumber:@0]){
       return 70.0f;
    }else if([selectedSegmentIndexInCell isEqualToNumber:@1]){
        return 137.0f;
    }else{
        return 100.0f;
    }

}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;{

    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *selectedSegmentIndexInCell = @([selectedSegmentIndex intValue]);
    if([selectedSegmentIndexInCell isEqualToNumber:@0]){
        NSLog(@"0");
        static NSString *cellId = @"TableTableViewCell";
        TableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TableTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        TableObject *tableObject = _listClub[indexPath.row];
        [cell displayCell:tableObject];
        
        cell.contentView.backgroundColor = [UIColor clearColor];
        return cell;
    }else if([selectedSegmentIndexInCell isEqualToValue:@1]){
        NSLog(@"1");
        static NSString *cellId = @"FixturesTableViewCell";
        FixturesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"FixturesTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        FixturesObject *fixturesObject = _listClub[indexPath.row];
        [cell displayCell:fixturesObject];

        cell.contentView.backgroundColor = [UIColor clearColor];
        return cell;
    }else {
        NSLog(@"2");
        static NSString *cellId = @"TableTableViewCell";
        TableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TableTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        TableObject *tableObject = _listClub[indexPath.row];
        [cell displayCell:tableObject];
        
        cell.contentView.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

-(void)getDataFixturesByMatchDay{
    _listClub = [[NSMutableArray alloc]init];
    
    NSString *URL = [NSString stringWithFormat:kGetFixturesByMatchDay,@"426",@"28"];
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:URL]];
    NSString * dataInString = [[NSString alloc]initWithData:jsonSource encoding:NSUTF8StringEncoding];
    NSData *jsonData = [dataInString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    _json = [NSJSONSerialization JSONObjectWithData:jsonData
                                            options:NSJSONReadingMutableContainers
                                              error:&error];
    for (NSDictionary *jsonDict in _json[@"fixtures"]) {
        FixturesObject *fixturesObject  = [[FixturesObject alloc]initWithJson:jsonDict];
        [_listClub addObject:fixturesObject];
    }
    [self.tbv.pullToRefreshView stopAnimating];
    [_tbv reloadData];
    
//    [manager GET:URL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        _json = responseObject[@"fixtures"];
//        for (NSDictionary *jsonDict in _json) {
//            FixturesObject *fixturesObject  = [[FixturesObject alloc]initWithJson:jsonDict];
//            [_listClub addObject:fixturesObject];
//        }
//        [_tbv reloadData];
//        [ProgressHUD dismiss];
//        [self.tbv.pullToRefreshView stopAnimating];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//        NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
//        NSLog(@"hello: %@",ErrorResponse);
//        [ProgressHUD showError:@"Không lấy được dữ liệu!"];
//        [self.tbv.pullToRefreshView stopAnimating];
//        
//    }];
}


-(void)getDataTable{
    _listClub = [[NSMutableArray alloc]init];
    NSString *URL = [NSString stringWithFormat:kGetTableByIdCompetitions,@"426"];
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:URL]];
    NSString * dataInString = [[NSString alloc]initWithData:jsonSource encoding:NSUTF8StringEncoding];
    NSData *jsonData = [dataInString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    _json = [NSJSONSerialization JSONObjectWithData:jsonData
                                            options:NSJSONReadingMutableContainers
                                              error:&error];
    for (NSDictionary *jsonDict in _json[@"standing"]) {
        TableObject *tableObject  = [[TableObject alloc]initWithJson:jsonDict];
        [_listClub addObject:tableObject];
    }
    [self.tbv.pullToRefreshView stopAnimating];
    [ProgressHUD dismiss];
    [_tbv reloadData];
    
}

#pragma mark - Events
- (IBAction)didChangeSegment:(id)sender
{
    NSLog(@"%@",[sender valueForKey:@"selectedSegmentIndex"]);
    selectedSegmentIndex = [sender valueForKey:@"selectedSegmentIndex"];
    [self.tbv reloadData];
    _json = nil;
    NSNumber *selectedSegmentIndexInCell = @([selectedSegmentIndex intValue]);
    if([selectedSegmentIndexInCell isEqualToNumber:@0]){
        [self getDataTable];
        _imgHeader.image = [UIImage imageNamed:@"Chelsea-v-Swansea-City-Premier-League-1"];
    }else if([selectedSegmentIndexInCell isEqualToNumber:@1]){
        _imgHeader.image = [UIImage imageNamed:@"premier_league_16_17"];
        [self getDataFixturesByMatchDay];
    }else{
        
    }
}

#pragma mark - DZNSegmentedControlDelegate Methods
- (UIBarPosition)positionForBar:(id <UIBarPositioning>)view
{
    return UIBarPositionAny;
}

- (UIBarPosition)positionForSelectionIndicator:(id<UIBarPositioning>)bar
{
    return UIBarPositionAny;
}


@end
