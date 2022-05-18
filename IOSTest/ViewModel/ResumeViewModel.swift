//
//  AddResumeViewModel.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 30/04/22.
//

import Foundation

protocol ResumeViewModel {
  var personalDetail: PersonalDetail { get }
  var pagePosition : Observable<Int> { get }
  var submitResponse : Observable<SaveStatus> { get }
  var isSubmitOnProgress: Observable<Bool> { get }
  func getListPersonalDetail() -> [PersonalDetail]
  func getPersonalDetailById(byId id: String) -> PersonalDetail?
  func setPersonalDetail(personalDetail: PersonalDetail?)
  
  func addPersonalInfo(name: String, imagePath: String, mobileNumber: String, email: String, residenceAddress: String, careerObjective: String, yearsOfExperience: String)
  
  func addSkill(skillName: String)
  func removeSkill(skillName: String)
  
  func addWorkSummary(companyName: String, workDuration: String) -> WorkSummary
  func removeWorkSummary(workSummary: WorkSummary)
  
  func addEducation(schoolName: String, educationClass: String, passingYear: String, cgpa: String) -> EducationDetail
  func removeEducation(education: EducationDetail)
  
  func addProject(projectName: String, teamSize: String, projectSummary: String, technologyUsed: String, role: String) -> ProjectDetail
  func removeProject(project: ProjectDetail)
  
  
  func submitData()
  func goNextPage()
  func goBack()
}
