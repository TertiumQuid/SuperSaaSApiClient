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
@property (nonatomic, strong) NSString *apiResponse;

@end

@implementation SSReadFormsViewController
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else {
        return 1;
    }
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.placeholder = @"Form Definition ID";
            cell.textField.tag = 0;
            return cell;
        } else if (indexPath.row == 1) {
            static NSString *cellId = @"TextFieldCell";
            SSTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId
                                                                             forIndexPath:indexPath];
            cell.textField.placeholder = @"Form ID";
            cell.textField.tag = 1;
            return cell;
        } else if (indexPath.row == 2) {
            return [self getButtonCell:tableView forIndexPath:indexPath];
        }
    } if (indexPath.section == 1) {
        return [self getResponseCell:tableView
                        forIndexPath:indexPath
                            withText:self.apiResponse];
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
