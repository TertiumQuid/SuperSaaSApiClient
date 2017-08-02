//
//  SSReadFormsViewController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSReadFormsViewController.h"
#import "SSTextFieldTableViewCell.h"
#import "SSApiClient.h"

@interface SSReadFormsViewController ()

@property (nonatomic, strong) NSString *formDefinitionId;
@property (nonatomic, strong) NSString *formId;
@property (nonatomic, strong) NSString *response;

@end

@implementation SSReadFormsViewController
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}
    
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Enter API Input";
    } else {
        return @"API Response";
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.placeholder = @"Form Definition ID";
            cell.textField.tag = 0;
            [cell setLayoutMargins:UIEdgeInsetsZero];
            return cell;
        } else if (indexPath.row == 1) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.delegate = self;
            cell.textField.placeholder = @"Form ID";
            cell.textField.tag = 1;
            [cell setLayoutMargins:UIEdgeInsetsZero];
            return cell;
        } else if (indexPath.row == 2) {
            static NSString *cellId = @"ButtonCell";
            [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                    forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"Submit";
            return cell;
        }
    } if (indexPath.section == 1) {
        static NSString *cellId = @"ResponseCell";
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.response;
        return cell;
    }
    return nil;
}
    
#pragma mark - Text field delegate
    
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 0) {
        self.formDefinitionId = textField.text;
    } else if (textField.tag == 1) {
        self.formId = textField.text;
    }
}

@end
