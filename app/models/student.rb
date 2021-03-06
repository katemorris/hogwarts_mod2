class Student <ApplicationRecord
  has_many :professor_students
  has_many :professors, through: :professor_students

  validates_presence_of :name
  validates_presence_of :age
  validates_presence_of :house

  def self.average_age
    average(:age).round(2)
  end

  def num_professors
    professors.count
  end
end
