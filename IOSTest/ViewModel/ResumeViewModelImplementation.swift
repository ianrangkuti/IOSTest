//
//  ResumeViewModelImplementation.swift
//  IOSTest
//
//  Created by Ardiansyah Rangkuti on 18/05/22.
//

import Foundation

final class ResumeViewModelImplementation: ResumeViewModel {
  private var repository: ResumeRepository
  var personalDetail: PersonalDetail
  var pagePosition : Observable<Int>
  var submitResponse: Observable<SaveStatus>
  var isSubmitOnProgress: Observable<Bool>
  
  init(repository: ResumeRepository = ResumeRepositoryImplementation()) {
    self.repository = repository
    self.personalDetail = PersonalDetail()
    self.pagePosition = Observable(0)
    self.submitResponse = Observable(.nothing)
    self.isSubmitOnProgress = Observable(false)
  }
  
  func getListPersonalDetail() -> [PersonalDetail] {
    return self.repository.listAllResume()
  }
  
  func getPersonalDetailById(byId id: String) -> PersonalDetail? {
    return self.repository.findResume(byId: id)
  }
  
  func setPersonalDetail(personalDetail: PersonalDetail?) {
    guard let _personalDetail = personalDetail else {return}
    self.personalDetail = _personalDetail
  }
  
  func addPersonalInfo(name: String, imagePath: String, mobileNumber: String, email: String, residenceAddress: String, careerObjective: String, yearsOfExperience: String) {
    personalDetail.name = name
    personalDetail.picture = imagePath
    personalDetail.mobileNumber = mobileNumber
    personalDetail.email = email
    personalDetail.residenceAddress = residenceAddress
    personalDetail.careerObjective = careerObjective
    personalDetail.yearsOfExperience = yearsOfExperience
  }
  
  func addSkill(skillName: String) {
    personalDetail.skillList.append(skillName)
  }
  
  func removeSkill(skillName: String) {
    if let index = personalDetail.skillList.firstIndex(of: skillName) {
      personalDetail.skillList.remove(at: index)
    }
  }
  
  func addWorkSummary(companyName: String, workDuration: String) -> WorkSummary {
    let workSummary = WorkSummary()
    workSummary.companyName = companyName
    workSummary.workDuration = workDuration
    personalDetail.workSummary.append(workSummary)
    return workSummary
  }
  
  func removeWorkSummary(workSummary: WorkSummary) {
    if let index = personalDetail.workSummary.firstIndex(of: workSummary) {
      personalDetail.workSummary.remove(at: index)
    }
  }
  
  func addEducation(schoolName: String, educationClass: String, passingYear: String, cgpa: String) -> EducationDetail {
    let education = EducationDetail()
    education.schoolName = schoolName
    education.educationClassRaw = educationClass
    education.passingYear = passingYear
    education.cgpa = cgpa
    personalDetail.educationDetails.append(education)
    return education
  }
  
  func removeEducation(education: EducationDetail) {
    if let index = personalDetail.educationDetails.firstIndex(of: education) {
      personalDetail.educationDetails.remove(at: index)
    }
  }
  
  func addProject(projectName: String, teamSize: String, projectSummary: String, technologyUsed: String, role: String) -> ProjectDetail {
    let project = ProjectDetail()
    project.projectName = projectName
    project.teamSize = teamSize
    project.projectSummary = projectSummary
    project.technologyUsed = technologyUsed
    project.role = role
    personalDetail.projectDetails.append(project)
    return project
  }
  
  func removeProject(project: ProjectDetail) {
    if let index = personalDetail.projectDetails.firstIndex(of: project) {
      personalDetail.projectDetails.remove(at: index)
    }
  }
  
  func submitData() {
    self.isSubmitOnProgress.value = true
    self.repository.save(data: self.personalDetail) { [weak self] status in
      self?.isSubmitOnProgress.value = false
      self?.submitResponse.value = status
    }
  }
  
  func goNextPage() {
    pagePosition.value = 1
  }
  
  func goBack() {
    pagePosition.value = -1
  }
}
