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

    static func fetchData(_ type:String, _ data:[String:String]?) -> (NSObject?, MyError) {
        let baseUrl = urlPath + "?type=\(type)"
        var querystring: String = ""
        if data != nil {
            for (key,value) in data! {
                querystring +=  "\(key)=\(value)&"
            }
            querystring = String(querystring.dropLast())
        }
        let finalUrl = baseUrl + "&" + querystring
        print(finalUrl)

        let url = URL(string: finalUrl)
        if url == nil {
            print("URL is null")
            return (nil, MyError(-2))
        }
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        // here we use synchronous fetch
        var outdata: Data?
        var response: URLResponse?
        var error: Error?
        var obj: NSObject?
        var myerr: MyError = MyError(0)
        (outdata, response, error) = defaultSession.synchronousDataTask(with: url!)
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
                error.msg = jsonResult["msg"] as? String ?? ""
            } else {
                if let datas = jsonResult["data"] as? NSArray {
                    switch type {
                    
                    // user accounts
                    case "u_query":
                        fallthrough
                    case "p_query":
                        fallthrough
                    case "login":
                        obj = JSONParser.parseLogin(datas)
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
                    case "u_profile":
                        arr = JSONParser.parsePatients(datas) as NSArray?
                        obj = (arr != nil) && arr!.count > 0 ? arr![0] as? NSObject : nil
                    case "p_profile":
                        arr = JSONParser.parseProviders(datas) as NSArray?
                        obj = (arr != nil) && arr!.count > 0 ? arr![0] as? NSObject : nil
                    case "a_profile":
                        arr = JSONParser.parseAdmins(datas) as NSArray?
                        obj = (arr != nil) && arr!.count > 0 ? arr![0] as? NSObject : nil
                    case "p_storecoord":
                        break
                    
                    // providers
                    case "p_list":
                        fallthrough
                    case "p_listfilter":
                        obj = JSONParser.parseProviders(datas) as NSArray?

                    // vaccines
                    case "v_list":
                        obj = JSONParser.parseVaccines(datas) as NSArray?
                    case "pv_list":
                        obj = JSONParser.parseVaccines(datas) as NSArray?
                    case "v_add":
                        break
                    case "v_edit":
                        break
                    case "v_dec":
                        break

                    // tests
                    case "t_list":
                        obj = JSONParser.parseTests(datas) as NSArray?
                    case "pt_list":
                        obj = JSONParser.parseTests(datas) as NSArray?
                    case "t_add":
                        break
                    case "t_edit":
                        break

                    // appointments
                    case "uo_list":
                        obj = JSONParser.parseAppointments(datas) as NSArray?
                    case "po_list":
                        obj = JSONParser.parseAppointments(datas) as NSArray?
                    case "o_new":
                        break
                    case "o_cancel":
                        break
                    case "o_approve":
                        break
                    case "o_done":
                        break

                    // records
                    case "uv_list":
                        obj = JSONParser.parseRecords(datas) as NSArray?
                    case "puv_list":
                        obj = JSONParser.parseRecords(datas) as NSArray?
                    case "uv_detail":
                        arr = JSONParser.parseRecords(datas) as NSArray?
                        obj = (arr != nil) && arr!.count > 0 ? arr![0] as? NSObject : nil
                    case "uv_done":
                        break

                    // test results
                    case "ut_list":
                        obj = JSONParser.parseTestResults(datas) as NSArray?
                    case "put_list":
                        obj = JSONParser.parseTestResults(datas) as NSArray?
                    case "ut_detail":
                        arr = JSONParser.parseTestResults(datas) as NSArray?
                        obj = (arr != nil) && arr!.count > 0 ? arr![0] as? NSObject : nil
                    case "ut_done":
                        break

                    // misc
                    case "notification":
                        obj = JSONParser.parseNotifications(datas) as NSArray?

                    default:
                        print("invalid type")
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
