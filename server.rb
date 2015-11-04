require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative "./lib/Task.rb"
require_relative "./lib/TodoList.rb"

todo_list = TodoList.new "Maca"
todo_list.add_task(Task.new("Buy milk!"))
todo_list.add_task(Task.new("Walk the dog"))

#todo_list.load_tasks

enable(:sessions)

get "/tasks" do
  @tasks = todo_list.tasks #todo_list.load_tasks
  erb :task_index
end

get "/new_task" do
  @tasks = todo_list.tasks
  erb :new_task
end

post "/create_task" do
  content = params[:task_content]
  new_task = Task.new content
  todo_list.add_task new_task
  todo_list.save
  redirect('/tasks')
end

get "/complete/:id" do
  task_id = params[:id]
  task = todo_list.find_task_by_id task_id
  task.complete!

  todo_list.save
  redirect('/tasks')
end

get "/delete_task/:id" do
  task_id = params[:id]
  
  task = todo_list.delete_task task_id
  
  todo_list.save
  redirect('/tasks')
end

# get "/" do 
#   redirect('/profile') if session[:username]
#   erb(:form)
# end

# get '/logout' do
#   session[:username] = nil # o session.clear
#   redirect('/')
# end

# post '/' do
#   users = {"fernando" => "" ,"raul" => ""}
#   ia_valid = #si existe la clave en el hash && users[params[:username]] == params[:password]
#   session[:username] = params[:username] if is_valid
#   redirect('/profile')
# end

# get 'profile' do
#   @username = session[:username]
#   erb :profile
# end
