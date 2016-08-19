module PaperTrail
  class Version
    def user
      User.find(whodunnit) if whodunnit
    end
  end
end