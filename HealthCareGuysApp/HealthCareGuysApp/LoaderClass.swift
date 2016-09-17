//
//  LoaderClass.swift
//  HealthCareGuysApp
//
//  Created by Thaneerath on 09/09/16.
//  Copyright © 2016 citrusinformatics. All rights reserved.
//

import Foundation
import CoreData
class HeadLines : NSManagedObject {
    //var headline: NSString = NSString()
   // var newsDetails : NSString = NSString()
   // var comment: NSString = NSString()
   // var commentedDate: NSString = NSString()
  //  var id:Int = Int()
    var headline = NSString()
     
    var newsDetail = NSString()

       

    var commentTime =  NSString()
    
    
    var category =  NSString()
    
    
    var imageUrl = NSString()
    
    var id = NSInteger()
   
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    


    
}

class LoaderClass:ViewController,NSURLSessionDelegate {
    var data:NSURLResponse!
    var newsToSave = [NSManagedObject]()
    let urlString :String = "https://read.netspective.com/api/index.php"
    var list : Array<HeadLines> = []
    var id = NSMutableArray()
    var headLine = NSMutableArray()
    var commentTime = NSMutableArray()
    var category = NSMutableArray()
    var dictionary = NSMutableDictionary()
    var firstData = NSMutableArray()
    var content = NSMutableArray()
    var userDefaults = NSUserDefaults()
    var newsDetails = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        userDefaults = NSUserDefaults.standardUserDefaults()
        
    }
    
    
    func login_request() {
        let url:NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        let params:[String: AnyObject] = ["op" : "login",
                                          "user" : "thaneerath.th@citrusinformatics.com",
                                          "password" : "qwerty123?" ]
        
        do{
            let request = NSMutableURLRequest(URL: url)
            
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            //"op":"login","user":"you","password":"xxx"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPMethod = "POST"
            var err: NSError?
            try
                request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
            
            let task = session.dataTaskWithRequest(request) {
                (
                let data, let response, let error) in
                
                guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                    print("error")
                    return
                }
                
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(dataString)
                
                
            }
            
            task.resume()
            
        }catch{
            
        }
    }
    
    
    func getHeadlines_request() {
        let url:NSURL = NSURL(string: urlString)!
        let session = NSURLSession.sharedSession()
        let params:[String: AnyObject] = ["op" : "getHeadlines","sid" : "hf5b27ugb2bgl1qg0gekio2i51",
                                          "feed_id" : "-4",
                                          "limit" : "100" ,"skip" : "0", "view_mode" : "all_articles" , "is_cat" : "1","include_attachments" : "1", "show_content" : "1"]
        
        do{
            let request = NSMutableURLRequest(URL: url)
            
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            //"op":"login","user":"you","password":"xxx"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.HTTPMethod = "POST"
            var err: NSError?
            try
                request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions())
            
            let task = session.dataTaskWithRequest(request) {
                (
                let data, let response, let error) in
                
                guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                    print("error\(error)")
                    return
                }
                
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(dataString)
                
                let dataR = dataString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(dataR, options: []) as! [String: AnyObject]
                   self.parse(json)
                self.saveName()
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            }
            
            task.resume()
            
        }catch{
            
        }
    }
    
    
    func parse(anyObj:AnyObject) -> Array<HeadLines> {
        var list:Array<HeadLines> = []
      //  print("full content iss\(anyObj["content"])")
        if  anyObj["content"] is Array<AnyObject> {
            
           
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            let b = NSEntityDescription.insertNewObjectForEntityForName("News", inManagedObjectContext: managedContext) as! HeadLines
            for json in anyObj["content"] as! [[String:AnyObject]] {
              
                b.id = (json["id"] as AnyObject? as? Int) ?? 0
               
                b.headline = (json["title"] as AnyObject? as? String) ?? ""
                b.newsDetail  =  (json["content"]  as AnyObject? as? String) ?? ""
                b.commentTime  =  (json["tags"]![0]  as AnyObject? as? String) ?? ""
                list.append(b)
                id.addObject(b.id)
               headLine.addObject(b.headline)
                commentTime.addObject(b.commentTime)
                newsDetails.addObject(b.newsDetail)
            
            }// for
            
        } // if
       
        userDefaults.setObject(headLine, forKey:"headlineArray")
        userDefaults.setObject(id, forKey:"idArray")
        userDefaults.setObject(newsDetails, forKey: "newsContent")
         userDefaults.setObject(commentTime, forKey: "category")
        userDefaults.synchronize()
      var newArr = userDefaults.objectForKey("category") as! NSMutableArray
        
       print("array\(newArr)")
        
     return list
       
    }
    
    
    func saveName() {
        //1
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("News",
                                                        inManagedObjectContext:managedContext)
        
        
        let countOf = id.count
        print("count iss \(countOf)")
        for i in 0...countOf - 1 {
            
            let news = NSManagedObject(entity: entity!,
                                       insertIntoManagedObjectContext: managedContext)
                       //3
            print("i value\(i)")
            //print("object at index\(newsDetails.objectAtIndex(i))")
            news.setValue(headLine.objectAtIndex(i), forKey: "headLine")
            

           news.setValue(newsDetails.objectAtIndex(i), forKey: "newsDetails")
            news.setValue(commentTime.objectAtIndex(i), forKey: "commentTime")
            

            // news.setValue(list.commentedDate, forKey: "commentedTime")
            news.setValue(id.objectAtIndex(i), forKey: "id")
            //print("news data\(news)")
                           //4
            do {
                try managedContext.save()
                //5
                self.newsToSave.insert(news, atIndex: i)
                print("helloo -----\(i)")
                
                } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        }
              //  print("helloo\(self.newsToSave)")
       // getData()
        
    }
    
    
    func getData() -> NSMutableArray{
        
        let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        
        
        let entityDescription = NSEntityDescription.entityForName("News", inManagedObjectContext: managedContext)
        fetchRequest.entity = entityDescription
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest) as! [HeadLines]
            for item in result{
               // dictionary.setValue("id", forKey: item.id as NSString as String as String)
                dictionary.setValue("headLine", forKey: item.headline as String)
                dictionary.setValue("commentTime", forKey: item.commentTime as String)
                dictionary.setValue("newsDetails", forKey: item.newsDetail as String)
            }
          //  print("reult is real\(result)")
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
     /*   print("entities array\(entities)")
            for item in entities{
                for key in item.entity.attributesByName.keys{
                    let value: AnyObject? = item.valueForKey(key)
                    print("keys\(key) = \(value)")
                    dictionary.setValue(value,forKey :key)
                   
                }
               //  print("list items\(list)")
                
            }
            
         
            
      
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }*/
      //  headLine = userDefaults.objectForKey("headlineArray") as! NSMutableArray
        
         print("list items outside\(self.headLine)")
        return self.headLine
    }
    
    }