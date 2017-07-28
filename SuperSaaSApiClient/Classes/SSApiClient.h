//
//  SSApiClient.h
//  Pods
//
//  Created by Monty Cantsin on 28/07/17.
//
//

#import <UIKit/UIKit.h>
#import "SSHTTPSessionManager.h"

@interface SSApiClient : SSHTTPSessionManager
    
+ (instancetype)shared;
    
+ (NSURLSessionDataTask *)login:(NSString *)username
                    accountName:(NSString *)accountName
                accountPassword:(NSString *)accountPassword
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
+ (NSURLSessionDataTask *)logout:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)readUser:(NSString *)userId
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)readUsers:(NSNumber *)limit
                             offset:(NSNumber *)offset
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)createUser:(NSString *)name
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
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
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
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
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)deleteUser:(NSString *)userId
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
+ (NSURLSessionDataTask *)readForms:(NSString *)formDefinitionId
                             formId:(NSString *)formId
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
+ (NSURLSessionDataTask *)readForms:(NSString *)formDefinitionId
                             formId:(NSString *)formId
                               from:(NSDate *)from
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
+ (NSURLSessionDataTask *)readRecentChanges:(NSString *)scheduleId
                                       from:(NSDate *)from
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
+ (NSURLSessionDataTask *)readRecentChanges:(NSString *)scheduleId
                                       from:(NSDate *)from
                                       slot:(BOOL)slot
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)readAgenda:(NSString *)scheduleId
                                user:(NSString *)user
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)readAgenda:(NSString *)scheduleId
                                user:(NSString *)user
                                from:(NSDate *)from
                             success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                             failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)readFree:(NSString *)scheduleId
                              from:(NSDate *)from
                            length:(NSNumber *)length
                          resource:(NSString *)resource
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (NSURLSessionDataTask *)readFree:(NSString *)scheduleId
                              from:(NSDate *)from
                            length:(NSNumber *)length
                          resource:(NSString *)resource
                              full:(BOOL)full
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
+ (NSURLSessionDataTask *)createBooking:(NSString *)scheduleId
                                 userId:(NSString *)userId
                                  start:(NSDate *)start
                                 finish:(NSDate *)finish
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
    
+ (NSURLSessionDataTask *)createBooking:(NSString *)scheduleId
                                 userId:(NSString *)userId
                                 slotId:(NSString *)slotId
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
    
+ (NSURLSessionDataTask *)updateBooking:(NSString *)bookingId
                                 userId:(NSString *)userId
                                 slotId:(NSString *)slotId
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
    
+ (NSURLSessionDataTask *)readBooking:(NSString *)bookingId
                           success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
+ (NSURLSessionDataTask *)readBookings:(NSString *)bookingId
                                 limit:(NSNumber *)limit
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
+ (NSURLSessionDataTask *)readBookings:(NSString *)bookingId
                                 start:(NSDate *)start
                                 limit:(NSNumber *)limit
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                               failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
+ (NSURLSessionDataTask *)deleteBooking:(NSString *)bookingId
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
    
@end
