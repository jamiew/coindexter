class FormUser < User
  attr_accessor :current_password

  validates_presence_of   :email, if: :email_required?
  validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
  validates_format_of     :email, with: Devise.email_regexp, allow_blank: true, if: :email_changed?

  validates_presence_of     :password, if: :password_required?
  validates_confirmation_of :password, if: :password_required?
  validates_length_of       :password, within: Devise.password_length, allow_blank: false

  validates_presence_of     :first_name, if: :name_required?
  validates_confirmation_of :first_name, if: :name_required?

  validates_presence_of     :last_name, if: :name_required?
  validates_confirmation_of :last_name, if: :name_required?

  validates_presence_of     :username
  validates_confirmation_of :username

  validates_presence_of     :avatar
  validates_confirmation_of :avatar

  def password_required?
    return false if email.blank?
    !persisted? || !password.nil? || !password_confirmation.nil?
  end

  def email_required?
    true
  end

  def name_required?
    true
  end

end