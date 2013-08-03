//
//  WTTableViewController.h
//  Weather
//
//  Created by Scott on 26/01/2013.
//  Copyright (c) 2013 Scott Sherwood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTWeatherHTTPClient.h"

@interface WTTableViewController : UITableViewController<NSXMLParserDelegate,UIActionSheetDelegate,WeatherHttpClientDelegate,CLLocationManagerDelegate>

- (IBAction)clear:(id)sender;

- (IBAction)jsonTapped:(id)sender;
- (IBAction)plistTapped:(id)sender;
- (IBAction)xmlTapped:(id)sender;
- (IBAction)httpClientTapped:(id)sender;
- (IBAction)apiTapped:(id)sender;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
- (void)parserDidEndDocument:(NSXMLParser *)parser;

@property(strong) NSMutableDictionary *xmlWeather;
@property(strong) NSMutableDictionary *currentDictionary;
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property(strong) NSMutableString *outstring;

@property(strong) CLLocationManager *manager;

@end
