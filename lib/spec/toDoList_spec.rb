require_relative '../toDoList.rb'

RSpec.describe "TDD over toDoList" do

  before :each do
    @task = Task.new("Walk the dog")
  end 


  describe "Task class" do

    it "returns id = 1 from the first task" do
      expect(@task.id).to eq(1) 
    end

    it "returns id = 2 from the first task" do
      expect(@task.id).to eq(2) 
    end

    it "returns that the task is not complete for a new task" do
      expect(@task.complete?).to be_falsy
    end

    #Hay que comprobar que el método funciona no si existe...
    it "set complete to true when the task is complete" do
      @task.complete!
      expect(@task.complete?).to be_truthy
    end

    it "set complete to false if the task is not complete" do
      @task.make_incomplete!
      expect(@task.complete?).to be_falsy
    end    

    it "returns when the task was created" do
      expect(@task.created_at.strftime('%H %M %S')).to eq(Time.now.strftime('%H %M %S'))
    end   

    it "check if content has changed" do
      @task.update_content! "Update content!"
      expect(@task.content).to eq("Update content!")
    end 

    it "check if updated_content! update time of task" do
      @task.update_content! "Update content!"
      expect(@task.updated_at.strftime('%H %M %S')).to eq(Time.now.strftime('%H %M %S'))
    end 

  end

  describe "TodoList" do

    before :each do
      @todolist = TodoList.new "Maca"
      @task1 = Task.new("Buy milk!")
      @task2 = Task.new("Walk the dog")
    end
    
    it "check if todoList creates array of tasks" do
      expect(@todolist.tasks).to eq([])
    end

    it "check if a new task is added to todolits" do
      @todolist.add_task(Task.new "Buy milk!")
      expect(@todolist.tasks.size).not_to eq(0)
    end

    it "check if a new task is deleted in tasks array" do
      @todolist.delete_task(1)
      expect(@todolist.tasks.size).to eq(0)
    end

    it "check if a new task is deleted in todolits" do
      @todolist.add_task(@task1)
      @todolist.delete_task(@task1.id)
      expect(@todolist.tasks.size).to eq(0)
    end

    it "check if todolist find a task that doesn't exits" do
      @todolist.add_task(@task1)
      @todolist.add_task(@task2)
      expect( @todolist.find_task_by_id(1)).to eq(nil)
    end

    it "check if todolist have found a specific task" do
      @todolist.add_task(@task1)
      @todolist.add_task(@task2)
      expect( @todolist.find_task_by_id(@task2.id).content).to eq("Walk the dog")
    end  

    it "check if todolist have found a specific task" do
      @todolist.add_task(@task1)
      @todolist.add_task(@task2)
      expect( @todolist.find_task_by_id(@task2.id).content).to eq("Walk the dog")
    end

    it "check if tasks are ordered by created_at" do
      @todolist.add_task(@task1)
      @todolist.add_task(@task2)
      expect(@todolist.sort_by_created('desc')[0].id).to eq(@task2.id)
    end    

  end







end