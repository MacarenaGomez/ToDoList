require 'rspec'
require 'pry'

class TodoList

  attr_reader :tasks, :user

  def initialize user
    @todo_store = YAML::Store.new("./public/tasks.yml")
    @tasks = []
    @user = user
  end

  def load_tasks
    @tasks
  end

  def add_task task
    @tasks << task
  end

  def delete_task task_id
    @tasks.delete_if { | task | task.id == task_id }
  end

  def find_task_by_id id
    @tasks.find { |task| task.id == id }
  end

  def sort_by_created mode
    sorted = @tasks.sort{ | task1, task2 | task1.created_at <=> task2.created_at }
    sorted.reverse! if mode == "desc"
    sorted
  end

  def save
    @todo_store.transaction do 
      @todo_store[@user] = @tasks
    end
    binding.pry
  end

end
