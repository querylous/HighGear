def create_users 
users = [
  {id: 2, fname: "Jessica", lname: "Burks", emp_no: "450", email: "jessica.burks@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: true},
  {id: 3, fname: "Jillian", lname: "Alden", emp_no: "1", email: "jillian.alden@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {id: 4, fname: "Sarah", lname: "Uhden", emp_no: "57", email: "sarah.uhden@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {id: 5, fname: "Monica", lname: "Hernandez", emp_no: "19", email: "monica.hernandez@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {id: 6, fname: "David", lname: "Herrera", emp_no: "20", email: "david.herrera@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {id: 7, fname: "Julia", lname: "Willis", emp_no: "59", email: "julia.willis@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {id: 8, fname: "Deanna", lname: "Grant", emp_no: "17", email: "deanna.grant@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {id: 9, fname: "Jenna", lname: "Jones", emp_no: "26", email: "jenna.jones@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {id: 10, fname: "Greg", lname: "Diehl", emp_no: "10", email: "greg.diehl@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {id: 11, fname: "Zoey", lname: "Dunn", emp_no: "12", email: "zoey.dunn@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false}
]


users.each do |u|
  x = User.new(u)
  x.save
end
end
