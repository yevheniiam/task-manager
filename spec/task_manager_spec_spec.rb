require 'rspec'
require_relative '../task_manager'

RSpec.describe TaskManager do
  let(:task_manager) { TaskManager.new('tasks.json') }

  before do
    # Очищаємо файл перед кожним тестом, щоб уникнути проблем з даними
    File.delete('tasks.json') if File.exist?('tasks.json')
  end

  describe '#add_task' do
    it 'додає задачу' do
      task_manager.add_task("Test Task", "2024-12-31")
      expect(task_manager.filter_by_status("incomplete").size).to eq(1)
    end
  end

  describe '#edit_task' do
    it 'редагує задачу' do
      task_manager.add_task("Test Task", "2024-12-31")
      task_manager.edit_task(0, name: "Updated Task", deadline: "2025-01-01", status: "complete")
      task = task_manager.filter_by_status("complete").first
      expect(task.name).to eq("Updated Task")
      expect(task.deadline).to eq("2025-01-01")
    end
  end

  describe '#delete_task' do
    it 'видаляє задачу' do
      task_manager.add_task("Test Task", "2024-12-31")
      task_manager.delete_task(0)
      expect(task_manager.filter_by_status("incomplete").size).to eq(0)
    end
  end

  describe '#filter_by_status' do
    it 'фільтрує задачі за статусом' do
      task_manager.add_task("Test Task 1", "2024-12-31", "incomplete")
      task_manager.add_task("Test Task 2", "2024-12-31", "complete")
      incomplete_tasks = task_manager.filter_by_status("incomplete")
      expect(incomplete_tasks.size).to eq(1)
      expect(incomplete_tasks.first.name).to eq("Test Task 1")
    end
  end

  describe '#filter_by_deadline' do
    it 'фільтрує задачі за дедлайном' do
      task_manager.add_task("Test Task 1", "2024-12-31")
      task_manager.add_task("Test Task 2", "2024-11-30")
      tasks_by_deadline = task_manager.filter_by_deadline("2024-12-31")
      expect(tasks_by_deadline.size).to eq(2)
    end
  end
end
