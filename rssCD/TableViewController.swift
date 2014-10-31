

//
//  TableViewController.swift
//  RssCoreData
//
//  Created by Zhihua Yang on 10/29/14.
//  Copyright (c) 2014 Zhihua Yang. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController,NSFetchedResultsControllerDelegate,NSXMLParserDelegate {
    
    var parser = NSXMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var fdescription = NSMutableString()
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        
        element = elementName
        
        if (element as NSString).isEqualToString("item") {
            elements = NSMutableDictionary.alloc()
            elements = [:]
            ftitle = NSMutableString.alloc ()
            ftitle = ""
            link = NSMutableString.alloc()
            link = ""
            fdescription = NSMutableString.alloc()
            fdescription = ""
            
            
        }
        
    }
    
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if(elementName as NSString).isEqualToString("item")
        {
            createTask(ftitle, link: link, desc: fdescription)
            
        }
        
    }

    
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        
        if element.isEqualToString("title"){
            ftitle.appendString(string)
        }else if element.isEqualToString("link"){
            link.appendString(string)
        }else if element.isEqualToString("description"){
            fdescription.appendString(string)
        }
        
    }
    
    
    
    ////////////////////////////////////////////////////////////////////

    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    //var rsslist : rssData? = nil
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "Feeds")
        let sortDescriptor = NSSortDescriptor(key: "desc", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    
    //  override func viewWillAppear(animated: Bool) {
    //     super.viewWillAppear(true)
    //    createTask()
    // }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var url: NSURL = NSURL(string: "http://www.nba.com/rss/david_aldridge.rss")!
        parser = NSXMLParser (contentsOfURL: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = false
        parser.shouldReportNamespacePrefixes = false
        parser.shouldResolveExternalEntities = false
        parser.parse()
        
        
        createTask("zhihuaYang",link: "a",desc: "This is a test, this app is a experiment of CoreData and RssFeed. This app will keep adding data to the database. The editing is disable and the different RssUrl is disable as well.")
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        fetchedResultController.performFetch(nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = fetchedResultController.sections?.count
        return numberOfSections!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let task = fetchedResultController.objectAtIndexPath(indexPath) as Feeds
        cell.textLabel.text = task.title
        return cell
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "detail" {
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let taskController:ViewController = segue.destinationViewController as ViewController
            let task:Feeds = fetchedResultController.objectAtIndexPath(indexPath!) as Feeds
            taskController.task = task
        }
    }

    
    func createTask(title : String, link : String , desc : String) {
        let mymanagedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        let entityDescripition = NSEntityDescription.entityForName("Feeds", inManagedObjectContext: mymanagedObjectContext!)
        
        
        let task = Feeds(entity: entityDescripition!,insertIntoManagedObjectContext: managedObjectContext)
        task.desc = desc
        task.link = link
        task.title = title
        mymanagedObjectContext?.save(nil)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        tableView.reloadData()
    }
    
    
}

