require 'json'
require 'time'

class Task
  attr_accessor :id, :name, :deadline, :status

  def initialize(id, name, deadline, status = "incomplete")
    @id = id
    @name = name
    @deadline = deadline
    @status = status
  end

  # Перетворення задачі у формат JSON
  def to_json(*_args)
    { id: @id, name: @name, deadline: @deadline, status: @status }.to_json
  end

  # Статичний метод для створення задачі з JSON
  def self.from_json(json)
    data = JSON.parse(json)
    new(data['id'], data['name'], data['deadline'], data['status'])
  end

  # Перевірка, чи задача прострочена
  def overdue?
    Time.parse(@deadline) < Time.now
  end
end
