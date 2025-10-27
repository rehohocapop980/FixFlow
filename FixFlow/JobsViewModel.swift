
import Foundation
import SwiftUI

@MainActor
class JobsViewModel: ObservableObject {
    @Published var jobs: [Job] = []
    @Published var searchText: String = ""
    @Published var selectedStatus: JobStatus? = nil
    
    private let jobsKey = "SavedJobs"
    
    init() {
        loadJobs()
    }
    
    var filteredJobs: [Job] {
        var filtered = jobs
        
        if let selectedStatus = selectedStatus {
            filtered = filtered.filter { $0.status == selectedStatus }
        }
        
        if !searchText.isEmpty {
            filtered = filtered.filter { job in
                job.clientName.localizedCaseInsensitiveContains(searchText) ||
                job.carModel.localizedCaseInsensitiveContains(searchText) ||
                job.service.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filtered.sorted { $0.dueDate < $1.dueDate }
    }
    
    func addJob(_ job: Job) {
        jobs.append(job)
        saveJobs()
    }
    
    func updateJob(_ job: Job) {
        if let index = jobs.firstIndex(where: { $0.id == job.id }) {
            jobs[index] = job
            saveJobs()
        }
    }
    
    func deleteJob(_ job: Job) {
        jobs.removeAll { $0.id == job.id }
        saveJobs()
    }
    
    func changeJobStatus(_ job: Job, to newStatus: JobStatus) {
        if let index = jobs.firstIndex(where: { $0.id == job.id }) {
            jobs[index].status = newStatus
            saveJobs()
        }
    }
    
    func resetFilters() {
        searchText = ""
        selectedStatus = nil
    }
    
    private func saveJobs() {
        do {
            let data = try JSONEncoder().encode(jobs)
            UserDefaults.standard.set(data, forKey: jobsKey)
        } catch {
            print("Failed to save jobs: \(error)")
        }
    }
    
    private func loadJobs() {
        guard let data = UserDefaults.standard.data(forKey: jobsKey) else {
            return
        }
        
        do {
            jobs = try JSONDecoder().decode([Job].self, from: data)
        } catch {
            print("Failed to load jobs: \(error)")
            jobs = []
        }
    }
}
