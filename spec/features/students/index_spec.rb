require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit /students' do
    before(:each) do
      @harry = Student.create(name: "Harry Potter" , age: 11 , house: "Gryffindor" )
      @malfoy = Student.create(name: "Draco Malfoy" , age: 12 , house: "Slytherin" )
      @longbottom = Student.create(name: "Neville Longbottom" , age: 11 , house: "Gryffindor" )

      snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
      hagrid = Professor.create(name: "Rubeus Hagrid", age: 38 , specialty: "Care of Magical Creatures")
      lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

      ProfessorStudent.create(student_id: @harry.id, professor_id: snape.id)
      ProfessorStudent.create(student_id: @harry.id, professor_id: hagrid.id)
      ProfessorStudent.create(student_id: @harry.id, professor_id: lupin.id)
      ProfessorStudent.create(student_id: @malfoy.id, professor_id: hagrid.id)
      ProfessorStudent.create(student_id: @malfoy.id, professor_id: lupin.id)
      ProfessorStudent.create(student_id: @longbottom.id, professor_id: snape.id)
    end

    it "I see a list of students with information" do
      visit '/students'

      expect(page).to have_content("#{@longbottom.name}: 1")
      expect(page).to have_content("#{@harry.name}: 3")
      expect(page).to have_content("#{@malfoy.name}: 2")
    end

    it "I see the list in alphabetical order" do
      visit '/students'

      expect(page.all('li')[0]).to have_content(@malfoy.name)
      expect(page.all('li')[1]).to have_content(@harry.name)
      expect(page.all('li')[2]).to have_content(@longbottom.name)
    end
  end
end
