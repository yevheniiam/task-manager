require_relative 'task_manager'

def display_menu
  puts "\nМеню:"
  puts "1. Додати задачу"
  puts "2. Видалити задачу"
  puts "3. Редагувати задачу"
  puts "4. Переглянути задачі"
  puts "5. Фільтрувати за статусом"
  puts "6. Фільтрувати за дедлайном"
  puts "7. Вихід"
  print "Виберіть дію: "
end

task_manager = TaskManager.new

loop do
  display_menu
  choice = gets.chomp.to_i

  case choice
  when 1
    print "Введіть назву задачі: "
    name = gets.chomp
    print "Введіть дедлайн (yyyy-mm-dd): "
    deadline = gets.chomp
    task_manager.add_task(name, deadline)

  when 2
    print "Введіть ID задачі для видалення: "
    id = gets.chomp.to_i
    task_manager.delete_task(id)

  when 3
    print "Введіть ID задачі для редагування: "
    id = gets.chomp.to_i
    print "Нова назва задачі: "
    name = gets.chomp
    print "Новий дедлайн (yyyy-mm-dd): "
    deadline = gets.chomp
    print "Новий статус (incomplete/complete): "
    status = gets.chomp
    task_manager.edit_task(id, name: name, deadline: deadline, status: status)

  when 4
    task_manager.list_tasks

  when 5
    print "Введіть статус для фільтрації (incomplete/complete): "
    status = gets.chomp
    tasks = task_manager.filter_by_status(status)
    tasks.each { |task| puts "#{task.id}. #{task.name} (#{task.deadline}) - #{task.status}" }

  when 6
    print "Введіть дедлайн для фільтрації (yyyy-mm-dd): "
    deadline = gets.chomp
    tasks = task_manager.filter_by_deadline(deadline)
    tasks.each { |task| puts "#{task.id}. #{task.name} (#{task.deadline}) - #{task.status}" }

  when 7
    puts "До побачення!"
    break

  else
    puts "Невірний вибір. Спробуйте ще раз."
  end
end
