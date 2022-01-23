# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create([{ username: "admin", name: "Krusty Krab"}])
User.create([{ username: "moametal", name: "Moa"}])
User.create([{ username: "yuimetal", name: "Yui"}])
User.create([{ username: "sumetal", name: "Su"}])
user_moa = User.find_or_create_by(name: "Moa")
user_yui = User.find_or_create_by(name: "Yui")
user_su = User.find_or_create_by(name: "Su")
todo_tickets = Todo.create(title: "Buy Imagine Dragons tickets", done: false, notes: "Try to get front row seats")
todo_sing = Todo.create(title: "Singing practice", done: false)
todo_dance = Todo.create(title: "Dance practice", done: false)
todo_interview = Todo.create(title: "Interview with magazine", done: false)
tag_urgent = Tag.create(name: "Urgent", user: user_su)

todo_interview.taggings.create(tag: tag_urgent)
user_su.assignments.create(todo: todo_interview)
user_su.assignments.create(todo: todo_dance)
user_moa.assignments.create(todo: todo_dance)
user_yui.assignments.create(todo: todo_dance)
user_yui.assignments.create(todo: todo_tickets)
user_moa.assignments.create(todo: todo_tickets)
user_su.assignments.create(todo: todo_sing)