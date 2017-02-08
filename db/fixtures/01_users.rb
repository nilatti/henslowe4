User.seed(:id,
  {id: 1, email: "alisha.huber@gmail.com", password: "superadmin", first_name: "Alisha", role: "superadmin", last_name: "Huber"},
  {id: 2, email: "nilatti@gmail.com", password: "testpassword", first_name: "Testing this user", role: "regular", last_name: "Test"},
  {id: 3, email: "admin@test.com", password: "administrator", first_name: "Admin", role: "regular", last_name: "Testuser"},
  {id: 4, email: "katherine@pcshakespeare.com", password: "katherine_mayberry", first_name: "Katherine", role: "regular", last_name: "Mayberry"},
  {id: 5, email: "scott@pcshakespeare.com", password: "scott_lange", first_name: "Scott", role: "regular", last_name: "Lange"},
  {id: 6, email: "bridget@pcshakespeare.com", password: "bridget_mccarthy", first_name: "Bridget", role: "regular", last_name: "McArthy"}
)
