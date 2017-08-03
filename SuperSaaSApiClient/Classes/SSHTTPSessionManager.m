//
//  SSHTTPSessionManager.m
//  Pods
//
//  Created by Monty Cantsin on 28/07/17.
//
//

#import "SSHTTPSessionManager.h"

@interface SSHTTPSessionManager()

@property (nonatomic) BOOL debugEnabled;

@end

@implementation SSHTTPSessionManager

#pragma mark - Utilities

- (void)setDebug:(BOOL)enabled {
    self.debugEnabled = enabled;
}

#pragma mark - Internal utilities
    
- (void)configSerialization {
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                      @"application/json",
                                                      @"text/json",
                                                      @"text/javascript",
                                                      @"text/plain",
                                                      @"text/html", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type" ];
}
    
#pragma mark - RESTful HTTP commands
    
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    if (self.debugEnabled) {
        NSLog(@"GET %@ - %@", URLString, parameters);
    }
    
    return [super GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) success(task, responseObject);
    } failure:failure];
}
    
- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    if (self.debugEnabled) {
        NSLog(@"POST %@ - %@", URLString, parameters);
    }
    
    return [super POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) success(task, responseObject);
    } failure:failure];
}
    
- (NSURLSessionDataTask *)PUT:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    if (self.debugEnabled) {
        NSLog(@"PUT %@ - %@", URLString, parameters);
    }
    
    return [super PUT:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) success(task, responseObject);
    } failure:failure];
}
    
- (NSURLSessionDataTask *)DELETE:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    if (self.debugEnabled) {
        NSLog(@"DELETE %@ - %@", URLString, parameters);
    }
    
    return [super DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) success(task, responseObject);
    } failure:failure];
}
    
@end
