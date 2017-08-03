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
NSString * const kApiUsersPath = @"users.json";
NSString * const kApiFormsPath = @"forms.json";
NSString * const kApiBookingsPath = @"bookings.json";
NSString * const kApiAgendaPath = @"agenda.json";
NSString * const kApiFreePath = @"free.json";
NSString * const kApiChangesPath = @"changes.json";

@interface SSApiClient()
    
- (id)initAPI;

- (BOOL)isAuthenticated;
- (NSString *)authChecksum:(NSString *)username accountName:(NSString *)accountName accountPassword:(NSString *)accountPassword;
- (NSString *)authCredentials;
- (NSString *)md5:(NSString *)input;
- (BOOL)storeCredentials:(NSString *)checksum;
- (void)deleteCredentials;
- (NSString *)dateToApiString:(NSDate *)date;
    
- (BOOL)isSuccessfulAPIResponse:(id)responseObject
                       withTask:(NSURLSessionDataTask *)task
                      orFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSDictionary *)requestParams:(NSDictionary *)params;
    
- (NSURLSessionDataTask *)login:(NSString *)username
                    accountName:(NSString *)accountName
                accountPassword:(NSString *)accountPassword
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (void)logout;
- (NSURLSessionDataTask *)readUser:(NSString *)userId
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)readUsers:(NSNumber *)limit
                             offset:(NSNumber *)offset
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)createUser:(NSString *)name
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)createUser:(NSString *)name
                               email:(NSString *)email
                            password:(NSString *)password
                            fullName:(NSString *)fullName
                             address:(NSString *)address
                              mobile:(NSString *)mobile
                               phone:(NSString *)phone
                             country:(NSString *)country
                              field1:(NSString *)field1
                              field2:(NSString *)field2
                          superField:(NSString *)superField
                              credit:(NSString *)credit
                                role:(NSString *)role
                              userId:(NSString *)userId
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)updateUser:(NSString *)userId
                                name:(NSString *)name
                               email:(NSString *)email
                            password:(NSString *)password
                            fullName:(NSString *)fullName
                             address:(NSString *)address
                              mobile:(NSString *)mobile
                               phone:(NSString *)phone
                             country:(NSString *)country
                              field1:(NSString *)field1
                              field2:(NSString *)field2
                          superField:(NSString *)superField
                              credit:(NSString *)credit
                                role:(NSString *)role
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)deleteUser:(NSString *)userId
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)readForms:(NSString *)formDefinitionId
                             formId:(NSString *)formId
                               from:(NSDate *)from
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)readRecentChanges:(NSString *)scheduleId
                                       from:(NSDate *)from
                                       slot:(BOOL)slot
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)readAgenda:(NSString *)scheduleId
                                user:(NSString *)user
                                from:(NSDate *)from
                                slot:(BOOL)slot
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)readFree:(NSString *)scheduleId
                              from:(NSDate *)from
                            length:(NSNumber *)length
                          resource:(NSString *)resource
                              full:(BOOL)full
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)createBooking:(NSString *)scheduleId
                                 userId:(NSString *)userId
                                  start:(NSDate *)start
                                 finish:(NSDate *)finish
                                 slotId:(NSString *)slotId
                             resourceId:(NSString *)resourceId
                               fullName:(NSString *)fullName
                                address:(NSString *)address
                                 mobile:(NSString *)mobile
                                  phone:(NSString *)phone
                                country:(NSString *)country
                                  email:(NSString *)email
                                 field1:(NSString *)field1
                                 field2:(NSString *)field2
                                field1r:(NSString *)field1r
                                field2r:(NSString *)field2r
                             superField:(NSString *)superField
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)readBooking:(NSString *)scheduleId
                              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)readBookings:(NSString *)scheduleId
                                 limit:(NSNumber *)limit
                                 start:(NSDate *)start
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
- (NSURLSessionDataTask *)deleteBooking:(NSString *)bookingId
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
    self.debug = NO;
    self.keyChain = [UICKeyChainStore keyChainStoreWithService:kKeyChainStore];
    [self configSerialization];
    
    return self;
}

#pragma mark - Authentication

+ (BOOL)isAuthenticated {
    return [self.shared isAuthenticated];
}
    
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
    
- (BOOL)storeCredentials:(NSString *)checksum {
    NSError *error;
    
    [self.keyChain setString:checksum forKey:kApiAuthCredentialsKey error:&error];
    if (error) {
        NSLog(@"%@", error.localizedDescription);
        return NO;
    } else {
        return YES;
    }
}
    
- (void)deleteCredentials {
    [self.keyChain removeItemForKey:kApiAuthCredentialsKey];
}

- (NSString *)dateToApiString:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd"];
    return [format stringFromDate:date];
}
    
#pragma mark - Internal utilities
    
- (BOOL)isSuccessfulAPIResponse:(id)responseObject
                       withTask:(NSURLSessionDataTask *)task
                      orFailure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

}
    
- (NSDictionary *)requestParams:(NSDictionary *)params {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addEntriesFromDictionary:params];
    return dict;
}
    
- (NSString *)apiDate:(NSDate *)date {
    
}
    
#pragma mark - API Methods
    
+ (NSURLSessionDataTask *)login:(NSString *)username
                    accountName:(NSString *)accountName
                accountPassword:(NSString *)accountPassword
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared login:username accountName:accountName accountPassword:accountPassword success:success failure:failure];
}
    
- (NSURLSessionDataTask *)login:(NSString *)username
                    accountName:(NSString *)accountName
                accountPassword:(NSString *)accountPassword
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSURLSessionDataTask *task = [[NSURLSessionDataTask alloc] init];
    NSString *checksum = [self authChecksum:username accountName:accountName accountPassword:accountPassword];
    
    [self storeCredentials:checksum];
    
    NSDictionary *response = @{};
    success(task, response);
    
    return task;
}
    
+ (void)logout {
    [self.shared logout];
}
    
- (void)logout {
    [self deleteCredentials];
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
    NSDictionary *params = [self requestParams:@{}];
    return [self GET:path parameters:@{} success:success failure:failure];
}

+ (NSURLSessionDataTask *)readUsers:(NSNumber *)limit
                             offset:(NSNumber *)offset
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readUsers:limit offset:offset success:success failure:failure];

}
    
- (NSURLSessionDataTask *)readUsers:(NSNumber *)limit
                             offset:(NSNumber *)offset
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"limit": limit, @"offset": offset};
    params = [self requestParams:params];
    return [self GET:kApiUsersPath parameters:params success:success failure:failure];
}

+ (NSURLSessionDataTask *)createUser:(NSString *)name
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared createUser:name success:success failure:failure];
}

- (NSURLSessionDataTask *)createUser:(NSString *)name
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"name": name};
    params = [self requestParams:params];
    return [self POST:kApiUsersPath parameters:params success:success failure:failure];

}

+ (NSURLSessionDataTask *)createUser:(NSString *)name
                               email:(NSString *)email
                            password:(NSString *)password
                            fullName:(NSString *)fullName
                             address:(NSString *)address
                              mobile:(NSString *)mobile
                               phone:(NSString *)phone
                             country:(NSString *)country
                              field1:(NSString *)field1
                              field2:(NSString *)field2
                          superField:(NSString *)superField
                              credit:(NSString *)credit
                                role:(NSString *)role
                              userId:(NSString *)userId
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared createUser:name email:email password:password fullName:fullName address:address mobile:mobile phone:phone country:country field1:field1 field2:field2 superField:superField credit:credit role:role userId:userId success:success failure:failure];
    
}
    
- (NSURLSessionDataTask *)createUser:(NSString *)name
                               email:(NSString *)email
                            password:(NSString *)password
                            fullName:(NSString *)fullName
                             address:(NSString *)address
                              mobile:(NSString *)mobile
                               phone:(NSString *)phone
                             country:(NSString *)country
                              field1:(NSString *)field1
                              field2:(NSString *)field2
                          superField:(NSString *)superField
                              credit:(NSString *)credit
                                role:(NSString *)role
                              userId:(NSString *)userId
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"name": name, @"email": email, @"password": password, @"fullName": fullName, @"address": address, @"mobile": mobile, @"phone": phone, @"country": country, @"field1": field1, @"field2": field2, @"superField": superField, @"credit": credit, @"role": role, @"userId": userId};
    params = [self requestParams:params];
    return [self POST:kApiUsersPath parameters:params success:success failure:failure];
}
    
+ (NSURLSessionDataTask *)updateUser:(NSString *)userId
                                name:(NSString *)name
                               email:(NSString *)email
                            password:(NSString *)password
                            fullName:(NSString *)fullName
                             address:(NSString *)address
                              mobile:(NSString *)mobile
                               phone:(NSString *)phone
                             country:(NSString *)country
                              field1:(NSString *)field1
                              field2:(NSString *)field2
                          superField:(NSString *)superField
                              credit:(NSString *)credit
                                role:(NSString *)role
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared updateUser:userId name:name email:email password:password fullName:fullName address:address mobile:mobile phone:phone country:country field1:field1 field2:field2 superField:superField credit:credit role:role success:success failure:failure];
}
    
- (NSURLSessionDataTask *)updateUser:(NSString *)userId
                                name:(NSString *)name
                               email:(NSString *)email
                            password:(NSString *)password
                            fullName:(NSString *)fullName
                             address:(NSString *)address
                              mobile:(NSString *)mobile
                               phone:(NSString *)phone
                             country:(NSString *)country
                              field1:(NSString *)field1
                              field2:(NSString *)field2
                          superField:(NSString *)superField
                              credit:(NSString *)credit
                                role:(NSString *)role
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"name": name, @"email": email, @"password": password, @"full-name": fullName, @"address": address, @"mobile": mobile, @"phone": phone, @"country": country, @"field-1": field1, @"field-2": field2, @"super-field": superField, @"credit": credit, @"role": role};
    params = [self requestParams:params];
    return [self PUT:kApiUsersPath parameters:params success:success failure:failure];
}
    
+ (NSURLSessionDataTask *)deleteUser:(NSString *)userId
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared deleteUser:userId success:success failure:failure];
}
    
- (NSURLSessionDataTask *)deleteUser:(NSString *)userId
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"%@/%@", kApiUsersPath, userId];
    NSDictionary *params = [self requestParams:@{}];
    return [self DELETE:path parameters:params success:success failure:failure];
}
    
+ (NSURLSessionDataTask *)readForms:(NSString *)formDefinitionId
                             formId:(NSString *)formId
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self readForms:formDefinitionId formId:formId from:NULL success:success failure:failure];
}
    
+ (NSURLSessionDataTask *)readForms:(NSString *)formDefinitionId
                             formId:(NSString *)formId
                               from:(NSDate *)from
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readForms:formDefinitionId formId:formId from:from success:success failure:failure];
}
    
- (NSURLSessionDataTask *)readForms:(NSString *)formDefinitionId
                             formId:(NSString *)formId
                               from:(NSDate *)from
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSDictionary *params = @{@"form_id": formDefinitionId};
    if (formId != NULL) {
        params = @{@"form_id": formDefinitionId, @"id": formId};
    }
    params = [self requestParams:params];
    return [self POST:kApiFormsPath parameters:params success:success failure:failure];
    
}
    
+ (NSURLSessionDataTask *)readRecentChanges:(NSString *)scheduleId
                                       from:(NSDate *)from
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self readRecentChanges:scheduleId from:from slot:NO success:success failure:failure];
}
    
+ (NSURLSessionDataTask *)readRecentChanges:(NSString *)scheduleId
                                       from:(NSDate *)from
                                       slot:(BOOL)slot
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readRecentChanges:scheduleId from:from slot:slot success:success failure:failure];
}
    
- (NSURLSessionDataTask *)readRecentChanges:(NSString *)scheduleId
                                       from:(NSDate *)from
                                       slot:(BOOL)slot
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSMutableDictionary *params = @{@"schedule_id": scheduleId, @"from": from};
    if (slot) {
        [params addEntriesFromDictionary:@{@"slot": @"true"}];
    }
    params = [self requestParams:params];
    return [self POST:kApiChangesPath parameters:params success:success failure:failure];
}

+ (NSURLSessionDataTask *)readAgenda:(NSString *)scheduleId
                                user:(NSString *)user
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self readAgenda:scheduleId user:user from:NULL slot:NO success:success failure:failure];
}
    
+ (NSURLSessionDataTask *)readAgenda:(NSString *)scheduleId
                                user:(NSString *)user
                                from:(NSDate *)from
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readAgenda:scheduleId user:user from:from slot:NO success:success failure:failure];
}
    
+ (NSURLSessionDataTask *)readAgenda:(NSString *)scheduleId
                                user:(NSString *)user
                                from:(NSDate *)from
                                slot:(BOOL)slot
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readAgenda:scheduleId user:user from:from slot:slot success:success failure:failure];
}
    
- (NSURLSessionDataTask *)readAgenda:(NSString *)scheduleId
                                user:(NSString *)user
                                from:(NSDate *)from
                                slot:(BOOL)slot
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSMutableDictionary *params = @{@"user": user, @"from": from};
    if (slot) {
        [params addEntriesFromDictionary:@{@"slot": @"true"}];
    }
    NSString *path = [NSString stringWithFormat:@"%@/%@", kApiAgendaPath, scheduleId];
    
    params = [self requestParams:params];
    return [self GET:path parameters:params success:success failure:failure];
}

+ (NSURLSessionDataTask *)readFree:(NSString *)scheduleId
                              from:(NSDate *)from
                            length:(NSNumber *)length
                          resource:(NSString *)resource
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readFree:scheduleId from:from length:length resource:resource full:NO success:success failure:failure];
}
    
+ (NSURLSessionDataTask *)readFree:(NSString *)scheduleId
                              from:(NSDate *)from
                            length:(NSNumber *)length
                          resource:(NSString *)resource
                              full:(BOOL)full
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readFree:scheduleId from:from length:length resource:resource full:full success:success failure:failure];
}

- (NSURLSessionDataTask *)readFree:(NSString *)scheduleId
                              from:(NSDate *)from
                            length:(NSNumber *)length
                          resource:(NSString *)resource
                              full:(BOOL)full
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSMutableDictionary *params = @{@"from": from};
    if (length > 0) {
        [params addEntriesFromDictionary:@{@"length": length}];
    }
    if (resource != NULL) {
        [params addEntriesFromDictionary:@{@"resource": resource}];
    }
    if (full) {
        [params addEntriesFromDictionary:@{@"full": @"true"}];
    }
    NSString *path = [NSString stringWithFormat:@"%@/%@", kApiFreePath, scheduleId];
    
    params = [self requestParams:params];
    return [self GET:path parameters:params success:success failure:failure];
    
}

+ (NSURLSessionDataTask *)createBooking:(NSString *)scheduleId
                                 userId:(NSString *)userId
                                  start:(NSDate *)start
                                 finish:(NSDate *)finish
                                 slotId:(NSString *)slotId
                             resourceId:(NSString *)resourceId
                               fullName:(NSString *)fullName
                                address:(NSString *)address
                                 mobile:(NSString *)mobile
                                  phone:(NSString *)phone
                                country:(NSString *)country
                                  email:(NSString *)email
                                 field1:(NSString *)field1
                                 field2:(NSString *)field2
                                field1r:(NSString *)field1r
                                field2r:(NSString *)field2r
                             superField:(NSString *)superField
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared createBooking:scheduleId userId:userId start:start finish:finish slotId:slotId resourceId:resourceId fullName:fullName address:address mobile:mobile phone:phone country:country email:email field1:field1 field2:field2 field1r:field1r field2r:field2r superField:superField success:success failure:failure];
    
}

- (NSURLSessionDataTask *)createBooking:(NSString *)scheduleId
                                 userId:(NSString *)userId
                                  start:(NSDate *)start
                                 finish:(NSDate *)finish
                                 slotId:(NSString *)slotId
                             resourceId:(NSString *)resourceId
                               fullName:(NSString *)fullName
                                address:(NSString *)address
                                 mobile:(NSString *)mobile
                                  phone:(NSString *)phone
                                country:(NSString *)country
                                  email:(NSString *)email
                                 field1:(NSString *)field1
                                 field2:(NSString *)field2
                                field1r:(NSString *)field1r
                                field2r:(NSString *)field2r
                             superField:(NSString *)superField
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSMutableDictionary *params = @{@"schedule_id": scheduleId, @"booking[full_name]": fullName, @"booking[address]": address, @"booking[mobile]": mobile, @"booking[phone]": phone, @"booking[country]": country, @"booking[email]": email};
    NSMutableDictionary *obj = @{@"full_name": fullName, @"address": address, @"mobile": mobile, @"phone": phone, @"country": country, @"email": email};
    
    if (userId != NULL) {
        [params setObject:userId forKey:@"user_id"];
    }
    if (resourceId != NULL) {
        [params setObject:resourceId forKey:@"resource_id"];
        [obj setObject:start forKey:@"start"];
        [obj setObject:finish forKey:@"finish"];
    } else if (slotId != NULL) {
        [obj setObject:slotId forKey:@"slot_id"];
    }
    [params setObject:obj forKey:@"booking"];
    return [self POST:kApiBookingsPath parameters:params success:success failure:failure];
}

+ (NSURLSessionDataTask *)readBooking:(NSString *)scheduleId
                              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self readBooking:scheduleId success:success failure:failure];
}

- (NSURLSessionDataTask *)readBooking:(NSString *)scheduleId
                              success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                              failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"%@/%@", kApiBookingsPath, scheduleId];
    return [self GET:path parameters:@{} success:success failure:failure];
}

+ (NSURLSessionDataTask *)readBookings:(NSString *)scheduleId
                                 limit:(NSNumber *)limit
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readBookings:scheduleId limit:limit start:NULL success:success failure:failure];
}

+ (NSURLSessionDataTask *)readBookings:(NSString *)scheduleId
                                 start:(NSDate *)start
                                 limit:(NSNumber *)limit
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared readBookings:scheduleId limit:limit start:start success:success failure:failure];
}

- (NSURLSessionDataTask *)readBookings:(NSString *)scheduleId
                                 limit:(NSNumber *)limit
                                 start:(NSDate *)start
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSMutableDictionary *params = @{};
    if (scheduleId) {
        [params addEntriesFromDictionary:@{@"schedule_id": scheduleId}];
    }
    if (limit > 0) {
        [params addEntriesFromDictionary:@{@"limit": limit}];
    }
    
    params = [self requestParams:params];
    return [self GET:kApiBookingsPath parameters:params success:success failure:failure];
}

+ (NSURLSessionDataTask *)deleteBooking:(NSString *)bookingId
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    return [self.shared deleteBooking:bookingId success:success failure:failure];
}

- (NSURLSessionDataTask *)deleteBooking:(NSString *)bookingId
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    NSString *path = [NSString stringWithFormat:@"%@/%@", kApiBookingsPath, bookingId];
    NSDictionary *params = [self requestParams:@{}];
    return [self DELETE:path parameters:params success:success failure:failure];
    
}

@end
