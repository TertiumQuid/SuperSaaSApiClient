//
//  SSTabBarController.m
//  SuperSaaSApiClient
//
//  Created by Monty Cantsin on 28/07/17.
//  Copyright © 2017 SuperSaaS. All rights reserved.
//

#import "SSTabBarController.h"
#import "SSApiClient.h"

@interface SSTabBarController ()

@end

@implementation SSTabBarController
    
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    if (![SSApiClient isAuthenticated]) {
        [self performSegueWithIdentifier:@"ShowLoginSegue" sender:self];
    }
}
    

@end
