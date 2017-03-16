//
//  FixturesObject.h
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixturesObject : NSObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *matchday;
@property (nonatomic, strong) NSString *homeTeamName;
@property (nonatomic, strong) NSString *awayTeamName;
@property (nonatomic, strong) NSDictionary *result;
@property (nonatomic, strong) NSDictionary *odds;

- (instancetype)initWithJson:(NSDictionary *)jsonDict;
@end
