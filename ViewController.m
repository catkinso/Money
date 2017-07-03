#import "ViewController.h"

#import "ViewControllerList.h"
#import "ViewControllerNew.h"
#import "ViewControllerUtil.h"
#import "ViewTransaction.h"
#import "DataManager.h"
#import "Transaction.h"

@implementation ViewController
{
    DataManager *dm;
    
    ViewControllerList *vcl;
    ViewControllerNew *vcn;
    ViewControllerUtil *vcu;
    
    ViewTransaction *vt;
    
    UILabel *dailySumLabel;
    UILabel *weeklySumLabel;
    UILabel *monthlySumLabel;
    UILabel *sumLabel;
    UILabel *lastTransactionTitleLabel;
    
    UILabel *sumTitleLabel;
    UILabel *categoryTitleLabels[5];
    UILabel *categorySumLabels[5];
    
    enum totalBoxMode boxMode;
}


- (void)viewDidLoad
{
    CGRect rect;
    
    UILabel *summaryTitleLabel;
    
    UIButton *listButton;
    UIButton *newTransactionButton;
    UIButton *utilitiesButton;
    
    CAShapeLayer *rectLayer;
    
    UIButton *monthButton;
    UIButton *weekButton;
    UIButton *dayButton;
    
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

    
    /* Last transaction box */
    rect = CGRectMake(25.0, 240.0, 320.0, 250.0);
    rectLayer = [CAShapeLayer layer];
    [rectLayer setPath:[[UIBezierPath bezierPathWithRect:rect] CGPath]];
    [rectLayer setFillColor:[[UIColor clearColor] CGColor]];
    [rectLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [[self.view layer] addSublayer:rectLayer];
    
    
    /* Month button */
    rect = CGRectMake(30.0, 220.0, 55.0, 20.0);
    monthButton = [[UIButton alloc] initWithFrame:rect];
    [monthButton addTarget:self action:@selector(monthButtonClicked)
              forControlEvents:UIControlEventTouchUpInside];
    [monthButton setTitle:@"Month" forState:UIControlStateNormal];
    monthButton.titleLabel.font = [monthButton.titleLabel.font
                                      fontWithSize:14];
    monthButton.contentHorizontalAlignment
                                     = UIControlContentHorizontalAlignmentLeft;
    [monthButton setTitleColor:[UIColor blueColor]
                          forState:UIControlStateNormal];
    [monthButton setTitleColor:[UIColor grayColor]
                          forState:UIControlStateHighlighted];
    [self.view addSubview:monthButton];
    
    
    /* Week button */
    rect = CGRectMake(110.0, 220.0, 45.0, 20.0);
    weekButton = [[UIButton alloc] initWithFrame:rect];
    [weekButton addTarget:self action:@selector(weekButtonClicked)
          forControlEvents:UIControlEventTouchUpInside];
    [weekButton setTitle:@"Week" forState:UIControlStateNormal];
    weekButton.titleLabel.font = [weekButton.titleLabel.font
                                   fontWithSize:14];
    weekButton.contentHorizontalAlignment
                                     = UIControlContentHorizontalAlignmentLeft;
    [weekButton setTitleColor:[UIColor blueColor]
                      forState:UIControlStateNormal];
    [weekButton setTitleColor:[UIColor grayColor]
                      forState:UIControlStateHighlighted];
    [self.view addSubview:weekButton];
    
    
    /* Day button */
    rect = CGRectMake(190.0, 220.0, 35.0, 20.0);
    dayButton = [[UIButton alloc] initWithFrame:rect];
    [dayButton addTarget:self action:@selector(dayButtonClicked)
          forControlEvents:UIControlEventTouchUpInside];
    [dayButton setTitle:@"Day" forState:UIControlStateNormal];
    dayButton.titleLabel.font = [dayButton.titleLabel.font
                                   fontWithSize:14];
    dayButton.contentHorizontalAlignment
                                     = UIControlContentHorizontalAlignmentLeft;
    [dayButton setTitleColor:[UIColor blueColor]
                      forState:UIControlStateNormal];
    [dayButton setTitleColor:[UIColor grayColor]
                      forState:UIControlStateHighlighted];
    [self.view addSubview:dayButton];
    
    
    /* Sum amount labels */
    rect = CGRectMake(30.0, 250.0, 110.0, 25.0);
    sumTitleLabel = [[UILabel alloc] initWithFrame:rect];
    
    [self.view addSubview:sumTitleLabel];
    
    rect = CGRectMake(150.0, 250.0, 140.0, 25.0);
    sumLabel = [[UILabel alloc] initWithFrame:rect];
    [self.view addSubview:sumLabel];
    int i;
    for (i = 0; i < 5; i++) {
        rect = CGRectMake(30.0, 280.0 + (i * 20), 90.0, 20.0);
        categoryTitleLabels[i] = [[UILabel alloc] initWithFrame:rect];
        categoryTitleLabels[i].font = [categoryTitleLabels[i].font
                                          fontWithSize:14];
        //categoryTitleLabels[i].text = @"Category_01:";
        [self.view addSubview:categoryTitleLabels[i]];
        rect = CGRectMake(130.0, 280.0 + (i * 20), 70.0, 20.0);
        categorySumLabels[i] = [[UILabel alloc] initWithFrame:rect];
        categorySumLabels[i].font = [categorySumLabels[i].font fontWithSize:14];
        //categorySumLabels[i].text = @"$1000.00";
        [self.view addSubview:categorySumLabels[i]];
    }
    boxMode = TOTAL_BOX_MODE_MONTH;

    /* Last transaction title label */
    rect = CGRectMake(30.0, 505.0, 110.0, 20.0);
    lastTransactionTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [lastTransactionTitleLabel setFont:[lastTransactionTitleLabel.font
                                   fontWithSize:12]];
    lastTransactionTitleLabel.text = @"Last Transaction";
    lastTransactionTitleLabel.textColor = [UIColor grayColor];
    [self.view addSubview:lastTransactionTitleLabel];

    
    /* Last transaction view */
    rect = CGRectMake(20.0, 520.0, 330.0, 110.0);
    vt = [[ViewTransaction alloc] initWithFrame:rect];
}


- (void)viewWillAppear:(BOOL)animated
{
    /* Add or remove last transaction label and view */
    vt.transactionToShow = [dm getLastTransaction];
    if (vt.transactionToShow != nil) {
        [self.view addSubview:vt];
        [self.view addSubview:lastTransactionTitleLabel];
    }
    else {
        [vt removeFromSuperview];
        [lastTransactionTitleLabel removeFromSuperview];
    }
    
    [self updateTotalBox];
}


- (void)updateTotalBox
{
    int i;
    Sums s;
    TopCategories tc;
    int (*dollarTotalPtr)[5];
    int (*centTotalPtr)[5];
    
    [dm getSums:&s];
    [dm getTopMonthCategories:&tc];
    
    switch (boxMode) {
        case TOTAL_BOX_MODE_MONTH:
            sumTitleLabel.text = @"Monthly Total:";
            sumLabel.text = [NSString stringWithFormat:@"$%d.%02d",
                                s.monthlyTotalDollars, s.monthlyTotalCents];
            dollarTotalPtr = &tc.monthlyCategoryTotalDollars;
            centTotalPtr = &tc.monthlyCategoryTotalCents;
            break;
        case TOTAL_BOX_MODE_WEEK:
            sumTitleLabel.text = @"Weekly Total:";
            sumLabel.text = [NSString stringWithFormat:@"$%d.%02d",
                                s.weeklyTotalDollars, s.weeklyTotalCents];
            dollarTotalPtr = &tc.weeklyCategoryTotalDollars;
            centTotalPtr = &tc.weeklyCategoryTotalCents;
            break;
        case TOTAL_BOX_MODE_DAY:
            sumTitleLabel.text = @"Daily Total:";
            sumLabel.text = [NSString stringWithFormat:@"$%d.%02d",
                                s.dailyTotalDollars, s.dailyTotalCents];
            dollarTotalPtr = &tc.dailyCategoryTotalDollars;
            centTotalPtr = &tc.dailyCategoryTotalCents;
            break;
    }

    for (i = 0; i < 5; i++) {
        categoryTitleLabels[i].text
                         = [NSString stringWithUTF8String:tc.categoryNames[i]];
        categorySumLabels[i].text = [NSString stringWithFormat:@"$%d.%02d",
                                     (*dollarTotalPtr)[i], (*centTotalPtr)[i]];
    }
}


- (void)eventButtonClicked
{
    [self presentViewController:vcl animated:NO completion:nil];
}


- (void)newTransactionButtonClicked
{
    [self presentViewController:vcn animated:NO completion:nil];
}


- (void)utilitiesButtonClicked
{
    [self presentViewController:vcu animated:NO completion:nil];
}


- (void)monthButtonClicked
{
    boxMode = TOTAL_BOX_MODE_MONTH;
    [self updateTotalBox];
}


- (void)weekButtonClicked
{
    boxMode = TOTAL_BOX_MODE_WEEK;
    [self updateTotalBox];
}


- (void)dayButtonClicked
{
    boxMode = TOTAL_BOX_MODE_DAY;
    [self updateTotalBox];
}

@end
