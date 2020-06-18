Activity.destroy_all
User.destroy_all

john_doe = User.create!(email: "john.doe@example.com", first_name: "John", last_name: "Doe", password: "123456")
Activity.create!(
  user: john_doe,
  title: "User registered",
  body: "New user registered with the next attributes: First Name - John, Last Name - Doe",
  event: :user_registered
)

darth_vader = User.create!(
  email: "darth.vader@example.com",
  first_name: "Darth",
  last_name: "Vader",
  password: "123456"
)
Activity.create!(
  user: darth_vader,
  title: "User registered",
  body: "New user registered with the next attributes: First Name - Darth, Last Name - Vader",
  event: :user_registered
)
