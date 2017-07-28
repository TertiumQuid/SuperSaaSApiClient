//
//  SSApiClient.m
//  Pods
//
//  Created by Monty Cantsin on 28/07/17.
//
//

#import "SSApiClient.h"
#import "UICKeyChainStore.h"

NSString * const kApiAuthCredentialsKey = @"SaaSChecksumToken";
NSString * const kBaseApiUrl = @"https://www.supersaas.com/api";
NSString * const kKeyChainStore = @"com.SuperSaaS";

@interface SSApiClient()
    
- (id)initAPI;
- (BOOL)isAuthenticated;
- (NSString *)authCredentials;
- (BOOL)isSuccessfulAPIResponse:(id)responseObject
                       withTask:(NSURLSessionDataTask *)task
                      orFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
@property (strong, nonatomic) UICKeyChainStore *keyChain;

@end

@implementation SSApiClient
    
#pragma mark - Singleton construction
    
+ (instancetype)shared {
    static SSApiClient *client = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[SSApiClient alloc] initAPI];
    });
    return client;
}
    
- (id)initAPI {
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseApiUrl]];
    if (!self) {
        return nil;
    }
    self.keyChain = [UICKeyChainStore keyChainStoreWithService:kKeyChainStore];
    [self configSerialization];
    
    return self;
}

#pragma mark - Internal utilities
    
- (BOOL)isAuthenticated {
    NSString *token = [self authCredentials];
    return token.length;
}
    
- (NSString *)authCredentials {
    return [self.keyChain stringForKey:kApiAuthCredentialsKey];
}
    
- (BOOL)isSuccessfulAPIResponse:(id)responseObject
                       withTask:(NSURLSessionDataTask *)task
                      orFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
