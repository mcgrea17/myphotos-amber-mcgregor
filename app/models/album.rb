class Album < ApplicationRecord
    validates :name, presence: true
    validate :enddate_is_greater_than_or_equal_to
    belongs_to :location
    belongs_to :user
    has_many :albumstars, dependent: :delete_all
    has_many :people, through: :albumstars
    

    def enddate_is_greater_than_or_equal_to
        if startDate.present? and endDate.present?
            if  ( startDate > endDate)
                errors.add(:endDate, 'End Date must be greater than or equal to Start Date')
            end
        end
    end
   

    def self.search(term, current_page)
        if term
         page(current_page).where('name LIKE ?', "%#{term}%").order('id DESC')
        else
         page(current_page).order('id DESC') 
        end
    end
    
    def self.search(term, page)
        if term
         where('name LIKE ?', "%#{term}%").paginate(page: page, per_page: 12).order('id DESC')
        else
         paginate(page: page, per_page: 12).order('id DESC') 
        end
    end
end