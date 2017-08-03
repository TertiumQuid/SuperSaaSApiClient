//
//  SSReadAgendaViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 30/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSReadAgendaViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSApiClient.h"

@interface SSReadAgendaViewController ()

@property (nonatomic, strong) NSString *scheduleId;
@property (nonatomic, strong) NSString *user;
@property (nonatomic, strong) NSDate *from;

@end

@implementation SSReadAgendaViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSInteger rows = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        
        if (indexPath.row < rows - 1) {
            NSString *text = @"";
            if (indexPath.row == 0) {
                text = @"Schedule ID";
            } else if (indexPath.row == 1) {
                text = @"User";
            } else if (indexPath.row == 2) {
                text = @"From";
            }
            
            return [self getTextFieldCell:tableView
                             forIndexPath:indexPath
                                 withText:text
                                  withTag:indexPath.row];
            
        } else {
            return [self getButtonCell:tableView forIndexPath:indexPath];
        }
        
    } if (indexPath.section == 1) {
        return [self getResponseCell:tableView
                        forIndexPath:indexPath
                            withText:self.apiResponse];
    }
    return nil;
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    bool isButtonRow = indexPath.section == 0 && indexPath.row == 2;
    
    self.apiResponse = @"Loading...";
    [self.tableView reloadData];
    
    if (isButtonRow) {
        [SSApiClient readAgenda:self.scheduleId
                           user:self.user
                           from:self.from
                        success:^(NSURLSessionDataTask *task, id responseObject) {
                           self.apiResponse = [NSString stringWithFormat:@"%@", responseObject];
                           [self.tableView reloadData];
                           
                       } failure:^(NSURLSessionDataTask *task, NSError *error) {
                           [self showApiError:error];
                       }];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.scheduleId = textField.text;
    } else if (textField.tag == 1) {
        self.user = textField.text;
    } else if (textField.tag == 2) {
        self.from = [self getDate:textField.text];
    }
}

@end
