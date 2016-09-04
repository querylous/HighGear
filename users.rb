def create_users 
users = [
  {fname: "Jessica", lname: "Burks", emp_no: "450", email: "jessica.burks@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: true},
  {fname: "Jillian", lname: "Alden", emp_no: "1", email: "jillian.alden@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {fname: "Sarah", lname: "Uhden", emp_no: "57", email: "sarah.uhden@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {fname: "Monica", lname: "Hernandez", emp_no: "19", email: "monica.hernandez@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {fname: "David", lname: "Herrera", emp_no: "20", email: "david.herrera@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {fname: "Julia", lname: "Willis", emp_no: "59", email: "julia.willis@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {fname: "Deanna", lname: "Grant", emp_no: "17", email: "deanna.grant@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {fname: "Jenna", lname: "Jones", emp_no: "26", email: "jenna.jones@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {fname: "Greg", lname: "Diehl", emp_no: "10", email: "greg.diehl@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false},
  {fname: "Zoey", lname: "Dunn", emp_no: "12", email: "zoey.dunn@mcdbeau.me",store_number: "4453", password: "1234", password_confirmation: "1234", admin: false}
]


users.each do |u|
  x = User.new(u)
  x.save
end
end
