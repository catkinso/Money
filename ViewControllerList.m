#import "ViewControllerList.h"

#import "DataManager.h"
#import "Transaction.h"
#import "ViewControllerNew.h"

@implementation ViewControllerList
{
    DataManager *dm;
    Transaction *ts[3];
    ViewControllerNew *vcn;

    UIButton *backButton;
    UIButton *editButtons[3];
    UIButton *deleteButtons[3];
    
    UILabel *totalTransactionsLabel;
    UILabel *dateLabels[3];
    UILabel *numTransactionLabels[3];
    UILabel *catLabels[3];
    UILabel *descLabels[3];
    UILabel *costLabels[3];
}

- (id)initWithDataManager:(DataManager *)dataMgr {
    self = [super init];
    
    if (self)
        dm = dataMgr;

    return self;
}


- (void)viewDidLoad {
    int i;
    
    CGRect rect;
    
    UILabel *eventTitleLabel;
    UILabel *totalTransactionsTitleLabel;
    UILabel *dateTitleLabels[3];
    UILabel *catTitleLabels[3];
    UILabel *descTitleLabels[3];
    UILabel *costTitleLabels[3];
    
    CAShapeLayer *rectLayers[3];

    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    /* Title label */
    rect = CGRectMake(30.0, 40.0, 180.0, 35.0);
    eventTitleLabel = [[UILabel alloc] initWithFrame:rect];
    [eventTitleLabel setFont:[eventTitleLabel.font fontWithSize:28]];
    eventTitleLabel.text = @"Transactions";
    [self.view addSubview:eventTitleLabel];
    
    
    /* Back button */
    rect = CGRectMake(30.0, 80.0, 50.0, 25.0);
    backButton = [[UIButton alloc] initWithFrame:rect];
    [backButton addTarget:self action:@selector(backButtonClicked)
                    forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.contentHorizontalAlignment
                   = UIControlContentHorizontalAlignmentLeft;
    [backButton setTitleColor:[UIColor blueColor]
                    forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor grayColor]
                    forState:UIControlStateHighlighted];
    [self.view addSubview:backButton];

    
    /* Total transactions labels */
    rect = CGRectMake(30.0, 150, 150.0, 25.0);
    totalTransactionsTitleLabel = [[UILabel alloc] initWithFrame:rect];
    totalTransactionsTitleLabel.text = @"Total Transactions:";
    [self.view addSubview:totalTransactionsTitleLabel];
    
    rect = CGRectMake(190.0, 150, 80.0, 25.0);
    totalTransactionsLabel = [[UILabel alloc] initWithFrame:rect];
    [self.view addSubview:totalTransactionsLabel];

    
    /* Three transactions */
    for (i = 0; i < 3; i++) {
        
        /* Transaction number label */
        rect = CGRectMake(30.0, 182.0 + (140.0 * i), 50.0, 20.0);
        numTransactionLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [numTransactionLabels[i] setFont:[numTransactionLabels[i].font
                                     fontWithSize:12]];
        numTransactionLabels[i].text = @"-";
        numTransactionLabels[i].textColor = [UIColor grayColor];
        numTransactionLabels[i].textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:numTransactionLabels[i]];

        
        /* Transaction box */
        rect = CGRectMake(25.0, 200.0 + (140.0 * i), 320.0, 100.0);
        rectLayers[i] = [CAShapeLayer layer];
        [rectLayers[i] setPath:[[UIBezierPath bezierPathWithRect:rect] CGPath]];
        [rectLayers[i] setFillColor:[[UIColor clearColor] CGColor]];
        [rectLayers[i] setStrokeColor:[[UIColor blackColor] CGColor]];
        [[self.view layer] addSublayer:rectLayers[i]];

        
        /* Transaction date labels */
        rect = CGRectMake(30.0, 210.0 + (140.0 * i), 100.0, 20.0);
        dateTitleLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [dateTitleLabels[i] setFont:[dateTitleLabels[i].font fontWithSize:12]];
        dateTitleLabels[i].text = @"Date";
        [self.view addSubview:dateTitleLabels[i]];

        rect = CGRectMake(130.0, 210.0 + (140.0 * i), 200.0, 20.0);
        dateLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [dateLabels[i] setFont:[dateLabels[i].font fontWithSize:12]];
        [self.view addSubview:dateLabels[i]];


        /* Transaction category labels */
        rect = CGRectMake(30.0, 230.0 + (140.0 * i), 100.0, 20.0);
        catTitleLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [catTitleLabels[i] setFont:[catTitleLabels[i].font fontWithSize:12]];
        catTitleLabels[i].text = @"Category";
        [self.view addSubview:catTitleLabels[i]];

        rect = CGRectMake(130.0, 230.0 + (140.0 * i), 100.0, 20.0);
        catLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [catLabels[i] setFont:[catLabels[i].font fontWithSize:12]];
        [self.view addSubview:catLabels[i]];
        
        
        /* Transaction description labels */
        rect = CGRectMake(30.0, 250.0 + (140.0 * i), 100.0, 20.0);
        descTitleLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [descTitleLabels[i] setFont:[descTitleLabels[i].font fontWithSize:12]];
        descTitleLabels[i].text = @"Description";
        [self.view addSubview:descTitleLabels[i]];
        
        rect = CGRectMake(130.0, 250.0 + (140.0 * i), 200.0, 20.0);
        descLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [descLabels[i] setFont:[descLabels[i].font fontWithSize:12]];
        [self.view addSubview:descLabels[i]];
        
        
        /* Transaction cost labels */
        rect = CGRectMake(30.0, 270 + (140.0 * i), 100.0, 20.0);
        costTitleLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [costTitleLabels[i] setFont: [costTitleLabels[i].font fontWithSize:12]];
        costTitleLabels[i].text = @"Cost";
        [self.view addSubview:costTitleLabels[i]];
        
        rect = CGRectMake(130.0, 270 + (140.0 * i), 100.0, 20.0);
        costLabels[i] = [[UILabel alloc] initWithFrame:rect];
        [costLabels[i] setFont: [costLabels[i].font fontWithSize:12]];
        [self.view addSubview:costLabels[i]];
        
        
        /* Transaction edit button */
        rect = CGRectMake(300.0, 270 + (140.0 * i), 25.0, 20.0);
        editButtons[i] = [[UIButton alloc] initWithFrame:rect];
        [editButtons[i] addTarget:self action:@selector(editButtonsClicked:)
                            forControlEvents:UIControlEventTouchUpInside];
        editButtons[i].titleLabel.font = [editButtons[i].titleLabel.font
                                             fontWithSize:12];
        [editButtons[i] setTitle:@"Edit" forState:UIControlStateNormal];
        editButtons[i].contentHorizontalAlignment
                           = UIControlContentHorizontalAlignmentRight;
        [editButtons[i] setTitleColor:[UIColor blueColor]
                            forState:UIControlStateNormal];
        [editButtons[i] setTitleColor:[UIColor grayColor]
                            forState:UIControlStateHighlighted];
        [self.view addSubview:editButtons[i]];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    int numTransactions;
    int currentIdx;
    int i;
    
    numTransactions = [dm getNumTransactions];
    totalTransactionsLabel.text = [[NSString alloc]
                                      initWithFormat:@"%d", numTransactions];

    currentIdx = numTransactions - 1;
    for (i = 0; i < 3; i++) {
        if (currentIdx >= 0) {
            ts[i] = [dm getTransactionAtIndex:currentIdx];
            numTransactionLabels[i].text = [[NSString alloc]
                                       initWithFormat:@"%05d", currentIdx + 1];
            catLabels[i].text = ts[i].category;
            descLabels[i].text = ts[i].desc;
            costLabels[i].text = [NSString stringWithFormat:@"$%d.%02d",
                                     (int)ts[i].costDollars,
                                     (int)ts[i].costCents];
            dateLabels[i].text = [NSDateFormatter
                                     localizedStringFromDate:ts[i].date
                                     dateStyle:NSDateFormatterShortStyle
                                     timeStyle:NSDateFormatterShortStyle];
        }
        else {
            ts[i] = nil;
            numTransactionLabels[i].text = @"-";
            catLabels[i].text = @"-";
            descLabels[i].text = @"-";
            costLabels[i].text = @"0.00";
            dateLabels[i].text = @"-";
        }
        
        currentIdx--;
    }
}


- (void)editButtonsClicked:(id)sender {
    int buttonIdx;
    UIButton *b;
    
    b = (UIButton *)sender;
    buttonIdx = -1;
    
    if (b == editButtons[0])
        buttonIdx = 0;
    else if (b == editButtons[1])
        buttonIdx = 1;
    else if (b == editButtons[2])
        buttonIdx = 2;
    
    if (buttonIdx >= 0) {
        vcn = [[ViewControllerNew alloc] initWithDataManager:dm
                                             transaction:ts[buttonIdx]];
        [self presentViewController:vcn animated:NO completion:nil];
    }
}


- (void)backButtonClicked {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
