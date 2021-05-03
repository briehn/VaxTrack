//
//  DatabaseConnection.swift
//  Capstone Project iOS
//
//  Created by Patrick on 4/29/21.
//

import Foundation

//protocol DatabaseConnectionProtocol: NSObjectProtocol {
//    func dataDownloaded(type: String, obj: NSObject?)
//}

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let semaphore = DispatchSemaphore(value: 0)

        let dataTask = self.dataTask(with: url) {
            data = $0
            response = $1
            error = $2

            semaphore.signal()
        }
        dataTask.resume()

        _ = semaphore.wait(timeout: .distantFuture)

        return (data, response, error)
    }
}

class DatabaseConnection: NSObject, URLSessionDataDelegate {
    
    //properties
    
    //weak var delegate: DatabaseConnectionProtocol!
    
    static let urlPath = "http://hftsoft.hopto.org:8341/api.php"

    static func fetchData(_ type:String, _ data:NSDictionary?) -> (NSObject?, MyError) {
        var theUrl = urlPath + "?type=\(type)"
        // add parameters from data for each type to the url. will be given in excel
        switch type {
        case "login":
            theUrl += "&login=\(data?["login"] ?? "")&password=\(data?["password"] ?? "")"
        case "u_reg":
            theUrl += "&firstname=\(data?["firstname"] ?? "")&lastname=\(data?["lastname"] ?? "")&birthdate=\(data?["birthdate"] ?? "")"
        case "p_reg":
            theUrl += "&firstname=\(data?["firstname"] ?? "")&lastname=\(data?["lastname"] ?? "")&org=\(data?["org"] ?? "")&address=\(data?["address"] ?? "")&phone=\(data?["phone"] ?? "")&email=\(data?["email"] ?? "")&website=\(data?["website"] ?? "")&office=\(data?["office"] ?? "")&officehour=\(data?["officehour"] ?? "")"
        case "a_reg":
            theUrl += "&firstname=\(data?["firstname"] ?? "")&lastname=\(data?["lastname"] ?? "")"
        case "u_query":
            theUrl += "&firstname=\(data?["firstname"] ?? "")"
        case "p_query":
            theUrl += "&firstname=\(data?["firstname"] ?? "")"
        case "u_newlogin":
            theUrl += "&login=\(data?["login"] ?? "")&password=\(data?["password"] ?? "")&targetid=\(data?["targetid"] ?? "")"
        case "p_newlogin":
            theUrl += "&login=\(data?["login"] ?? "")&password=\(data?["password"] ?? "")&targetid=\(data?["targetid"] ?? "")"
        case "u_profile":
            theUrl += "&uid=\(data?["uid"] ?? "")"
        case "p_profile":
            theUrl += "&pid=\(data?["pid"] ?? "")"
        case "a_profile":
            theUrl += "&aid=\(data?["aid"] ?? "")"
        case "p_storecoord":
            theUrl += "&pid=\(data?["pid"] ?? "")&lat=\(data?["lat"] ?? "")&lng=\(data?["lng"] ?? "")"
        default:
            print("invalid type");
        }

        let url: URL = URL(string: theUrl)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        // here we use synchronous fetch
        var outdata: Data?
        var response: URLResponse?
        var error: Error?
        var obj: NSObject?
        var myerr: MyError = MyError(0)
        (outdata, response, error) = defaultSession.synchronousDataTask(with: url)
        if error != nil {
            print("Failed to fetch data")
            myerr.code = -1
            myerr.msg = "failed to fetch data"
        } else {
            print("Data fetched")
            //print(outdata!)
            (obj, myerr) = self.parseJSON(type, outdata!)
        }
        return (obj, myerr)
    }
    
    static func parseJSON(_ type:String, _ data:Data) -> (NSObject?, MyError) {
        
        var jsonResult = NSDictionary()
           
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
        } catch let error as NSError {
            print(error)
        }
        
        print(jsonResult)
        var arr:NSArray? = nil
        var obj:NSObject? = nil
        let error = MyError(0)

        if let code = jsonResult["code"] as? Int {
            if code < 0 {
                print("api failed")
                error.code = code
                error.msg = jsonResult["msg"] as? String
            } else {
                if let datas = jsonResult["data"] as? NSArray {
                    switch type {
                    case "login":
                        obj = JSONParser.parseLogin(datas);
                    case "u_reg":
                        break
                    case "u_newlogin":
                        break
                    case "p_reg":
                        break
                    case "p_newlogin":
                        break
                    case "a_reg":
                        break
                    case "u_query":
                        fallthrough
                    case "u_profile":
                        arr = JSONParser.parsePatients(datas) as NSArray?;
                        obj = (arr != nil) && arr!.count > 0 ? arr![0] as? NSObject : nil
                    case "p_query":
                        fallthrough
                    case "p_profile":
                        arr = JSONParser.parseProviders(datas) as NSArray?;
                        obj = (arr != nil) && arr!.count > 0 ? arr![0] as? NSObject : nil
                    case "a_profile":
                        arr = JSONParser.parseAdmins(datas) as NSArray?;
                        obj = (arr != nil) && arr!.count > 0 ? arr![0] as? NSObject : nil
                    case "p_storecoord":
                        break
                    default:
                        print("invalid type");
                    }
                }
            }
        }

        //DispatchQueue.main.async(execute: { () -> Void in
        //    self.delegate.dataDownloaded(type: type, obj: obj)
        //})
        return (obj, error)
    }

}
