owner = FactoryGirl.create(:user)
fraternity = FactoryGirl.create(:fraternity, :with_members, owner: owner)
