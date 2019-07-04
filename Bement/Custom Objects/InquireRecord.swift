//
//  InquireRecord.swift
//  Bement
//
//  Created by Runkai Zhang on 6/26/19.
//  Copyright © 2019 Runkai Zhang. All rights reserved.
//

import Foundation
import UIKit

class InquireRecord {
    
    var content: String
    
    init(Students: [StudentRecord], Household: HouseholdRecord, Parents: [ParentRecord], Additional: AdditionalRecord) {
        if Students.count == 1 {
            if Parents.count == 1 {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            } else {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                Parents/Guardian 2
                \(Parents[1].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            }
        } else if Students.count == 2 {
            if Parents.count == 1 {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                Student 2:
                \(Students[1].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            } else {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                Student 2:
                \(Students[1].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                Parents/Guardian 2
                \(Parents[1].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            }
        } else if Students.count == 3 {
            if Parents.count == 1 {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                Student 2:
                \(Students[1].content)
                Student 3:
                \(Students[2].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            } else {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                Student 2:
                \(Students[1].content)
                Student 3:
                \(Students[2].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                Parents/Guardian 2
                \(Parents[1].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            }
        } else if Students.count == 4 {
            if Parents.count == 1 {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                Student 2:
                \(Students[1].content)
                Student 3:
                \(Students[2].content)
                Student 4:
                \(Students[3].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            } else {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                Student 2:
                \(Students[1].content)
                Student 3:
                \(Students[2].content)
                Student 4:
                \(Students[3].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                Parents/Guardian 2
                \(Parents[1].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            }
        } else {
            if Parents.count == 1 {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                Student 2:
                \(Students[1].content)
                Student 3:
                \(Students[2].content)
                Student 4:
                \(Students[3].content)
                Student 5:
                \(Students[4].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            } else {
                self.content = """
                Student Information
                Student 1:
                \(Students[0].content)
                Student 2:
                \(Students[1].content)
                Student 3:
                \(Students[2].content)
                Student 4:
                \(Students[3].content)
                Student 5:
                \(Students[4].content)
                -------------------------
                Household Information
                \(Household.content)
                -------------------------
                Parents/Guardian 1
                \(Parents[0].content)
                Parents/Guardian 2
                \(Parents[1].content)
                -------------------------
                Additional Information
                \(Additional.content)
                """
            }
        }
    }
}

class StudentRecord {
    var first_name: String
    var last_name: String
    var gender: String
    var date_of_birth: Date
    var current_school_name: String
    var grade_applying_for: String
    var year_applying_for: String
    var boarder_or_day: String
    
    var content: String
    
    init(firstname: String, lastname: String, gender: String, birthday: Date, currentschoolname: String?, currentgrade: String, gradeapplyingfor: String, yearapplyingfor: String, boarderorday: String, id: Int) {
        self.first_name = firstname
        self.last_name = lastname
        self.gender = gender
        self.date_of_birth = birthday
        self.current_school_name = currentschoolname ?? ""
        self.grade_applying_for = gradeapplyingfor
        self.year_applying_for = yearapplyingfor
        self.boarder_or_day = boarderorday
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateFormat = "MM/dd/yyyy"
        
        let birthDate = formatter.string(from: birthday)
        
        self.content = """
        First Name: \(firstname)
        Last Name: \(lastname)
        Gender: \(gender)
        Date of Birth: \(birthDate)
        Current School Name: \(currentschoolname ?? "Not applicable")
        Grade Applying for: \(gradeapplyingfor)
        Year Applying for: \(yearapplyingfor)
        Boarder/Day: \(boarderorday)
        """
    }
}

class HouseholdRecord {
    var mailing_address_1: String
    var mailing_address_2: String
    var city: String
    var state: String
    var postal_code: String
    var country: String
    var home_phone: String
    
    var content: String
    
    init(mailing_1: String, mailing_2: String?, city: String, state: String, postal: String, country: String, phone: String) {
        self.mailing_address_1 = mailing_1
        self.mailing_address_2 = mailing_2 ?? ""
        self.city = city
        self.state = state
        self.postal_code = postal
        self.country = country
        self.home_phone = phone
        
        self.content = """
        Mailing Address:
        \(mailing_1)
        \(mailing_2 ?? "")
        City: \(city)
        State: \(state)
        Postal Code: \(postal)
        Country: \(country)
        Home Phone: \(phone)
        """
    }
}

class ParentRecord {
    var relation_to_student: String
    var title: String
    var first_name: String
    var last_name: String
    var cell_phone: String
    var email: String
    
    var content: String
    
    init(relation: String, title: String, firstname: String, lastname: String, phone: String, email: String) {
        self.relation_to_student = relation
        self.title = title
        self.first_name = firstname
        self.last_name = lastname
        self.cell_phone = phone
        self.email = email
        
        self.content = """
        Relation to Student: \(relation)
        Title: \(title)
        First Name: \(firstname)
        Last Name: \(lastname)
        Cell Phone: \(phone)
        Email: \(email)
        """
    }
}

class AdditionalRecord {
    var person_inquiring: String
    var if_other: String
    var how_did_you_hear_about_bement: String
    var detail: String
    var financial_aid_info: String
    var additional_comments: String
    
    var content: String
    
    init(personinquiring: String?, ifother: String?, howdidhear: String, detail: String?, financial: String?, additional: String?) {
        self.person_inquiring = personinquiring ?? "Not applicable"
        self.if_other = ifother ?? "Not applicable"
        self.how_did_you_hear_about_bement = howdidhear
        self.detail = detail ?? "Not applicable"
        self.financial_aid_info = financial ?? "Not applicable"
        self.additional_comments = additional ?? "Not applicable"
        
        self.content = """
        Person inquiring: \(personinquiring ?? "Not applicable")
        If other, please specify: \(ifother ?? "Not applicable")
        How did I hear about Bement: \(howdidhear)
        Details: \(detail ?? "Not applicable")
        Receive information about applying for financial aid: \(financial ?? "Not applicable")
        Additional comments or share athletic and/or extracurricular interests: \(additional ?? "Not applicable")
        """
    }
}
