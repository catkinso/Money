#import <Foundation/Foundation.h>

@interface Transaction : NSObject <NSCoding>

@property (readwrite, retain) NSString *desc;
@property (readwrite, retain) NSString *category;
@property (readwrite) NSInteger costDollars;
@property (readwrite) NSInteger costCents;
@property (readwrite, retain) NSDate *date;
@property (readwrite, retain) NSString *uuid;

@end
