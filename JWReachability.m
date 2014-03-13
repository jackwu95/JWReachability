//
//  JWReachability.m
//
//  Created by Jack Wu on 2014-03-12.
//

#import "JWReachability.h"
@import SystemConfiguration;

@implementation JWReachability

+(BOOL)isGoogleAvailableWithTimeout:(CGFloat) seconds {
    return [JWReachability isServerAvailable:@"www.google.com" withTimeOut:seconds];
}

+(BOOL)isFacebookAvailableWithTimeout:(CGFloat)seconds {
    return [JWReachability isServerAvailable:@"www.facebook.com" withTimeOut:seconds];
}

+(BOOL)isServerAvailable:(NSString*)url withTimeOut:(CGFloat)seconds {
	const char *host_name = [url UTF8String]; // your data source host name
    printf("Checking server:%s...",host_name);
    NSDate * date = [NSDate date];

    dispatch_queue_t queue = dispatch_queue_create("reachabilityqueue", DISPATCH_QUEUE_SERIAL);
    
    __block BOOL _isDataSourceAvailable;
    __block BOOL returned = NO;
    __block Boolean success;
	__block SCNetworkReachabilityFlags flags;

    dispatch_async(queue, ^{
        SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
        success = SCNetworkReachabilityGetFlags(reachability, &flags);
        _isDataSourceAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
        CFRelease(reachability);
        returned = YES;
    });
    
    // dispatch_release(queue);
    while (!returned && (-[date timeIntervalSinceNow]) < seconds) {
        printf(".");
        usleep(50000);
    }
    printf("\n");

    
    if (!returned) {
        NSLog(@"Timed out after %.3fs",-[date timeIntervalSinceNow]);
        return NO;
    }
    NSLog(@"Completed in %.3fs",-[date timeIntervalSinceNow]);
    return _isDataSourceAvailable;

}

@end
