#import "Transaction.h"

@implementation Transaction

@synthesize desc;
@synthesize category;
@synthesize costDollars;
@synthesize costCents;
@synthesize date;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.desc forKey:@"description"];
    [encoder encodeObject:self.category forKey:@"category"];
    [encoder encodeInteger:self.costDollars forKey:@"costdollars"];
    [encoder encodeInteger:self.costCents forKey:@"costcents"];
    [encoder encodeObject:self.date forKey:@"date"];
}

 
- (id)initWithCoder:(NSCoder *)decoder
{
    Transaction *t;

    t = [[Transaction alloc] init];
    t.desc = [decoder decodeObjectForKey:@"description"];
    t.category = [decoder decodeObjectForKey:@"category"];
    t.costDollars = [decoder decodeIntegerForKey:@"costdollars"];
    t.costCents = [decoder decodeIntegerForKey:@"costcents"];
    t.date = [decoder decodeObjectForKey:@"date"];
    
    return t;
}

@end
