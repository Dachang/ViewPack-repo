//
//  WTTableViewController.m
//  Weather
//
//  Created by Scott on 26/01/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import "WTTableViewController.h"
#import "WeatherAnimationViewController.h"
#import "NSDictionary+weather.h"
#import "NSDictionary+weather_package.h"
#import "AFNetworking.h"

static NSString *const BaseURLString = @"http://www.raywenderlich.com/downloads/weather_sample/";

@interface WTTableViewController ()

@property(strong) NSDictionary *weather;

@end

@implementation WTTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;
    
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"WeatherDetailSegue"]){
        UITableViewCell *cell = (UITableViewCell *)sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        WeatherAnimationViewController *wac = (WeatherAnimationViewController *)segue.destinationViewController;
        
        NSDictionary *w;
        switch (indexPath.section) {
            case 0:{
                w = self.weather.currentCondition;
                break;
            }
            case 1:{
                w = [[self.weather upcomingWeather] objectAtIndex:indexPath.row];
                break;
            }
            default:{
                break;
            }
        }
        
        wac.weatherDictionary = w;
    }
}

#pragma mark Actions

- (IBAction)clear:(id)sender {
    self.title = @"";
    self.weather = nil;
    [self.tableView reloadData];
}

- (IBAction)jsonTapped:(id)sender
{
    NSString *weatherUrl = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    

    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request

            success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                self.weather  = (NSDictionary *)JSON;
                self.title = @"JSON Retrieved";
                [self.tableView reloadData];
            }

            failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                             message:[NSString stringWithFormat:@"%@",error]
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [av show];
            }];
    
    [operation start];
}

- (IBAction)plistTapped:(id)sender
{
    NSString *weatherUrl = [NSString stringWithFormat:@"%@weather.php?format=plist",BaseURLString];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFPropertyListRequestOperation *operation = [AFPropertyListRequestOperation propertyListRequestOperationWithRequest:request
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id propertyList){
        self.weather = (NSDictionary *)propertyList;
        self.title = @"Plist Retrieved";
        [self.tableView reloadData];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id propertyList){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }];
    
    [operation start];
}

- (IBAction)xmlTapped:(id)sender
{
    NSString *weatherUrl = [NSString stringWithFormat:@"%@weather.php?format=xml",BaseURLString];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFXMLRequestOperation *operation = [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser){
        self.xmlWeather = [NSMutableDictionary dictionary];
        XMLParser.delegate = self;
        [XMLParser setShouldProcessNamespaces:YES];
        [XMLParser parse];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser){
        UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Error Retrieving weather" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }];
    
    [operation start];
}

- (IBAction)httpClientTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"AFHTTPClient" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"HTTP POST", @"HTTP GET", nil];
    [actionSheet showFromBarButtonItem:sender animated:YES];
}

- (IBAction)apiTapped:(id)sender
{
    [self.manager startUpdatingLocation];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!self.weather)
        return 0;
    
    switch (section) {
        case 0:{
            return 1;
        }
        case 1:{
            NSArray *upcomingWeather = [self.weather upcomingWeather];
            return [upcomingWeather count];
        }
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WeatherCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *daysWeather;
    
    switch (indexPath.section) {
        case 0:{
            daysWeather = [self.weather currentCondition];
            break;
        }
        case 1:{
            NSArray *upcomingWeather = [self.weather upcomingWeather];
            daysWeather = [upcomingWeather objectAtIndex:indexPath.row];
        }
        default:
            break;
    }
    
    cell.textLabel.text = [daysWeather weatherDescription];
    
    //AFNetworking给UIimageView添加了一个分类，让图片能够异步加载（图片在后台下载的时候，程序的UI界面仍然能够响应）
    __weak UITableViewCell *weakCell = cell;
    [cell.imageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:daysWeather.weatherIconURL]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        weakCell.imageView.image = image;
        [weakCell setNeedsDisplay];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        //add
    }];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
}

#pragma mark - NSXMLParser delegate

//当NSXMLParser发现了新的元素开始标签时，会调用如下方法。在构造一个新字典用来存储赋值给currentDictionary属性之前，首先保存住上一个元素名称。还要将outstring重置一下，这个字符串用来构造XML标签中的数据。

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.previousElementName = self.elementName;
    
    if(qName)
    {
        self.elementName = qName;
    }
    
    if([qName isEqualToString:@"current_condition"])
    {
        self.currentDictionary = [NSMutableDictionary dictionary];
    }
    
    else if([qName isEqualToString:@"weather"])
    {
        self.currentDictionary = [NSMutableDictionary dictionary];
    }
    else if([qName isEqualToString:@"request"])
    {
        self.currentDictionary = [NSMutableDictionary dictionary];
    }
    
    self.outstring = [NSMutableString string];
}

//在NSXMLParser在一个XML标签中发现了字符数据，会调用这个方法。该方法将字符数据追加到outstring属性中，当XML标签结束的时候，这个outstring会被处理

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!self.elementName)
    {
        return;
    }
    
    [self.outstring appendFormat:@"%@",string];
}

//当检测到元素的结束标签时，会调用下面这个方法。在该方法中查找一些标签：
// 1 current_condition 元素表示获得了一个今天的天气。会把今天的天气直接添加到xmlWeather字典中
// 2 weather元素表示获得了随后一天的天气。由于后续的天气有多个，所以将其放入一个数组中
// 3 value标签出现在别的标签中，所以这里可以忽略
// 4 weatherDesc和weatherIconUrl元素的值在存储之前，需要被放入一个数组中，这里的结构时为了与JSON和plist版本天气咨询格式相匹配
// 5 所有其他元素按照原样存储

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([qName isEqualToString:@"current_condition"] || [qName isEqualToString:@"request"])
    {
        [self.xmlWeather setObject:[NSArray arrayWithObject:self.currentDictionary] forKey:qName];
        self.currentDictionary = nil;
    }
    else if ([qName isEqualToString:@"weather"])
    {
        NSMutableArray *array = [self.xmlWeather objectForKey:@"weather"];
        if(!array)
        {
            array = [NSMutableArray array];
        }
        [array addObject:self.currentDictionary];
        [self.xmlWeather setObject:array forKey:@"weather"];
        
        self.currentDictionary = nil;
    }
    
    else if([qName isEqualToString:@"value"])
    {
        //ignore value tags they only appear in the two conditions below
    }
    
    else if([qName isEqualToString:@"weatherDesc"] || [qName isEqualToString:@"weatherIconUrl"])
    {
        [self.currentDictionary setObject:[NSArray arrayWithObject:[NSDictionary dictionaryWithObject:self.outstring forKey:@"value"]] forKey:qName];
    }
    else
    {
        [self.currentDictionary setObject:self.outstring forKey:qName];
    }
    
    self.elementName = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.weather = [NSDictionary dictionaryWithObject:self.xmlWeather forKey:@"data"];
    self.title = @"XML Retrieved";
    [self.tableView reloadData];
}

#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 1
    NSURL *baseURL = [NSURL URLWithString:[NSString stringWithFormat:BaseURLString]];
    NSDictionary *parameters = [NSDictionary dictionaryWithObject:@"json" forKey:@"format"];
    
    // 2
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client setDefaultHeader:@"Accept" value:@"application/json"];
    
    // 3
    if (buttonIndex==0) {
        [client postPath:@"weather.php"
              parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     self.weather = responseObject;
                     self.title = @"HTTP POST";
                     [self.tableView reloadData];
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                  message:[NSString stringWithFormat:@"%@",error]
                                                                 delegate:nil
                                                        cancelButtonTitle:@"OK" otherButtonTitles:nil];
                     [av show];
                     
                 }
         ];
    }
    // 4
    else if (buttonIndex==1) {
        [client getPath:@"weather.php"
             parameters:parameters
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    self.weather = responseObject;
                    self.title = @"HTTP GET";
                    [self.tableView reloadData];
                }
                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                 message:[NSString stringWithFormat:@"%@",error]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av show];
                    
                }
         ];
    }
}

#pragma mark CLLocationManager delegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //if the location is more than 5 minutes old ignore
    if([newLocation.timestamp timeIntervalSinceNow]< 300){
        [self.manager stopUpdatingLocation];
        
        WTWeatherHTTPClient *client = [WTWeatherHTTPClient sharedWeatherHTTPClient];
        client.delegate = self;
        [client updateWeatherAtLocation:newLocation forNumberOfDays:5];
    }
}

#pragma mark - WeatherHTTPClient delegate
- (void)weatherHTTPClient:(WTWeatherHTTPClient *)client didUpdateWithWeather:(id)weather
{
    self.weather = weather;
    self.title = @"API Updated";
    [self.tableView reloadData];
}

- (void)weatherHTTPClient:(WTWeatherHTTPClient *)client didFailWithError:(NSError *)error
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error retrieving Weather" message:[NSString stringWithFormat:@"%@",error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

@end



























