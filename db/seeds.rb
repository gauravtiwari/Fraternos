owner = FactoryBot.create(:user)
fraternity = FactoryBot.create(:fraternity, :with_members, owner: owner)
