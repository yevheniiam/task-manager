require 'json'
require 'time'

class TaskManager
  def initialize(file_name)
    @file_name = file_name
    @tasks = []
    load_tasks
  end

  def add_task(name, deadline, status = "incomplete")
    @tasks << Task.new(name, deadline, status)
    save_tasks
  end

  def edit_task(index, name:, deadline:, status:)
    task = @tasks[index]
    return unless task
    task.name = name
    task.deadline = deadline
    task.status = status
    save_tasks
  end

  def delete_task(index)
    @tasks.delete_at(index)
    save_tasks
  end

  def filter_by_status(status)
    @tasks.select { |task| task.status == status }
  end

  def filter_by_deadline(deadline)
    deadline_time = Time.parse(deadline)
    @tasks.select { |task| Time.parse(task.deadline) <= deadline_time }
  end

  private

  def save_tasks
    File.open(@file_name, 'w') do |file|
      file.write(JSON.pretty_generate(@tasks.map(&:to_h)))
    end
  end

  def load_tasks
    return unless File.exist?(@file_name)

    file_content = File.read(@file_name)
    task_data = JSON.parse(file_content)
    @tasks = task_data.map { |data| Task.new(data['name'], data['deadline'], data['status']) }
  end
end

class Task
  attr_accessor :name, :deadline, :status

  def initialize(name, deadline, status = "incomplete")
    @name = name
    @deadline = deadline
    @status = status
  end

  def to_h
    { 'name' => @name, 'deadline' => @deadline, 'status' => @status }
  end
end
