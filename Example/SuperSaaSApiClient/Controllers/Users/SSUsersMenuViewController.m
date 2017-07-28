//
//  SSUsersMenuViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSUsersMenuViewController.h"

@interface SSUsersMenuViewController ()

@end

@implementation SSUsersMenuViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
    
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Select an API Method";
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"MenuCell";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                            forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Read Users";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"Read User";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Add User";
    }
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"ShowReadUsersSegue" sender:self];
    } else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"ShowReadUserSegue" sender:self];
    } else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"ShowAddUserSegue" sender:self];
    }
}

@end
