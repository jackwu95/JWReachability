//
//  JWReachability.h
//
//  Created by Jack Wu on 2014-03-12.
//

#import <Foundation/Foundation.h>

@interface JWReachability : NSObject

+(BOOL)isServerAvailable:(NSString*)url withTimeOut:(CGFloat)seconds;

+(BOOL)isGoogleAvailableWithTimeout:(CGFloat) seconds;
+(BOOL)isFacebookAvailableWithTimeout:(CGFloat)seconds;

@end
