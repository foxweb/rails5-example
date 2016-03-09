20.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.free_email,
    birthday: Faker::Date.between(40.years.ago, 20.years.ago),
    status: User.statuses.to_a[0..1].sample[0]
  )
end

100.times do
  Post.create(
    title: Faker::Hacker.say_something_smart,
    subtitle: Faker::Hipster.paragraph(1),
    body: Faker::Hipster.paragraphs(3, true).join(?\n),
    published_at: Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today),
    user: User.active.sample
  )
end

1000.times do
  Comment.create(
    user: User.active.sample,
    post: Post.all.sample,
    content:  Faker::Hipster.paragraph(1)
  )
end
