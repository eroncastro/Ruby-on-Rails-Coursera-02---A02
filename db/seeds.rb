# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Profile.destroy_all
TodoList.destroy_all
TodoItem.destroy_all

Profile.create!(
  [
    { first_name: 'Carly', last_name: 'Fiorina', birth_year: 1954, gender: 'female' },
    { first_name: 'Donald', last_name: 'Trump', birth_year: 1946, gender: 'male' },
    { first_name: 'Ben', last_name: 'Carson', birth_year: 1951, gender: 'male' },
    { first_name: 'Hillary', last_name: 'Clinton', birth_year: 1947, gender: 'female' }
  ]
)

Profile.find_each do |profile|
  profile.create_user!(
    username: profile.last_name,
    password_digest: Digest::MD5.new.digest(profile.last_name).force_encoding('UTF-8')
  )

  user = User.last

  TodoList.create!(
    user: user,
    list_name: user.username,
    list_due_date: 1.year.from_now.to_date
  )

  5.times do |i|
    TodoItem.create!(
      todo_list: user.todo_lists.last,
      due_date: 1.year.from_now.to_date,
      title: "#{user.username}#{i}",
      description: "#{user.username}#{i}",
      completed: false,
    )
  end
end

