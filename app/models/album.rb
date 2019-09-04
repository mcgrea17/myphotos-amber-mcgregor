class Album < ApplicationRecord
    validates :name, presence: true
    belongs_to :location
    belongs_to :user
    has_many :albumstars
    has_many :people, through: :albumstars
    validates :endDate, numericality: {greater_than_equal_to: :startDate}

    def enddate_is_greater_or_equal
        if  ( startDate > endDate)
            puts "ERROR"
          errors.add(:endDate, 'End Date must be greater then or equal Start Date')
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