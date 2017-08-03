//
//  SSMenuViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 03/08/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSMenuViewController.h"

@interface SSMenuViewController ()

@end

@implementation SSMenuViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Select an API Method";
}

@end
