#import "ViewTransaction.h"

#import "Transaction.h"

@implementation ViewTransaction
{
    Transaction *t;
    
    UILabel *dateLabel;
    UILabel *catLabel;
    UILabel *descLabel;
    UILabel *costLabel;
}


@synthesize transactionToShow = t;
- (void)setTransactionToShow:(Transaction *)transactionToShow
{
    t = transactionToShow;
    
    [self transactionToLabels];
}


- (id)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];

    if (self) {
        CGRect r;
        
        UILabel *dateTitleLabel;
        UILabel *catTitleLabel;
        UILabel *descTitleLabel;
        UILabel *costTitleLabel;
        
        CAShapeLayer *rectLayer;
        

        /* Last transaction box */
        r = CGRectMake(5.0, 5.0, 320.0, 100.0);
        rectLayer = [CAShapeLayer layer];
        [rectLayer setPath:[[UIBezierPath bezierPathWithRect:r] CGPath]];
        [rectLayer setFillColor:[[UIColor clearColor] CGColor]];
        [rectLayer setStrokeColor:[[UIColor blackColor] CGColor]];
        [[self layer] addSublayer:rectLayer];

        
        /* Last transaction date labels */
        r = CGRectMake(10.0, 15.0, 100.0, 20.0);
        dateTitleLabel = [[UILabel alloc] initWithFrame:r];
        [dateTitleLabel setFont: [dateTitleLabel.font fontWithSize:12]];
        dateTitleLabel.text = @"Date";
        [self addSubview:dateTitleLabel];
        
        r = CGRectMake(110.0, 15.0, 200.0, 20.0);
        dateLabel = [[UILabel alloc] initWithFrame:r];
        [dateLabel setFont: [dateLabel.font fontWithSize:12]];
        [self addSubview:dateLabel];
        

        /* Last transaction category labels */
        r = CGRectMake(10.0, 35.0, 100.0, 20.0);
        catTitleLabel = [[UILabel alloc] initWithFrame:r];
        [catTitleLabel setFont:[catTitleLabel.font fontWithSize:12]];
        catTitleLabel.text = @"Category";
        [self addSubview:catTitleLabel];
        
        rect = CGRectMake(110.0, 35.0, 100.0, 20.0);
        catLabel = [[UILabel alloc] initWithFrame:rect];
        [catLabel setFont:[catTitleLabel.font fontWithSize:12]];
        [self addSubview:catLabel];
        

        /* Last transaction description labels */
        r = CGRectMake(10.0, 55.0, 100.0, 20.0);
        descTitleLabel = [[UILabel alloc] initWithFrame:r];
        [descTitleLabel setFont:[descTitleLabel.font fontWithSize:12]];
        descTitleLabel.text = @"Description";
        [self addSubview:descTitleLabel];
        
        r = CGRectMake(110.0, 55.0, 200.0, 20.0);
        descLabel = [[UILabel alloc] initWithFrame:r];
        [descLabel setFont:[descLabel.font fontWithSize:12]];
        [self addSubview:descLabel];
        

        /* Last transaction cost labels */
        r = CGRectMake(10.0, 75.0, 100.0, 20.0);
        costTitleLabel = [[UILabel alloc] initWithFrame:r];
        [costTitleLabel setFont: [costTitleLabel.font fontWithSize:12]];
        costTitleLabel.text = @"Cost";
        [self addSubview:costTitleLabel];
        
        r = CGRectMake(110.0, 75.0, 100.0, 20.0);
        costLabel = [[UILabel alloc] initWithFrame:r];
        [costLabel setFont: [costTitleLabel.font fontWithSize:12]];
        [self addSubview:costLabel];
        
        
        [self transactionToLabels];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)rect Transaction:(Transaction *)transactionToShow
{
    self = [self initWithFrame:rect];
    
    if (self)
        t = transactionToShow;

    return self;
}


- (void)transactionToLabels
{
    if (t != nil) {
        NSDateFormatter *df;
        
        catLabel.text = t.category;
        descLabel.text = t.desc;
        costLabel.text = [NSString stringWithFormat:@"$%d.%02d",
                             (int)t.costDollars, (int)t.costCents];
        df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"MM/dd/yyyy"];
        dateLabel.text = [df stringFromDate:t.date];
    }
    else {
        catLabel.text = @"-";
        descLabel.text = @"-";
        costLabel.text = @"0.00";
        dateLabel.text = @"-";
    }
}

@end
