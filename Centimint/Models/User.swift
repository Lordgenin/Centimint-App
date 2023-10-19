import Foundation

struct User {
    var id: String
    var email: String
    var birthdate: Date
    var profileImageURL: String
    var monthlyinPerMonth: Double = 0.0
    var billExpenes: Double = 0.0
    var savingGoal: Double = 0.0
    var goalDate: Date
    var weeklyAllowance: Double = 0.0
    var subscriptionType: SubscriptionType
    var createdAt: Date
    var updatedAt: Date
    var purchaseEntries: [PurchaseEntry]

    init(id: String,
         email: String,
         birthdate: Date,
         
         monthlyinPerMonth: Double,
         billExpenes: Double,
         savingGoal: Double,
         goalDate: Date,
         weeklyAllowance: Double,
         
         profileImageURL: String?,
         subscriptionType: SubscriptionType,
         createdAt: Date,
         updatedAt: Date,
         dictionary: [String: Any]) {
        self.id = id
        self.email = email
        self.birthdate = birthdate
        self.profileImageURL = profileImageURL ?? ""
        self.subscriptionType = subscriptionType
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.monthlyinPerMonth = monthlyinPerMonth
        self.billExpenes = billExpenes
        self.savingGoal = savingGoal
        self.goalDate = goalDate
        self.weeklyAllowance = weeklyAllowance
        if let purchaseEntryDictionaries = dictionary["purchaseEntries"] as? [[String: Any]] {
                  self.purchaseEntries = purchaseEntryDictionaries.map { PurchaseEntry(dictionary: $0) }
              } else {
                  self.purchaseEntries = []
              }
       
    }

    init?(id: String, dictionary: [String: Any]) {
        self.id = id
        self.email = dictionary["email"] as? String ?? ""
        let birthdateStamp = dictionary["createdAt"] as? Double ?? 0
        
        self.birthdate = Date(timeIntervalSince1970: birthdateStamp)

        self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
        
        self.monthlyinPerMonth = dictionary["monthlyinPerMonth"] as? Double ?? 0
        self.billExpenes = dictionary["billExpenes"] as? Double ?? 0
        self.savingGoal = dictionary["savingGoal"] as? Double ?? 0
        
        let goalDateTimeStamp = dictionary["goalDate"] as? Double ?? 0
        self.goalDate = Date(timeIntervalSince1970: goalDateTimeStamp)
        
        self.weeklyAllowance = dictionary["weeklyAllowance"] as? Double ?? 0
    
        self.subscriptionType = SubscriptionType(rawValue: dictionary["subscriptionType"] as? String ?? "") ?? .lifetime

        let createdAtTimestamp = dictionary["createdAt"] as? Double ?? 0
        let updatedAtTimestamp = dictionary["updatedAt"] as? Double ?? 0

        self.createdAt = Date(timeIntervalSince1970: createdAtTimestamp)
        self.updatedAt = Date(timeIntervalSince1970: updatedAtTimestamp)
        
        if let purchaseEntryDictionaries = dictionary["purchaseEntries"] as? [[String: Any]] {
                  self.purchaseEntries = purchaseEntryDictionaries.map { PurchaseEntry(dictionary: $0) }
              } else {
                  self.purchaseEntries = []
              }

    }
    
    func updateUserObject() -> User {
        var newUser = self
        newUser.updatedAt = Date()
        UserService.sharedInstance.user = self

        return newUser
    }
    
    struct PurchaseEntry {
        var purchaseName: String
        var purchaseAmount: Double
        var dateCreated: Date
        
        init(dictionary: [String: Any]) {
            self.purchaseName = dictionary["purchaseName"] as? String ?? ""
            self.purchaseAmount = dictionary["purchaseAmount"] as? Double ?? 0.0
            let dateCreatedTimestamp = dictionary["dateCreated"] as? Double ?? 0.0
            self.dateCreated = Date(timeIntervalSince1970: dateCreatedTimestamp)
        }
        
        func toDictionary() -> [String: Any] {
            return [
                "purchaseName": purchaseName,
                "purchaseAmount": purchaseAmount,
                "dateCreated": dateCreated.timeIntervalSince1970
            ]
        }
    }


    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "email": email,
            "birthdate": birthdate.timeIntervalSince1970,
            "profileImageURL": profileImageURL,
            "subscriptionType": subscriptionType.rawValue,
            
            "monthlyinPerMonth": monthlyinPerMonth,
            "billExpenes": billExpenes,
            "savingGoal": savingGoal,
            "goalDate": goalDate,
            "weeklyAllowance": weeklyAllowance,
            
            "createdAt": createdAt.timeIntervalSince1970,
            "updatedAt": updatedAt.timeIntervalSince1970,
            "purchaseEntries": purchaseEntries.map { $0.toDictionary() }
        ]
    }
}
