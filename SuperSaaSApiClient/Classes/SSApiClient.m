//
//  SSApiClient.m
//  Pods
//
//  Created by Monty Cantsin on 28/07/17.
//
//

#import <CommonCrypto/CommonDigest.h>
#import "SSApiClient.h"
#import "UICKeyChainStore.h"

NSString * const kApiAuthCredentialsKey = @"SaaSChecksumToken";
NSString * const kKeyChainStore = @"com.SuperSaaS";

NSString * const kBaseApiUrl = @"https://www.supersaas.com/api";
NSString * const kApiUsersPath = @"users";
NSString * const kApiFormsPath = @"forms";
NSString * const kApiBookingsPath = @"bookings";
NSString * const kApiAgendaPath = @"agenda";
NSString * const kApiFreePath = @"free";
NSString * const kApiChangesPath = @"changes";

@interface SSApiClient()
    
- (id)initAPI;
- (BOOL)isAuthenticated;
- (NSString *)authChecksum:(NSString *)username accountName:(NSString *)accountName accountPassword:(NSString *)accountPassword;
- (NSString *)authCredentials;
- (NSString *)md5:(NSString *)input;
- (BOOL)isSuccessfulAPIResponse:(id)responseObject
                       withTask:(NSURLSessionDataTask *)task
                      orFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

- (NSURLSessionDataTask *)login:(NSString *)username
                    accountName:(NSString *)accountName
                accountPassword:(NSString *)accountPassword
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (void)logout;
- (NSURLSessionDataTask *)readUser:(NSString *)userId
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
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

#pragma mark - Authentication
    
- (BOOL)isAuthenticated {
    NSString *token = [self authCredentials];
    return token.length;
}
    
- (NSString *)authChecksum:(NSString *)username accountName:(NSString *)accountName accountPassword:(NSString *)accountPassword {
    NSString *input = [NSString stringWithFormat:@"%@%@%@", accountName, accountPassword, username];
    return [self md5:input];
}
    
- (NSString *)authCredentials {
    return [self.keyChain stringForKey:kApiAuthCredentialsKey];
}
    
- (NSString *)md5:(NSString *)input {
    const char* ptr = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), result);
    
    NSUInteger capacity = CC_MD5_DIGEST_LENGTH * 2;
    NSMutableString *ret = [NSMutableString stringWithCapacity:capacity];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x", result[i]];
    }
    return ret;
}
    
- (BOOL)storeAccessToken:(NSString *)checksum {
    NSError *error;
    
    [self.keyChain setString:checksum forKey:kApiAuthCredentialsKey error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return NO;
    } else {
        return YES;
    }
}

//NSDictionary *responseObject = @{ @"key": key, @"response": answer };    
    
#pragma mark - Internal utilities
    
- (BOOL)isSuccessfulAPIResponse:(id)responseObject
                       withTask:(NSURLSessionDataTask *)task
                      orFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

}
    
#pragma mark - API Methods
    
+ (NSURLSessionDataTask *)login:(NSString *)username
                    accountName:(NSString *)accountName
                accountPassword:(NSString *)accountPassword
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

}
    
+ (void)logout {
    [self.shared logout];
}
    
- (void)logout {
    [self.keyChain removeItemForKey:kApiAuthCredentialsKey];
}
    
+ (NSURLSessionDataTask *)readUser:(NSString *)userId
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readUser:userId success:success failure:failure];
}
    
- (NSURLSessionDataTask *)readUser:(NSString *)userId
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"%@/%@", kApiUsersPath, userId];
    return [self GET:path parameters:@{} success:success failure:failure];
}
    
    
@end
