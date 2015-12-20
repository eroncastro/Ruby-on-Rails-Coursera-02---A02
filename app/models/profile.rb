class Profile < ActiveRecord::Base
  belongs_to :user

  validate :only_first_name_or_only_last_name_is_null, :male_cannot_have_first_name_as_sue
  validates :gender, inclusion: { in: ['male', 'female'] }

  def only_first_name_or_only_last_name_is_null
    return if first_name.present? || last_name.present?

    [:first_name, :last_name].each do |field|
      errors.add(field, 'first_name and last_name cannot be both nil')
    end
  end

  def male_cannot_have_first_name_as_sue
    if gender == 'male' && first_name == 'Sue'
      errors.add(:first_name, 'A male person cannot have first name Sue.')
    end
  end
end
