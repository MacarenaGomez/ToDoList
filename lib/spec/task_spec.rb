require_relative '../task.rb'

RSpec.describe "TDD over Task" do

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
end