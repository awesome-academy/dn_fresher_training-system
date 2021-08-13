User.create!(name: 'Thai Hong Duc',
             email: 'duc111c@gmail.com',
             password: '123123',
             roles: 1)

50.times do |n|
  User.create!(name: "Example User #{n + 1}",
               email: "example#{n + 1}@gmail.com",
               password: '123456',
               roles:0)
end

# 20.times do |n|
#   CourseSubject.create!(course_id: 1,
#                         subject_id: n + 1,
#                         deadline: Time.zone.now)

#   UserCourse.create!(course_id: n + 1,
#                      user_id: 1,
#                      status: 1)
#   UserCourseSubject.create!(course_subject_id: n + 1,
#                             user_course_id: 1,
#                             status: 1)
# end
