#import "ViewController.h"

#import "ViewControllerList.h"
#import "ViewControllerNew.h"
#import "ViewControllerUtil.h"
#import "DataManager.h"
#import "Transaction.h"

@implementation ViewController
{
    DataManager *dm;
    
    ViewControllerList *vcl;
    ViewControllerNew *vcn;
    ViewControllerUtil *vcu;
    
    UILabel *sumLabel;
    UILabel *dateLabel;
    UILabel *catLabel;
    UILabel *descLabel;
    UILabel *costLabel;
}

- (void)viewDidLoad {
    CGRect rect;
    
    UILabel *summaryTitleLabel;
    UILabel *sumTitleLabel;
    UILabel *latestTransactionTitleLabel;
    UILabel *dateTitleLabel;
    UILabel *catTitleLabel;
    UILabel *descTitleLabel;
    UILabel *costTitleLabel;
    
    UIButton *listButton;
    UIButton *newTransactionButton;
    UIButton *utilitiesButton;
    
    CAShapeLayer *rectLayer;
    
    
    [super viewDidLoad];
    
    dm = [[DataManager alloc] init];
    vcl = [[ViewControllerList alloc] initWithDataManager:dm];
    vcn = [[ViewControllerNew alloc] initWithDataManager:dm];
    vcu = [[ViewControllerUtil alloc] initWithDataManager:dm];

   
    /* Title label */
    rect = CGRectMake(30.0, 40.0, 100.0, 35.0);
    summaryTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [summaryTitleLabel setFont:[summaryTitleLabel.font fontWithSize:28]];
    summaryTitleLabel.text = @"Money";
    [self.view addSubview:summaryTitleLabel];
    

    /* Transactions button */
    rect = CGRectMake(30.0, 80.0, 110.0, 25.0);
    listButton = [[UIButton alloc] initWithFrame:rect];
    [listButton addTarget:self action:@selector(eventButtonClicked)
                    forControlEvents:UIControlEventTouchUpInside];
    [listButton setTitle:@"Transactions" forState:UIControlStateNormal];
    listButton.contentHorizontalAlignment
                   = UIControlContentHorizontalAlignmentLeft;
    [listButton setTitleColor:[UIColor blueColor]
                    forState:UIControlStateNormal];
    [listButton setTitleColor:[UIColor grayColor]
                    forState:UIControlStateHighlighted];
    [self.view addSubview:listButton];
    
    
    /* New transaction button */
    rect = CGRectMake(30.0, 120.0, 140.0, 25.0);
    newTransactionButton = [[UIButton alloc] initWithFrame:rect];
    [newTransactionButton addTarget:self
                              action:@selector(newTransactionButtonClicked)
                              forControlEvents:UIControlEventTouchUpInside];
    [newTransactionButton setTitle:@"New Transaction"
                              forState:UIControlStateNormal];
    newTransactionButton.contentHorizontalAlignment
                             = UIControlContentHorizontalAlignmentLeft;
    [newTransactionButton setTitleColor:[UIColor blueColor]
                              forState:UIControlStateNormal];
    [newTransactionButton setTitleColor:[UIColor grayColor]
                              forState:UIControlStateHighlighted];
    [self.view addSubview:newTransactionButton];

    
    /* Utilities button */
    rect = CGRectMake(30.0, 160.0, 70.0, 25.0);
    utilitiesButton = [[UIButton alloc] initWithFrame:rect];
    [utilitiesButton addTarget:self action:@selector(utilitiesButtonClicked)
                         forControlEvents:UIControlEventTouchUpInside];
    [utilitiesButton setTitle:@"Utilities" forState:UIControlStateNormal];
    utilitiesButton.contentHorizontalAlignment
                        = UIControlContentHorizontalAlignmentLeft;
    [utilitiesButton setTitleColor:[UIColor blueColor]
                         forState:UIControlStateNormal];
    [utilitiesButton setTitleColor:[UIColor grayColor]
                         forState:UIControlStateHighlighted];
    [self.view addSubview:utilitiesButton];


    /* Sum amount labels */
    rect = CGRectMake(30.0, 410.0, 140.0, 25.0);
    sumTitleLabel = [[UILabel alloc] initWithFrame:rect];
    sumTitleLabel.text = @"Total:";
    [self.view addSubview:sumTitleLabel];
    
    rect = CGRectMake(130.0, 410.0, 140.0, 25.0);
    sumLabel = [[UILabel alloc] initWithFrame:rect];
    [self.view addSubview:sumLabel];
    
    
    /* Last transaction title label */
    rect = CGRectMake(30.0, 460.0, 110.0, 20.0);
    latestTransactionTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [latestTransactionTitleLabel setFont:[latestTransactionTitleLabel.font
                                     fontWithSize:12]];
    latestTransactionTitleLabel.text = @"Latest Transaction";
    latestTransactionTitleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:latestTransactionTitleLabel];
    
    
    /* Last transaction box */
    rect = CGRectMake(25.0, 480.0, 320.0, 100.0);
    rectLayer = [CAShapeLayer layer];
    [rectLayer setPath:[[UIBezierPath bezierPathWithRect:rect] CGPath]];
    [rectLayer setFillColor:[[UIColor clearColor] CGColor]];
    [rectLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [[self.view layer] addSublayer:rectLayer];

    
    /* Last transaction date labels */
    rect = CGRectMake(30.0, 490.0, 100.0, 20.0);
    dateTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [dateTitleLabel setFont: [dateTitleLabel.font fontWithSize:12]];
    dateTitleLabel.text = @"Date";
    [self.view addSubview:dateTitleLabel];
    
    rect = CGRectMake(130.0, 490.0, 200.0, 20.0);
    dateLabel = [[UILabel alloc] initWithFrame:rect];
    [dateLabel setFont: [dateLabel.font fontWithSize:12]];
    [self.view addSubview:dateLabel];
    
    
    /* Last transaction category labels */
    rect = CGRectMake(30.0, 510.0, 100.0, 20.0);
    catTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [catTitleLabel setFont:[catTitleLabel.font fontWithSize:12]];
    catTitleLabel.text = @"Category";
    [self.view addSubview:catTitleLabel];
    
    rect = CGRectMake(130.0, 510.0, 100.0, 20.0);
    catLabel = [[UILabel alloc] initWithFrame:rect];
    [catLabel setFont:[catTitleLabel.font fontWithSize:12]];
    [self.view addSubview:catLabel];

    
    /* Last transaction description labels */
    rect = CGRectMake(30.0, 530.0, 100.0, 20.0);
    descTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [descTitleLabel setFont:[descTitleLabel.font fontWithSize:12]];
    descTitleLabel.text = @"Description";
    [self.view addSubview:descTitleLabel];
    
    rect = CGRectMake(130.0, 530.0, 200.0, 20.0);
    descLabel = [[UILabel alloc] initWithFrame:rect];
    [descLabel setFont:[descLabel.font fontWithSize:12]];
    [self.view addSubview:descLabel];

    
    /* Last transaction cost labels */
    rect = CGRectMake(30.0, 550.0, 100.0, 20.0);
    costTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [costTitleLabel setFont: [costTitleLabel.font fontWithSize:12]];
    costTitleLabel.text = @"Cost";
    [self.view addSubview:costTitleLabel];
    
    rect = CGRectMake(130.0, 550.0, 100.0, 20.0);
    costLabel = [[UILabel alloc] initWithFrame:rect];
    [costLabel setFont: [costTitleLabel.font fontWithSize:12]];
    [self.view addSubview:costLabel];
}


- (void)viewWillAppear:(BOOL)animated {
    int d, c;
    Transaction *lastTransaction;
    
    [dm getTotalDollars:&d Cents:&c];
    sumLabel.text = [NSString stringWithFormat:@"$%d.%02d", d, c];

    lastTransaction = [dm getLastTransaction];
    if (lastTransaction == nil) {
        catLabel.text = @"-";
        descLabel.text = @"-";
        costLabel.text = @"0.00";
        dateLabel.text = @"-";
    }
    else {
        catLabel.text = lastTransaction.category;
        descLabel.text = lastTransaction.desc;
        costLabel.text = [NSString stringWithFormat:@"$%d.%02d",
                             (int)lastTransaction.costDollars,
                             (int)lastTransaction.costCents];
        dateLabel.text = [NSDateFormatter
                             localizedStringFromDate:lastTransaction.date
                             dateStyle:NSDateFormatterShortStyle
                             timeStyle:NSDateFormatterShortStyle];
    }
}


- (void)eventButtonClicked {
    [self presentViewController:vcl animated:NO completion:nil];
}


- (void)newTransactionButtonClicked {
    [self presentViewController:vcn animated:NO completion:nil];
}


- (void)utilitiesButtonClicked {
    [self presentViewController:vcu animated:NO completion:nil];
}

@end
