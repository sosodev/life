import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["taskList", "parentTask"]

  connect() {
    this.updateParentTasks()
  }

  updateParentTasks() {
    const taskListId = this.taskListTarget.value
    
    if (!taskListId) {
      this.clearParentTasks()
      return
    }

    // Store the currently selected parent task ID
    const currentParentId = this.parentTaskTarget.value

    fetch(`/tasks/parent_tasks?task_list_id=${taskListId}`)
      .then(response => response.json())
      .then(data => {
        this.populateParentTasks(data, currentParentId)
      })
      .catch(error => {
        console.error('Error fetching parent tasks:', error)
        this.clearParentTasks()
      })
  }

  populateParentTasks(tasks, selectedParentId = null) {
    // Clear existing options except the prompt
    this.parentTaskTarget.innerHTML = '<option value="">No parent task</option>'
    
    // Add new options
    tasks.forEach(task => {
      const option = document.createElement('option')
      option.value = task.id
      option.textContent = task.name
      
      // Restore the previously selected parent task if it exists in the new list
      if (selectedParentId && task.id.toString() === selectedParentId) {
        option.selected = true
      }
      
      this.parentTaskTarget.appendChild(option)
    })
  }

  clearParentTasks() {
    this.parentTaskTarget.innerHTML = '<option value="">No parent task</option>'
  }
}
